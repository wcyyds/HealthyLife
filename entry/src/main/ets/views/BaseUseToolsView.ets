import { BaseUseToolsClass } from "../model/baseusertoolsmodel/BaseUseToolsClass"
import { router } from "@kit.ArkUI"

@Component
export struct BaseUseToolItem{

  @Prop baseUseToolItem: BaseUseToolsClass

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Image($r(this.baseUseToolItem.image))
        .height('100%')
        .width('100%')
        .borderRadius(16)

      Column() {
        Text(this.baseUseToolItem.title)
          .fontSize(30)
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .fontColor('#ff000000')
          .backgroundColor('#ffffffff')
          .fontWeight(600)
          .margin({ top: 150 })
      }
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)
      .margin({ right: 12 })
      .onClick(() => {
        router.pushUrl({url: this.baseUseToolItem.url})
      })
    }
    .width('100%')
    .height('100%')
    .borderRadius(16)
  }
}