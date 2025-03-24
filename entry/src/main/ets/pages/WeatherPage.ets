import { geoLocationManager } from "@kit.LocationKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { http } from '@kit.NetworkKit';
import { JSON } from "@kit.ArkTS";

@Component
export struct WeatherPage {
  @State message: string = 'Hello World';

  PAG: string = '**WeatherPage'

  aboutToAppear(): void {
    console.info(this.PAG, 'aboutToAppear')
    getLocation()
    getAccessToken()
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

function getLocation(){
  console.info("wcy", "start getLocation")
  const req = http.createHttp()
  req.request(
    'http://v1.yiketianqi.com/free/week?unescape=1&appid=38383686&appsecret=KWo8NTsJ',
    {
      method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
    }
  ).then((res) => {
    console.info("wcy", "getLocation data: " + JSON.stringify(res))
  })
}

/**
 * 使用 AK，SK 生成鉴权签名（Access Token）
 * @return string 鉴权签名信息（Access Token）
 */
function getAccessToken() {
  console.info("wcy", "start getAccessToken")
  const AK = "ACcO2DqkPErw6CClGwrGB0OG"
  const SK = "P9sI0gfpYvA549QqPKPx5SAPNKcTMW3N"
  // 每一个httpRequest对应一个HTTP请求任务，不可复用
  let req = http.createHttp();
  let respone = req.request(
    'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=' + AK + '&client_secret=' + SK,
    {
      method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
    }
  ).then((res: http.HttpResponse) => {
    console.info("wcy", "getAccessToken data:1 " + JSON.stringify(res))
  })
}