import { HttpRequestCallback } from "../../model/newsmode/HttpRequest";
import { NewsModel, NewsModelIssueListItemList } from "../../model/newsmode/NewsModel";
import { NewsPageModel } from "../../model/newsmode/NewsPageModel";
import { BaseViewModel } from "../BaseViewModel";
import { BusinessError } from "@kit.BasicServicesKit";
import { http } from '@kit.NetworkKit';

@Observed
export class NewsPageViewModel extends BaseViewModel {
  model = new NewsPageModel()
  dataList: NewsModelIssueListItemList[] = []

  getVioceList() {
    console.info("wcy", "start getTextToSpeechGet")
    let httpRequest = http.createHttp();
    httpRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      "https://apis.netstart.cn/zhihudaily/stories/latest",
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
      }).then((res: http.HttpResponse) => {
      console.info("wcy", "getTextToSpeechGet res: " + res.result.toString())
    });
  }

  getHomeList(isReresh: boolean, isFirst: boolean) {
    console.info("MYTAG","getHomeList start,isReresh:"+isReresh+",isFirst:"+isFirst)
    const currThis = this

    class HomeModelCallback implements HttpRequestCallback<NewsModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
        currThis.isRefreshing = isReresh
      }

      onComplete(): void {
        console.log('Request completed.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = false
        }
        currThis.isRefreshing = false
        currThis.isLoadMore = false
      }

      onSuccess(response: NewsModel): void {
        console.log('Request succeeded with response:', response);
        let items = response.issueList[0].itemList
        let list = items.filter((item) => item.type == "video")
        if (isReresh) {
          currThis.dataList = list
        } else {
          currThis.dataList = [...currThis.dataList, ...list]
        }
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
        currThis.isLoadMore = false
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = false
        }
      }
    }

    this.model.getNewsList(new HomeModelCallback());
  }
}
