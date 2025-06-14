import { CommonConstants } from '../../constants/CommonConstants';
import { intl } from '@kit.LocalizationKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { sensor } from '@kit.SensorServiceKit';
import StepsUtil from '../../util/StepsUtil';
import NumberUtil from '../../util/NumberUtil';
import { geoLocationManager } from '@kit.LocationKit';
import Logger from '../../util/Logger';
import LocationUtil from '../../util/LocationUtil';
import { CompletionStatus } from '../../views/baseusetoolsviews/pedometerpageviews/CompletionStatus';
import { CurrentSituation } from '../../views/baseusetoolsviews/pedometerpageviews/CurrentSituation';
import BackgroundUtil from '../../util/BackgroundUtil';
import { promptAction } from '@kit.ArkUI';

const TAG = 'PedometerPage';

@Entry
@Component
struct PedometerPage {
  @State currentSteps: string = CommonConstants.INITIALIZATION_VALUE;
  @Provide stepGoal: string = '';
  @State oldSteps: string = '';
  @State startPosition: string = '';
  @State currentLocation: string = '';
  @State locale: string = new intl.Locale().language;
  @State latitude: number = 0;
  @State longitude: number = 0;
  @State progressValue: number = 0;
  @State isStart: boolean = false;
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  // 传感器回调
  private sensorCallback: (data: sensor.PedometerResponse) => void = (data: sensor.PedometerResponse) => {
    try {
      if (this.isStart) {
        if (StepsUtil.checkStrIsEmpty(this.oldSteps)) {
          this.oldSteps = data.steps.toString();
          StepsUtil.putStorageValue(CommonConstants.OLD_STEPS, this.oldSteps);
        } else {
          this.currentSteps = (data.steps - NumberUtil._parseInt(this.oldSteps, 10)).toString();
        }
      } else {
        this.currentSteps = data.steps.toString();
      }

      if (StepsUtil.checkStrIsEmpty(this.stepGoal) || !this.isStart) {
        return;
      }
      StepsUtil.putStorageValue(CommonConstants.CURRENT_STEPS, this.currentSteps);
      this.progressValue = StepsUtil.getProgressValue(NumberUtil._parseInt(this.stepGoal, 10),
        NumberUtil._parseInt(this.currentSteps, 10));
      StepsUtil.putStorageValue(CommonConstants.PROGRESS_VALUE_TAG, String(this.progressValue));
    } catch (err) {
      Logger.error(TAG, 'Sensor on err' + JSON.stringify(err));
    }
  }

  // 获取位置信息
  private getGeolocation: (location: geoLocationManager.Location) => void = (location: geoLocationManager.Location) => {
    if (this.latitude === location.latitude && this.longitude === location.longitude) {
      return;
    }
    this.latitude = location.latitude;
    this.longitude = location.longitude;
    let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
      'locale': this.locale.toString().includes('zh') ? 'zh' : 'en',
      'latitude': this.latitude,
      'longitude': this.longitude,
      'maxItems': 1
    };
    geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then(data => {
      if (data[0].placeName) {
        this.currentLocation = data[0].placeName;
      }
    }).catch((err: Error) => {
      Logger.error(TAG, 'GetAddressesFromLocation err ' + JSON.stringify(err));
    });
  }

  onPageShow() {
    this.init();
    this.requestPermissions();
  }

  onPageHide() {
    sensor.off(sensor.SensorId.PEDOMETER);
  }

  init() {
    StepsUtil.getStorageValue(CommonConstants.IS_START).then((res: string) => {
      if (res === CommonConstants.TRUE) {
        this.isStart = true;
        StepsUtil.getStorageValue(CommonConstants.CURRENT_STEPS).then((res: string) => {
          if (StepsUtil.checkStrIsEmpty(res)) {
            return;
          }
          this.currentSteps = res;
        });

        StepsUtil.getStorageValue(CommonConstants.PROGRESS_VALUE_TAG).then((res: string) => {
          if (StepsUtil.checkStrIsEmpty(res)) {
            return;
          }
          this.progressValue = NumberUtil._parseInt(res, 10);
        });

        StepsUtil.getStorageValue(CommonConstants.START_POSITION).then((res: string) => {
          if (StepsUtil.checkStrIsEmpty(res)) {
            return;
          }
          this.startPosition = res;
        });

        StepsUtil.getStorageValue(CommonConstants.OLD_STEPS).then((res: string) => {
          if (StepsUtil.checkStrIsEmpty(res)) {
            return;
          }
          this.oldSteps = res;
        });
      } else {
        this.isStart = false;
      }
    })

    StepsUtil.getStorageValue(CommonConstants.STEP_GOAL).then((res: string) => {
      if (StepsUtil.checkStrIsEmpty(res)) {
        return;
      }
      this.stepGoal = res;
    });
  }

  // 请求权限
  requestPermissions(): void {
    let atManager = abilityAccessCtrl.createAtManager();
    try {
      atManager.requestPermissionsFromUser(this.context, CommonConstants.REQUEST_PERMISSIONS).then((data) => {
        if (data.authResults[0] !== 0 || data.authResults[1] !== 0) {
          return;
        }
        const that = this;
        try {
          sensor.on(sensor.SensorId.PEDOMETER, this.sensorCallback, { interval: CommonConstants.SENSOR_INTERVAL });

        } catch (err) {
          console.error('On fail, errCode: ' + JSON.stringify(err));
        }

        LocationUtil.geolocationOn(this.getGeolocation);
      }).catch((err: Error) => {
        Logger.error(TAG, 'requestPermissionsFromUser err' + JSON.stringify(err));
      })
    } catch (err) {
      Logger.error(TAG, 'requestPermissionsFromUser err' + JSON.stringify(err));
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      CompletionStatus({
        progressValue: $progressValue
      })

      CurrentSituation({
        currentSteps: this.currentSteps,
        startPosition: this.startPosition,
        currentLocation: this.currentLocation
      })

      Row() {
        Button(this.isStart ? $r('app.string.stop') : $r('app.string.start'))
          .width($r('app.float.start_button_width'))
          .height($r('app.float.start_button_height'))
          .borderRadius($r('app.float.start_button_radius'))
          .backgroundColor('#0A59F7')
          .fontSize($r('app.float.start_font_size'))
          .fontColor(Color.White)
          .fontWeight(CommonConstants.BIG_FONT_WEIGHT)
          .onClick(() => {
            if (this.isStart) {
              this.isStart = false;
              this.oldSteps = '';
              StepsUtil.CleanStepsData();
              BackgroundUtil.stopContinuousTask(this.context);
            } else {
              if (this.stepGoal === '' || this.currentLocation === '') {
                promptAction.showToast({ message: CommonConstants.WAIT });
              } else {
                this.isStart = true;
                this.startPosition = this.currentLocation;
                StepsUtil.putStorageValue(CommonConstants.START_POSITION, this.startPosition);
                this.currentSteps = CommonConstants.INITIALIZATION_VALUE;
                this.progressValue = 0;
                BackgroundUtil.startContinuousTask(this.context);
              }
            }
            StepsUtil.putStorageValue(CommonConstants.IS_START, String(this.isStart));
          })
      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r('app.float.button_height'))
      .margin({ top: $r('app.float.button_margin_top') })
      .justifyContent(FlexAlign.Center)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .backgroundColor(Color.White)
  }
}