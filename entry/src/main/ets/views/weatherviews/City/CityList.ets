import City from '../../../model/weathermodel/City'
import WeatherItem from '../../../model/weathermodel/WeatherItem'
import { router } from '@kit.ArkUI'
import { CommonConstants } from '../../../constants/CommonConstants'
import PreferenceUtil from '../../../util/PreferenceUtil'
import HttpGet from '../../../util/HttpGet'

@Component
export struct CityList {
  @StorageLink('currentCityIndex') currentCityIndex:number = 0
  @Watch('aboutToAppear')
  @StorageLink('cities') cities: City<WeatherItem>[] = []
  @State isJudge: boolean = false

  async aboutToAppear(): Promise<void> {
    this.isJudge = false
    await this.loadCities()
  }

  build() {
    if( this.isJudge){
      List({space:10}){
        ForEach(this.cities,
          (city:City<WeatherItem>, index) => {
            ListItem(){
              Row(){
                Column({space:20}){
                  Text(city.name)
                    .fontSize(24)
                    .fontWeight(CommonConstants.FONT_WEIGHT_700)
                    .fontColor(Color.White)
                  /* if(city.detail)
                   Text(city.detail.weather.airQuality)
                     .fontColor('#ffe2e1e1')
                     .fontSize(14)*/
                }
                .padding({left:20})
                Blank()
                Column({space:20}){
                  if(city.detail)
                    Text(`${city.detail.now?.temp}°`)
                      .fontSize(20)
                      .fontWeight(CommonConstants.FONT_WEIGHT_700)
                      .fontColor(Color.White)
                  if(city.detail)
                    Text(city.detail.now?.text)
                      .fontSize(14)
                      .fontColor(Color.White)
                }
                .padding({right:20})
              }
              .width("90%")
              .height('15%')
              .borderRadius(15)
              .backgroundColor(this.cities[index].detail!.now?.text?.includes("雨")
                || this.cities[index].detail!.now?.text?.includes("阴")  ? $r('app.color.rainy_backgroundcolor') : $r('app.color.default_backgroundcolor'))
            }
            .swipeAction(city.name === '长安' ? {end: this.noDelete()} : {end: this.deleteButton(city.name)})
            .onClick( () => {
              this.currentCityIndex = index
              router.back({
                url:'pages/Index'
              })
            })
          })
      }
      .alignListItem(ListItemAlign.Center)
      .width('100%')
      .height('100%')
    }else{
      Text('加载中CityList')
    }
  }

  @Builder
  noDelete() {
    Image($r('app.media.delete_icon'))
      .fillColor(Color.Gray)
      .width('20')
      .height('20')
      .margin({left:20})

  }

  //删除一个城市
  @Builder
  deleteButton(name: string){
    Image($r('app.media.delete_icon'))
      .fillColor(Color.Red)
      .width('20')
      .height('20')
      .margin({left:20})
      .onClick( () => {
        this.cities = this.cities.filter(c => c.name !== name)
        PreferenceUtil.removeCity(CommonConstants.CITY_INFO, name)
      })
  }

  //加载天气信息
  async loadCities() {
    let WeatherDetail:WeatherItem = new WeatherItem()
    for(let i = 0; i < this.cities.length; i++){
      if( this.cities[i].id != undefined)
      {
        WeatherDetail = await HttpGet.getCityWeatherData('weather',this.cities[i].id, "now")
        this.cities[i].detail = WeatherDetail
      }
    }
    this.isJudge = true
  }
}
