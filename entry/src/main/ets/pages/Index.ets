import { BaseUseToolsPage } from './BaseUseToolsPage';
import { NewsPage } from './NewsPage';
import { WeatherPage } from './WeatherPage';
import { calendarManager } from '@kit.CalendarKit';
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import { VoiceNewsPage } from './VoiceNewsPage';

@Entry
@Component
export struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  aboutToAppear(): void {
    initializeCalendarManager()
  }

  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
        .width(30)
        .height(30)
      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(20)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
        .margin({top: 8})
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(targetIndex);
    })
  }

  build() {
    Stack() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        TabContent() {
          BaseUseToolsPage()
        }
        .tabBar(this.tabBarBuilder('基础使用', 0, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))

        TabContent() {
          WeatherPage()
        }
        .tabBar(this.tabBarBuilder('天气预报', 1, $r('app.media.ic_02_on'), $r('app.media.ic_02_off')))

        TabContent() {
          NewsPage()
        }
        .tabBar(this.tabBarBuilder('即时新闻', 2, $r('app.media.ic_03_on'), $r('app.media.ic_03_off')))
      }
      .vertical(false)
      .divider({
        strokeWidth: 0.5,
        color: '#0D182431'
      })
      .scrollable(false)
      .backgroundColor('#F1F3F5')
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}

let calendarMgr: calendarManager.CalendarManager | null = null;
let mContext: common.UIAbilityContext | null = null;

async function initializeCalendarManager() {
  try {
    const permissions: Permissions[] = ['ohos.permission.READ_CALENDAR', 'ohos.permission.WRITE_CALENDAR'];
    const atManager = abilityAccessCtrl.createAtManager();
    await atManager.requestPermissionsFromUser(mContext, permissions);
    console.info('权限请求成功');
    calendarMgr = calendarManager.getCalendarManager(mContext);
    console.info('CalendarManager 初始化成功');
  } catch (error) {
    console.error('初始化失败:', error);
  }
}
