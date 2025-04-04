import { HttpRequestCallback } from "../../model/newsmode/HttpRequest";
import { NewsModel, NewsModelIssueListItemList } from "../../model/newsmode/NewsModel";
import { NewsPageModel } from "../../model/newsmode/NewsPageModel";
import { BaseViewModel } from "../BaseViewModel";
import { BusinessError } from "@kit.BasicServicesKit";

@Observed
export class NewsPageViewModel extends BaseViewModel {
  model = new NewsPageModel()
  dataList: NewsModelIssueListItemList[] = []

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