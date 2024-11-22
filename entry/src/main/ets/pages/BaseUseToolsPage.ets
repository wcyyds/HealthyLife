import { BaseUseToolsClass } from "../model/BaseUseToolsClass"
import { bufferToString } from "../util/BufferUtil"
import { BaseUseToolItem } from "../views/BaseUseToolsView"

@Component
export struct BaseUseToolsPage{
  TAG: string = '**BaseUseToolsPage'
  @State baseUseToolsList: BaseUseToolsClass[] = []

  aboutToAppear(): void {
    this.getBaseUseToolsDataFromJSON()
  }

  getBaseUseToolsDataFromJSON(){
    getContext(this).resourceManager.getRawFileContent('BaseUseToolsData.json').then(value => {
      this.baseUseToolsList = JSON.parse(bufferToString(value)) as BaseUseToolsClass[];
    })
  }

  build() {
    Column(){
      Text('基础使用')
        .fontColor('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16, right: 16 })
        .width('100%')
      List({ space: 12 }) {
        ForEach(this.baseUseToolsList, (item: BaseUseToolsClass) => {
          ListItem() {
            BaseUseToolItem({ baseUseToolItem: item })
              .onClick(() => {
                console.info(this.TAG, '基础工具点击')
              })
          }
        }, (item: BaseUseToolsClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
    }
    .margin({ top: 18 })
  }
}