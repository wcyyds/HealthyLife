import { common, wantAgent } from "@kit.AbilityKit";
import { backgroundTaskManager } from "@kit.BackgroundTasksKit";
import Logger from "./Logger";

const TAG = 'Steps Utils';

export default  class BackgroundUtil {

  static getBackgroundImage(weatherCondition: string): Resource {
    switch (weatherCondition.toLowerCase()) {
      case '晴':
        return $r('app.media.sunny_background');
      case '多云':
        return $r('app.media.default_background1');
      case '阴':
        return $r('app.media.overcast_background');
      case '雨':
      case '小雨':
      case '中雨':
      case '大雨':
        return $r('app.media.rainy_background');
      case '雪':
      case '小雪':
      case '中雪':
      case '大雪':
        return $r('app.media.snowy_background');
      default:
        return $r('app.media.default_background');
    }
  }

  /**
   * Start background task.
   *
   * @param context
   */
  public static startContinuousTask(context: common.UIAbilityContext): void {
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: context.abilityInfo.bundleName,
          abilityName: context.abilityInfo.name
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 0,
      wantAgentFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
    };

    wantAgent.getWantAgent(wantAgentInfo).then((wantAgentObj) => {
      try {
        backgroundTaskManager.startBackgroundRunning(context,
          backgroundTaskManager.BackgroundMode.LOCATION, wantAgentObj).then(() => {
          Logger.info(TAG, 'startBackgroundRunning succeeded');
        }).catch((err: Error) => {
          Logger.error(TAG, `startBackgroundRunning failed Cause:  ${JSON.stringify(err)}`);
        });
      } catch (error) {
        Logger.error(TAG, `stopBackgroundRunning failed. error: ${JSON.stringify(error)} `);
      }
    });
  }

  /**
   * Stop background task.
   *
   * @param context
   */
  public static stopContinuousTask(context: common.UIAbilityContext): void {
    try {
      backgroundTaskManager.stopBackgroundRunning(context).then(() => {
        Logger.info(TAG, 'stopBackgroundRunning succeeded');
      }).catch((err: Error) => {
        Logger.error(TAG, `stopBackgroundRunning failed Cause:  ${JSON.stringify(err)}`);
      });
    } catch (error) {
      Logger.error(TAG, `stopBackgroundRunning failed. error: ${JSON.stringify(error)} `);
    }
  }

}

