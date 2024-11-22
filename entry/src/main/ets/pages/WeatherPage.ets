@Component
export struct WeatherPage {
  @State message: string = 'Hello World';

  PAG: string = '**WeatherPage'

  onPageShow(): void {
    console.info(this.PAG, 'onpageShow')
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('WeatherHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#ff00ff88')
  }
}