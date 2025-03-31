import { geoLocationManager } from "@kit.LocationKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { http } from '@kit.NetworkKit';
import { JSON } from "@kit.ArkTS";
import { loginComponentManager } from "@kit.AccountKit";
import { media } from "@kit.MediaKit";
import { audio } from "@kit.AudioKit";
import LocationUtil from "../util/LocationUtil";
import WeatherItem from "../model/weathermodel/WeatherItem";
import City from "../model/weathermodel/City";
import PreferenceUtil from "../util/PreferenceUtil";
import { CommonConstants } from "../constants/CommonConstants";
import HttpGet from "../util/HttpGet";
import BackgroundUtil from "../util/BackgroundUtil";
import { CityWeather } from "../views/weatherviews/Record/CityWeather";
import TopNavBar from "../views/weatherviews/Record/TopNavBar";

@Entry({routeName: 'WeatherPage'})
@Component
export struct WeatherPage {
  @Watch('updateBackground')
  @StorageLink('currentCityIndex') currentCityIndex: number = 0
  @StorageLink('cities') cities: City<WeatherItem>[] = []
  @State myBackgroundImage: Resource = $r('app.media.default_background1')
  @State judge: boolean = true
  PAG: string = '**WeatherPage'

  async aboutToAppear(): Promise<void> {
    console.info('wcy ' + this.PAG, 'aboutToAppear')
    getLocation()
    getAccessToken()

    if (this.judge) {
      await this.loadCityData()
      this.judge = false
      AppStorage.setOrCreate('cities', this.cities)
    }
    this.updateBackground()
  }

  //加载城市信息
  async loadCityData() {
    try {
      const currentCityInfo = await LocationUtil.getCurrentCityInfo();
      const savedCities = await PreferenceUtil.getAllCities(CommonConstants.CITY_INFO);
      const currentCityExists = savedCities.some(city => city.id === currentCityInfo.id);
      if (!currentCityExists) {
        savedCities.unshift(currentCityInfo);
      }
      let data = savedCities.map(async city => {
        let NowWeather: WeatherItem = await HttpGet.getCityWeatherData('weather', city.id, 'now') as WeatherItem
        return new City(city.name, city.id, NowWeather)
      });
      this.cities = await Promise.all(data)
      console.log('wcy cities:', this.cities[0].name);
      await PreferenceUtil.putCity(CommonConstants.CITY_INFO, currentCityInfo.name, currentCityInfo.id)
    } catch (error) {
      console.error('wcy Failed to load city data:', error);
    }
  }

  //更新天气背景
  updateBackground() {
    if (this.cities.length > 0 && this.cities[this.currentCityIndex].detail) {
      const weatherCondition = this.cities[this.currentCityIndex].detail?.now?.text || ''
      this.myBackgroundImage = BackgroundUtil.getBackgroundImage(weatherCondition);
    }
  }

  @Builder
  WeatherContent() {
    Stack() {
      Image(this.myBackgroundImage)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      Scroll() {
        Column() {
          CityWeather({ myBackgroundImage: $myBackgroundImage })
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)

      if (this.cities.length > this.currentCityIndex) {
        TopNavBar()
      } else {
        Text('有问题')
      }
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Column() {
      if (this.cities.length > 0) {
        this.WeatherContent()
      } else {
        Column() {
          Text("加载中...123")
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#ff008080')
  }
}

function getLocation() {
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

let accessToken = ""

let taskList: Array<number> = []

let text: Array<string> = ["你好，世界！"]

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
  req.request(
    'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=' + AK + '&client_secret=' + SK,
    {
      method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
    }
  ).then((res: http.HttpResponse) => {
    let baseData = JSON.parse(res.result.toString()) as BaseAccessTokenClass
    console.info("wcy", "getAccessToken data:3 " + baseData.access_token)
    accessToken = baseData.access_token
    getTextToSpeechCreate()
  });
}

class BaseAccessTokenClass {
  access_token: string = "";
  refresh_token: string = "";
  expires_in: string = "";
  scope: string = "";
  session_key: string = "";
  session_secret: string = "";
}

function getTextToSpeechCreate() {
  console.info("wcy", "start getTextToSpeech")
  console.info("wcy", "start accessToken" + accessToken)
  let httpRequest = http.createHttp();
  httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    "https://aip.baidubce.com/rpc/2.0/tts/v1/create?access_token=" + accessToken,
    {
      method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET

      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "text": text,
        "format": "mp3-16k",
        "lang": "zh"
      }
    }).then((res: http.HttpResponse) => {
    console.info("wcy", "getTextToSpeechCreate res: " + res.result.toString())
    let baseData = JSON.parse(res.result.toString()) as BaseTextToSpeechCreateClass
    taskList.push(baseData.task_id)
    getTextToSpeechGet()
  });
}

class BaseTextToSpeechCreateClass {
  log_id: number = -1;
  task_id: number = -1;
  task_status: string = "";
}

function getTextToSpeechGet() {
  console.info("wcy", "start getTextToSpeechGet")
  let httpRequest = http.createHttp();
  httpRequest.request(
    // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
    "https://aip.baidubce.com/rpc/2.0/tts/v1/query?access_token=" + accessToken,
    {
      method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET

      // 当使用POST请求时此字段用于传递内容
      extraData: {
        "task_ids": [taskList[0]]
      }
    }).then((res: http.HttpResponse) => {
    console.info("wcy", "getTextToSpeechGet res: " + res.result.toString())
    console.info("wcy", "getTextToSpeechGet taskList: " + taskList[0])
    let baseData = JSON.parse(res.result.toString()) as BaseTextToSpeechGetClass
    // if(baseData.tasks_info[0].task_status == "Running"){
    //   getTextToSpeechGet()
    // }
    avPlayerLiveDemo()
  });
}

class BaseTextToSpeechGetClass {
  error_msg: string = ""
  log_id: number = -1;
  tasks_info: Array<BaseTextToSpeechGetResultTasksInfoClass> = [];
}

class BaseTextToSpeechGetResultTasksInfoClass {
  task_id: string = ""
  task_status: string = ""
  task_result: BaseTextToSpeechGetResultTasksInfoTaskResultClass = {
    speech_url: ""
  }
}

class BaseTextToSpeechGetResultTasksInfoTaskResultClass {
  speech_url: string = ""
}

// 以下demo为通过url设置网络地址来实现播放直播码流的demo
async function avPlayerLiveDemo() {
  // 创建avPlayer实例对象
  let avPlayer: media.AVPlayer = await media.createAVPlayer();
  // 创建状态机变化回调函数
  setAVPlayerCallback(avPlayer);
  isSeek = false; // 不支持seek操作
  avPlayer.url =
    'http://aipe-speech.bj.bcebos.com/text_to_speech/2025-03-27/67e504e19947de00018c89d5/speech/0.mp3?authorization=bce-auth-v1%2FALTAKjI91nE52nvtDNRgFlUCVz%2F2025-03-27T07%3A57%3A26Z%2F259200%2F%2F018273b61d6ac6040f4c5f3939fe569f21409c5959a73f2ad88f34c8014254ad';
}

let count: number = 0;
let isSeek: boolean = true; // 用于区分模式是否支持seek操作
let fileSize: number = -1;
let fd: number = 0;

// 注册avplayer回调函数
function setAVPlayerCallback(avPlayer: media.AVPlayer) {
  // seek操作结果回调函数
  avPlayer.on('seekDone', (seekDoneTime: number) => {
    console.info(`AVPlayer seek succeeded, seek time is ${seekDoneTime}`);
  });
  // error回调监听函数,当avPlayer在操作过程中出现错误时调用 reset接口触发重置流程
  avPlayer.on('error', (err: BusinessError) => {
    console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
    avPlayer.reset(); // 调用reset重置资源，触发idle状态
  });
  // 状态机变化回调函数
  avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
    switch (state) {
      case 'idle': // 成功调用reset接口后触发该状态机上报
        console.info('AVPlayer state idle called.');
        avPlayer.release(); // 调用release接口销毁实例对象
        break;
      case 'initialized': // avplayer 设置播放源后触发该状态上报
        console.info('AVPlayer state initialized called.');
        avPlayer.audioRendererInfo = {
          usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
          rendererFlags: 0
        };
        avPlayer.prepare();
        break;
      case 'prepared': // prepare调用成功后上报该状态机
        console.info('AVPlayer state prepared called.');
        avPlayer.play(); // 调用播放接口开始播放
        break;
      case 'playing': // play成功调用后触发该状态机上报
        console.info('AVPlayer state playing called.');
        if (count !== 0) {
          if (isSeek) {
            console.info('AVPlayer start to seek.');
            avPlayer.seek(avPlayer.duration); //seek到音频末尾
          } else {
            // 当播放模式不支持seek操作时继续播放到结尾
            console.info('AVPlayer wait to play end.');
          }
        } else {
          setTimeout(() => {
            console.info('AVPlayer is playing wait to pause');
            avPlayer.pause(); // 播放3s后调用暂停接口暂停播放
          }, 3000);
        }
        count++;
        break;
      case 'paused': // pause成功调用后触发该状态机上报
        console.info('AVPlayer state paused called.');
        setTimeout(() => {
          console.info('AVPlayer paused wait to play again');
          avPlayer.play(); // 暂停3s后再次调用播放接口开始播放
        }, 3000);
        break;
      case 'completed': // 播放结束后触发该状态机上报
        console.info('AVPlayer state completed called.');
        avPlayer.stop(); //调用播放结束接口
        break;
      case 'stopped': // stop接口成功调用后触发该状态机上报
        console.info('AVPlayer state stopped called.');
        avPlayer.reset(); // 调用reset接口初始化avplayer状态
        break;
      case 'released':
        console.info('AVPlayer state released called.');
        break;
      default:
        console.info('AVPlayer state unknown called.');
        break;
    }
  });
}
