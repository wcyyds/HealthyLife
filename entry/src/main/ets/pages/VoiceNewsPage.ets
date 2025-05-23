import { webview } from '@kit.ArkWeb';

@Component
export struct VoiceNewsPage {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    console.info("123wcy", 'abouttoDisappear')
  }

  convertText(text: string): string {
    console.info("123wcy", 'extractNumbers')
    // 定义正则表达式，匹配英文符号、字母和数字
    let pattern: RegExp = /[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@[\\\]^_`{|}~]/g;
    // 使用 replace 方法将匹配到的内容替换为空字符串
    let result: string = text.replace(pattern, '');
    return result;
  }

  private webviewController = new webview.WebviewController();

  build() {
    RelativeContainer() {
      Web({ src: "https://www.baidu.com", controller: this.webviewController })
        .onPageBegin((event) => {
          // 网页开始加载时触发该回调
        })
        .onPageEnd((event) => {
          // 网页加载完成时触发该回调
        })
        .onErrorReceive((event) => {
          // 网页加载遇到错误时触发该回调. 无网下会触发该回调
        })
        .onHttpErrorReceive((event) => {
          // 网页加载资源遇到的HTTP错误（响应码>=400)时触发该回调
        })
        .onProgressChange((event) => {
          // 网页加载进度变化时触发该回调
        })
    }
    .height('100%')
    .width('100%')
  }
}