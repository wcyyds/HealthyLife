import { BaseUseToolsClass } from "../model/baseusertoolsmodel/BaseUseToolsClass"
import { bufferToString } from "../util/BufferUtil"
import { BaseUseToolItem } from "../views/BaseUseToolsView"
import { abilityAccessCtrl } from "@kit.AbilityKit"

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
    Stack({ alignContent: Alignment.BottomEnd }){
      Column(){
        Text('基础使用')
          .fontColor('#182431')
          .fontSize(25)
          .fontWeight(500)
          .fontFamily('HarmonyHeiTi-medium')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, right: 16 })
          .width('100%')
          .margin({bottom: 8})
        Grid() {
          ForEach(this.baseUseToolsList, (item: BaseUseToolsClass) => {
            GridItem() {
              BaseUseToolItem({ baseUseToolItem: item })
                .onClick(() => {
                  console.info(this.TAG, '基础工具点击')
                })
            }
            .width('50%')
            .aspectRatio(1)
          }, (item: BaseUseToolsClass) => item.id)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap('8vp')
        .rowsGap('12vp')
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}