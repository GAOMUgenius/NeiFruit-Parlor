import { PreferenceConstant } from "datastore"
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"
import { PostComponent } from "../components/PostComponent"
import { PostDataSource } from "../model/PostDataResource"
import { postDataEg, PostModel } from "../model/PostModel"

@Component
export struct CommunityPage {
  @StorageLink(PreferenceConstant.POST_LIST) postListData: PostDataSource = AppStorage.get(PreferenceConstant.POST_LIST)!


  aboutToAppear(): void {
    this.postListData.pushDataList([postDataEg])
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll() {
          List() {
             LazyForEach(this.postListData, (item: PostModel) => {
               ListItem() {
                 PostComponent({ postData: item })
               }
               .margin({ top: 5 })
               .onClick(() => {
                 buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.COMMUNITY_POSTPAGE, new Object(item))
               })
             }, (item: PostModel) => item.post_id.toString())
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

        Image($r('app.media.community_post_add'))
          .size({
            height: 50,
            width: 50
          })
          .margin({ bottom: 20 })
          .onClick(() => {
            buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.COMMUNITY_POSTPUBLISHPAGE)
          })
      }
      .width('100%')
      .height('100%')
    }
  }
}
