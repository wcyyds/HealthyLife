import { ApiService } from "./ApiService";
import { HttpRequestCallback } from "./HttpRequest";
import { NewsModel } from "./NewsModel";

export class NewsDetailModel {
  getNewsDetail(id: number, homeModelCallback: HttpRequestCallback<NewsModel>) {
    ApiService.getInstance().getHomeDetail(id, homeModelCallback);
  }
}