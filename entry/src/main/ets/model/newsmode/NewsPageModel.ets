import { ApiService } from "./ApiService";
import { HttpRequestCallback } from "./HttpRequest";
import { NewsModel } from "./NewsModel";

export class NewsPageModel {
  getNewsList(homeModelCallback: HttpRequestCallback<NewsModel>) {
    ApiService.getInstance().getHomeList(homeModelCallback)
  }
}