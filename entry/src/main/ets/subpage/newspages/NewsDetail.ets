import { NewsDetailParam } from "../../model/newsmode/NewsDetailParam";
import { router } from "@kit.ArkUI";
import { NewsDetailViewModel } from "../../viewmodel/newspageviewmodel/NewsDetailViewModel";
import { CommonRootPage } from "../../views/newsviews/CommonRootPage";
import { NewsModelIssueListItemList } from "../../model/newsmode/NewsModel";

@Entry
@Component
export struct NewsDetail {
  @State viewModel: NewsDetailViewModel = new NewsDetailViewModel()
  aboutToAppear(): void {
    const params: NewsDetailParam = router.getParams() as NewsDetailParam;
    this.viewModel.dataId = params.id;
    this.viewModel.playUrl = params.playUrl
  }

  build() {
    NavDestination() {
      Column() {
        CommonRootPage({
          isShowBackBtn: true,
          title: "视频详情",
          loadingProps: this.viewModel.loadingProps,
          isRefreshing: this.viewModel.isRefreshing,
          onRefresh: () => {
            console.info("MYTAG", "onReresh start...")
            this.viewModel.getHomeDetail(false)
          }
        }) {
          Column() {
            Video({
              src: this.viewModel.playUrl,
              previewUri: this.viewModel.previewUris,
              controller: this.viewModel.controller
            })
              .width('100%')
              .height('250vp')
              .autoPlay(true)
              .objectFit(ImageFit.Fill)
            List() {
              ForEach(this.viewModel.dataList, (item: NewsModelIssueListItemList, index: number) => {
                ListItem() {
                  Row() {
                    Image(item.data?.cover?.feed).width('100vp').height('100%').border({ radius: '5vp' })
                    Column() {
                      Text(item.data?.title)
                        .fontSize('20fp')
                        .fontColor('#333333')
                        .maxLines(1)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                      Text(item.data?.description)
                        .fontSize('13fp')
                        .fontColor('#999999')
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .margin({ top: '5vp' })
                    }.layoutWeight(1).height('100%').margin({ left: '10vp' }).alignItems(HorizontalAlign.Start)
                  }.width('100%').height('70vp').margin('10vp').onClick(() => {
                    this.viewModel.playUrl = item.data?.playUrl as string
                  })
                }
              })
            }
          }.width('100%').height('100%').justifyContent(FlexAlign.Start)

        }
      }.width('100%').height('100%').justifyContent(FlexAlign.Start)
    }.hideTitleBar(true)
  }
}