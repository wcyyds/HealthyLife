import City from '../../model/weathermodel/City'
import WeatherItem from '../../model/weathermodel/WeatherItem'
import CityHeader from '../../views/weatherviews/City/CityHeader'
import { CityList } from '../../views/weatherviews/City/CityList'

@Entry
@Component
struct CityManage {
  @StorageLink('cities') cities: City<WeatherItem>[] = []
  @State isJudgeGet: boolean = false

  async aboutToAppear(): Promise<void> {
    if( this.cities){
      this.isJudgeGet = true
    }
  }

  build() {
    Column(){
      // 1.导航栏
      CityHeader()
      // 2.城市列表
      if( this.isJudgeGet)
        CityList()
      else{
        Text('加载中Manage')
      }
    }
    .width('100%')
    .height('100%')
  }
}