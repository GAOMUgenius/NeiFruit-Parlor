import { PostComponent } from "../components/PostComponent"
import { PostDataSource } from "../model/PostDataResource"
import { postDataEg, PostModel } from "../model/PostModel"

@Component
export struct CommunityPage {
  @State postListData: PostDataSource = new PostDataSource()

  aboutToAppear(): void {
    this.postListData.pushDataList([postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,postDataEg,])
  }

  build() {
    NavDestination() {
      Stack() {
        Scroll() {
          List() {
             LazyForEach(this.postListData, (item: PostModel) => {
               ListItem() {
                 PostComponent({ postData: item })
               }
               .margin({ top: 5 })
             })
          }
          .alignListItem(ListItemAlign.Center)
          .height('100%')
          .width('100%')
        }
        .margin({ top: 30 })
        .backgroundColor("#ebf5f5f5")

        Row() {
          Text('社区论坛')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .padding({ left: 10 })
        }
        .position({ x: 0, y: 0 })
        .zIndex(999)
        .alignItems(VerticalAlign.Center)
        .height(30)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
  }
}
