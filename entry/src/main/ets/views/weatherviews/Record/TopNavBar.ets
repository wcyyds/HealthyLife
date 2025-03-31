import router from '@ohos.router'
import { CommonConstants } from '../../../constants/CommonConstants'
import City from '../../../model/weathermodel/City'
import WeatherItem from '../../../model/weathermodel/WeatherItem'

@Component
export default struct TopNavBar {
  @StorageLink('currentCityIndex') currentCityIndex:number = 0
  @StorageLink('cities') cities:City<WeatherItem>[] = []
  build() {
      Row({space: 10}) {
        if(this.currentCityIndex < this.cities.length && this.cities[this.currentCityIndex].name !== undefined){
          Text(this.cities[this.currentCityIndex].name)
            .fontColor(Color.White)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }else{
          Text('有问题')
        }
        Blank()
        Image($r('app.media.city_manager_icon'))
          .width(24)
          .height(24)
          .onClick(() => {
            router.pushUrl({
              url: 'subpage/weatherpages/CityManage'
            },
            router.RouterMode.Single,
            err => {
              if( err){
                console.log(`路由失败，err:${err.code} errMsg:${err.message}`)
              }
            })
          })
      }
      .position({x:0,y:0})
      .width('100%')
      .height(CommonConstants.TOPIC_HEIGHT)
      .padding({ left: 16, right: 16 })
    }
}