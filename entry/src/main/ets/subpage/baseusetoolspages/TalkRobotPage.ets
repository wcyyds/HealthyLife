import { it } from '@ohos/hypium';
import { MsgInput, MsgOutput, WenXinReturn } from '../../model/baseusertoolsmodel/TalkRobotClass';
import { http } from '@kit.NetworkKit';
import document from '@ohos.document';

@Entry
@Component
struct TalkRobotPage {
  @State message: string = '你现在是一个专注于老年人问题的AI小助手，你要帮助老年人，请使用中文回答。';
  @State WXReturn: WenXinReturn = new WenXinReturn()
  @State MsgResult: MsgOutput = new MsgOutput()
  @State MsgInputSample: MsgInput = new MsgInput()
  @State MsgArray: Array<MsgInput> = []

  aboutToAppear(): void {
    this.getAnswer()
  }

  getAnswer() {
    console.info("wcy", "start getTextToSpeechGet")
    let httpRequest = http.createHttp();
    httpRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        header: {
          'Authorization': 'Bearer ' + 'sk-19a2c821f181492881443cd443d43fd6',
          'Content-Type': 'application/json'
        },
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "model": "qwen-plus",
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant."
            },
            {
              "role": "user",
              "content": this.message
            }
          ]
        }
      }).then((res: http.HttpResponse) => {
      console.info("wcy", "getTextToSpeechGet res: " + res.result.toString())
      let MsgReturn: WenXinReturn = JSON.parse(res.result.toString())
      this.MsgResult.content = MsgReturn.choices[0].message.content
      let MsgIn: MsgInput = new MsgInput()
      MsgIn.role = 'assistant'
      MsgIn.content = this.MsgResult.content
      MsgIn.id = MsgReturn.choices[0].index.toString()
      this.MsgArray.push(MsgIn)
    });
  }

  build() {
    Column() {
      Column() {
        Scroll() {
          Column() {
            ForEach(this.MsgArray, (item: MsgInput, index: number) => {
              if(item.role == 'user'){
                Row() {
                  Text(item.content)
                    .width("50%")
                    .padding(15.5)
                    .backgroundColor("#95EC69")
                    .borderRadius(4)
                  Image($r("app.media.tool_pedometer"))
                    .backgroundColor(Color.White)
                    .objectFit(ImageFit.Fill)
                    .width(50)
                    .height(50)
                    .borderRadius(4)
                    .margin({ left: 8, right: 8 })
                }
                .margin({ top: index === 0 ? 0 : 12 })
                .width("100%")
                .alignItems(VerticalAlign.Top)
                .justifyContent(FlexAlign.End)
              } else if (item.role == 'assistant') {
                Row() {
                  Image($r("app.media.tool_robot"))
                    .backgroundColor(Color.White)
                    .objectFit(ImageFit.Fill)
                    .width(50)
                    .height(50)
                    .borderRadius(4)
                    .margin({ left: 8, right: 8 })
                  Text(item.content)
                    .width("50%")
                    .padding(15.5)
                    .backgroundColor(Color.White)
                    .borderRadius(4)
                    .margin({ right: 0 })
                }
                .margin({ top: index === 0 ? 0 : 12 })
                .width("100%")
                .alignItems(VerticalAlign.Top)
                .justifyContent(FlexAlign.Start)
              }
            }, (item: MsgInput) => item.id)
          }
          .padding({ top: 12, bottom: 12})
        }
        .width("100%")
      }
      .backgroundColor("#EDEDED")
      .layoutWeight(1)

      Row() {
        TextInput({
          placeholder: "可以在这里问我问题"
        })
          .backgroundColor(Color.White)
          .layoutWeight(8)
          .height(60)
          .onChange((msg: string) => {
            this.message = msg
          })
          .margin({ top: 10, bottom: 10, left: 4, right: 4 })
        Button("提交")
          .margin(4)
          .layoutWeight(2)
          .onClick(() => {
            let MsgIn: MsgInput = new MsgInput()
            MsgIn.id = this.MsgArray.length.toString()
            MsgIn.role = "user"
            MsgIn.content = this.message
            this.MsgArray.push(MsgIn)
            this.getAnswer()
            this.message = ""
          })
      }
      .backgroundColor("#F7F7F7")
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

