export interface NewsModel {
  issueList: NewsModelIssueList[];
  itemList: NewsModelIssueList[];
  nextPageUrl: string;
  nextPublishTime: number;
  newestIssueType: string;
}

export interface NewsModelIssueListItemListData {
  dataType: string;
  id: number;
  title: string;
  description: string;
  image: string;
  actionUrl: string;
  shade: boolean;
  autoPlay: boolean;
  category: string;
  cover: CoverModel;
  playUrl: string;
  author: AuthorModel;
}
export class NewsModelIssueListItemList {
  type?: string;
  data?: NewsModelIssueListItemListData;
  id?: number;
  adIndex?: number;
  bannerList?: NewsModelIssueListItemList[];
}


export class BannerData implements IDataSource {
  private list: NewsModelIssueListItemList[] = []

  constructor(list: NewsModelIssueListItemList[]) {
    this.list = list
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    throw new Error('Method not implemented.');
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {

  }



  getData(index: number) {
    return this.list[index]
  }

  totalCount(): number {
    return this.list.length
  }
}


export interface NewsModelIssueList {
  releaseTime: number;
  type: string;
  date: number;
  publishTime: number;
  itemList: NewsModelIssueListItemList[];
  count: number;
}

export interface CoverModel {
  feed: string;
  detail: string;
  blurred: string;
  homepage: string;
}

export interface AuthorModel {
  id: number;
  icon: string;
  name: string;
  description: string;
  link: string;
  latestReleaseTime: number;
  videoNum: number;
  follow: RootObjectFollow;
  shield: RootObjectShield;
  approvedNotReadyVideoCount: number;
  ifPgc: boolean;
  recSort: number;
  expert: boolean;
}

export interface RootObjectFollow {
  itemType: string;
  itemId: number;
  followed: boolean;
}

export interface RootObjectShield {
  itemType: string;
  itemId: number;
  shielded: boolean;
}




