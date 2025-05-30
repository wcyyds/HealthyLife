import promptAction from '@ohos.promptAction';
import httpGet from '../../../util/HttpGet';
import City from '../../../model/weathermodel/City';
import WeatherItem from '../../../model/weathermodel/WeatherItem';

@Component
export default struct SearchHeader {
  @Link searchText: string;
  @Link searchResults: City<WeatherItem>[];
  @State isLoading: boolean = false;
  WeatherData:WeatherItem = new WeatherItem()

  //TODO 搜索时，可以隐藏其他内容，只展示搜索出的城市
  async searchCity(text: string) {
    if (!text.trim()) {
      promptAction.showToast({
        message: '请输入城市名称',
        duration: 2000,
      });
      return;
    }

    this.isLoading = true;
    try {
      //httpGet.getCityWeatherData("101010100", 'now')
        /*.then(currentWeather => {
          this.data.code = currentWeather.code
          console.log(this.data.code)
        })*/
      this.searchResults = await httpGet.searchCity(text);

      if (this.searchResults.length === 0) {
        promptAction.showToast({
          message: '未找到相关城市',
          duration: 2000,
        });
      }
    } catch (error) {
      console.error('城市搜索失败:', error);
      let errorMessage = '搜索失败，请稍后重试';
      if (error instanceof Error) {
        errorMessage = error.message;
      }
      promptAction.showDialog({
        title: '搜索错误',
        message: errorMessage,
        buttons: [
          {
            text: '确定',
            color: '#3478f6',
          },
        ],
      });
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Row() {
      TextInput({ placeholder: '搜索城市' })
        .width('80%')
        .height(40)
        .backgroundColor('#f5f5f5')
        .borderRadius(20)
        .padding({ left: 20, right: 20 })
        .onChange((value: string) => {
          AppStorage.set('isSearch', true)
          this.searchText = value;
        })
      Button(this.isLoading ? '搜索中...' : '搜索')
        .width('18%')
        .height(40)
        .backgroundColor(this.isLoading ? '#cccccc' : '#ff226aea')
        .borderRadius(20)
        .margin({ left: 10 })
        .enabled(!this.isLoading)
        .onClick(() => {
          this.searchCity(this.searchText);
        })
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }
}