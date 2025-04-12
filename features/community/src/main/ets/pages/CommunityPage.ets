import { PreferenceConstant } from "datastore"
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"
import { PostComponent } from "../components/PostComponent"
import { PostDataSource } from "../model/PostDataResource"
import { likesChange, postDataEgList, PostModel } from "../model/PostModel"


class callBack implements likesChange {
  private context: CommunityPage; // 替换为组件类型

  constructor(context: CommunityPage) {
    this.context = context;
  }
  handleLikeChange(postId: number, newLikes: number): void {
    // 通过postId查找数据项
    const index = this.context.postListData.findIndex(item => item.post_id === postId);
    if (index === -1) return;

    // 获取原数据
    const originalData = this.context.postListData.getData(index);

    // 创建新数据对象
    const newData = new PostModel(
      originalData.post_id,
      originalData.user_id,
      originalData.user_picture,
      originalData.user_name,
      originalData.user_community,
      originalData.post_appraise_number,
      newLikes, // 更新点赞数
      originalData.post_title,
      originalData.post_content,
      originalData.post_content_picture
    );

    // 调用数据源方法更新
    this.context.postListData.changeData(index, newData);
  }

}
@Component
export struct CommunityPage {
  @StorageLink(PreferenceConstant.POST_LIST) postListData: PostDataSource = AppStorage.get(PreferenceConstant.POST_LIST)!
  private callback: callBack = new callBack(this)

  aboutToAppear(): void {
    this.postListData.pushDataList(postDataEgList)
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Bottom }) {
        Scroll() {
          List() {
             LazyForEach(this.postListData, (item: PostModel, index: number) => {
               ListItem() {
                 PostComponent({
                   postData: this.postListData.getData(index),
                   onLikeChange: (postId: number, newLikes: number) => this.callback.handleLikeChange(postId, newLikes)
                 })
               }
               .margin({ top: 5 })
               .onClick(() => {
                 buildRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.COMMUNITY_POSTPAGE, new Object(this.postListData.getData(index)))
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
