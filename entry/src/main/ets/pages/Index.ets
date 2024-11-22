import { BaseUseToolsPage } from './BaseUseToolsPage';
import { NewsPage } from './NewsPage';
import { WeatherPage } from './WeatherPage';

@Entry
@Component
export struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
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
  }
}

function Weatherpage() {
  throw new Error('Function not implemented.');
}
