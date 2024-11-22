import { BaseUseToolsClass } from "../model/BaseUseToolsClass"
import { router } from "@kit.ArkUI"

@Component
export struct BaseUseToolItem{

  @Prop baseUseToolItem: BaseUseToolsClass

  build() {
    Row() {
      Column() {
        Text(this.baseUseToolItem.title)
          .height(19)
          .width('100%')
          .fontSize(14)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })
        Button('跳转页面')
          .onClick(() => {
            router.pushUrl({url: this.baseUseToolItem.url})
          })
      }
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 12 })

      Image($r(this.baseUseToolItem.image))
        .objectFit(ImageFit.Cover)
        .height(64)
        .width(108)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}