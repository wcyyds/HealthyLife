import { HttpRequestCallback } from "../../model/newsmode/HttpRequest";
import { NewsDetailModel } from "../../model/newsmode/NewsDetailModel";
import { NewsModel, NewsModelIssueListItemList } from "../../model/newsmode/NewsModel";
import { BaseViewModel } from "../BaseViewModel";
import { BusinessError } from "@kit.BasicServicesKit";


export class NewsDetailViewModel extends BaseViewModel {
  model = new NewsDetailModel()
  dataId: number = 0
  playUrl: string = ''
  dataList: NewsModelIssueListItemList[] = []
  controller: VideoController | undefined;
  previewUris: Resource = $r('app.media.timeout');

  getHomeDetail(isFirst: boolean) {
    const currThis = this

    class HomeModelCallback implements HttpRequestCallback<NewsModel> {
      onStart(): void {
        console.log('Request started.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = true
        }
        currThis.isRefreshing = true
      }

      onComplete(): void {
        console.log('Request completed.');
        if (isFirst) {
          currThis.loadingProps.isShowInitLoading = false
        }
        currThis.isRefreshing = false
      }

      onSuccess(response: NewsModel): void {
        console.log('Request succeeded with response:', response);
        currThis.dataList = response.itemList
      }

      onFailure(error: BusinessError): void {
        console.log('Request failed with error:', error);
        currThis.loadingProps.isShowNetErr = true
        currThis.isRefreshing = false
      }
    }

    this.model.getNewsDetail(this.dataId, new HomeModelCallback());
  }
}