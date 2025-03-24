import { BaseSetClass } from "../model/BaseSetClass";
import { bufferToString } from "../util/BufferUtil";

@Entry
@Component
struct SetPage {
  TAG: string = '**SetPage'
  @State baseUseToolsList: BaseSetClass[] = []

  aboutToAppear(): void {
    this.getBaseSetDataFromJSON()
  }

  getBaseSetDataFromJSON() {
    getContext(this).resourceManager.getRawFileContent('BaseSetClassData.json').then(value => {
      this.baseUseToolsList = JSON.parse(bufferToString(value)) as BaseSetClass[];
    })
  }

  build() {
    Column() {
      Row() {
        Text('nihao')
          .id('SetPageHelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#000000')
        Text('nihao')
          .id('SetPageHelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Toggle({type:ToggleType.Switch, isOn: false})
          .selectedColor('#007DFF')
          .switchPointColor('#ffffffff')
          .switchStyle({
            pointRadius: 20,
            trackBorderRadius: 20,
            pointColor: '#ffb3b3b3'
          })
          .onChange((isOn: boolean) => {
            console.info(this.TAG,'Component status:' + isOn)
          })
      }

      Grid() {
        ForEach(this.baseUseToolsList, (item: BaseSetClass) => {
          GridItem() {
            BaseSetItem({ baseSetItem: item })
              .onClick(() => {
                switchfuns(item)
              })
          }
        }, (item: BaseSetClass) => item.id)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .scrollBar(BarState.Off)
      .height(400)
      .padding({ top: 0, left: 16, right: 16, bottom: 32 })
      .backgroundColor('#ffffbbbb')
      .height('100%')
      .width('100%')
    }
  }
}

@Preview
@Component
export struct BaseSetItem {
  @Prop baseSetItem: BaseSetClass;

  build() {
    Column() {
      Row(){
        Image($r(this.baseSetItem.image))
          .width('50%')
          .borderRadius(16)
        Text(this.baseSetItem.title)
          .width('50%')
          .fontSize(16)
          .maxLines(1)
          .fontWeight(400)
          .textAlign(TextAlign.End)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      Text(this.baseSetItem.title)
        .width('100%')
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .fontWeight(400)
        .maxLines(1)
        .fontColor('rgba(0, 0, 0, 0.6)')
        .padding({ left: 12, right: 12 })
        .margin({ top: 12 })
    }
    .width('100%')
    .borderRadius(16)
    .margin({top: 16})
    .padding({top: 10, bottom: 10, left: 10, right: 10})
    .backgroundColor(Color.White)
  }
}

function switchfuns(item: BaseSetClass) {
  let TAG: string = '**SetPage'
  switch (item.title) {
    case "蓝牙":
      console.info(TAG, "打开蓝牙")
      item.state = '蓝牙##########'
      item.image = 'app.media.power_on'
      break
    case " ":
      console.info(TAG, "")
      break
    default:
      console.info(TAG, '最后的兜底')
  }
}