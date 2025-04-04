import { NewsDetailParam } from "../model/newsmode/NewsDetailParam";
import { NewsModelIssueListItemList } from "../model/newsmode/NewsModel";
import { NewsPageViewModel } from "../viewmodel/newspageviewmodel/NewsPageViewModel";
import { CommonRootPage } from "../views/newsviews/CommonRootPage";
import { RefreshFooter } from "../views/newsviews/RefreshFooter";
import { router } from "@kit.ArkUI";

@Component
export struct NewsPage {
  TAG: string = '**NewsPage'
  @State message: string = 'Hello World';
  @State viewModel: NewsPageViewModel = new NewsPageViewModel();

  aboutToAppear(): void {
    this.viewModel.getHomeList(false, true)
  }

  build() {
    CommonRootPage({
      isShowBackBtn: false,
      title: "新闻页",
      loadingProps: this.viewModel.loadingProps,
      isRefreshing: this.viewModel.isRefreshing,
      onRefresh: () => {
        this.viewModel.getHomeList(true, false)
      }
    }) {
      List({ space: 10, initialIndex: 0 }) {
        ForEach(this.viewModel.dataList, (item: NewsModelIssueListItemList, index: number) => {
          ListItem() {
            Column() {
              Stack() {
                Image(item.data?.cover?.detail)
                  .width('100%')
                  .height('210vp')
                  .border({ radius: '10vp' })
                Text(item.data?.category)
                  .fontSize('12fp')
                  .fontColor('#fff')
                  .width('45vp')
                  .height('20vp')
                  .position({ x: 0, y: 0 })
                  .margin(10)
              }.width('100%').height('210vp')

              Row() {
                Image(item.data?.author?.icon).width('50vp').height('50vp').border({ radius: '25vp' })
                Column() {
                  Text(item.data?.author?.name).fontColor('#333333').fontSize('20fp')
                  Text(item.data?.author?.name).fontColor('#999999').fontSize('13fp').margin({ top: '5vp' })
                }.alignItems(HorizontalAlign.Start).margin({ left: '5vp' })
              }.width('100%').height('60vp').padding({ left: '5vp', right: '5vp' })
            }.width('100%').onClick(() => {
              console.info("MYTAG", "item click start...")
              router.pushUrl({
                url: 'subpage/newspages/NewsDetail',
                params: { 'id': item.data?.id, 'playUrl': item.data?.playUrl }
              }, router.RouterMode.Standard, (error) => {

              })
            })
          }
        })
        if (this.viewModel.dataList.length > 0) {
          ListItem() {
            RefreshFooter({ showFooter: this.viewModel.isLoadMore })
          }
        }
      }.onReachEnd(() => {
        console.info("MYTAG", "onReachEnd start...")
        if (this.viewModel.dataList.length > 0) {
          this.viewModel.isLoadMore = true
          this.viewModel.getHomeList(false, false)
        }
      })
    }
  }
}