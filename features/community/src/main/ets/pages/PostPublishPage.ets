import { PreferenceConstant, UserData } from 'datastore';
import { BuilderNameConstants, RouterModule, RouterNameConstants } from 'routermodule'
import { PickerDemo } from 'uicomponents/src/main/ets/components/PhotoPickerComponent'
import { PostDataSource } from '../model/PostDataResource';
import { PostModel, PostPublishModel } from '../model/PostModel';
import { prompt } from '@kit.ArkUI';


@Component
struct PostPublish {
  @State isPhotoPickerComponentPickShow: boolean = false;
  @State selectUris: Array<string> = new Array<string>();
  @State newPost: PostPublishModel = new PostPublishModel()
  @StorageLink(PreferenceConstant.POST_LIST) postListData: PostDataSource = AppStorage.get(PreferenceConstant.POST_LIST)!
  @StorageLink(PreferenceConstant.USER_DATA) userData: UserData = AppStorage.get(PreferenceConstant.USER_DATA)!
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: () => {

        this.dialogController.close()
      },
      confirm: () => {
        // 确认时提交修改
        this.creatPost()
        RouterModule.pop(RouterNameConstants.TABPAGE)
        this.dialogController.close()
      }
    }),
    autoCancel: true
  })

  @Builder
  PickerBuilder() {
    Column() {
      PickerDemo({ parentSelectUris: $selectUris, isPhotoPickerComponentPickShow: $isPhotoPickerComponentPickShow })
        .onDisAppear(() => {
          this.isPhotoPickerComponentPickShow = false;
        })
    }
  }

  creatPost() {
    // 生成随机 post_id（示例方法）
    const postId = Math.floor(Math.random() * 1000000);

    // 创建新的 PostModel 实例
    const newPost = new PostModel(
      postId,
      parseFloat(this.userData.uid),
      this.userData.user_picture,
      this.userData.username,
      this.userData.community,
      0,  // 初始评论数
      0,  // 初始点赞数
      this.newPost.post_title || '',
      this.newPost.post_content || '',
      this.selectUris // 图片 URI 数组
    );

    this.postListData.addData(this.postListData.dataList.length, newPost)
  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          Row() {
            Image($r('app.media.community_icon_back'))
              .width('8%')
              .aspectRatio(1)
              .margin({ left: '7%'})
              .onClick(() => {
                RouterModule.pop(RouterNameConstants.TABPAGE)
              })

            Text('图文')
              .width('70%')
              .textAlign(TextAlign.Center)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)

            Text('发布')
              .width('15%')
              .textAlign(TextAlign.Start)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                if (!this.newPost.post_title?.trim()) {
                  prompt.showToast({ message: '请输入标题' });
                  return;
                }
                if (!this.newPost.post_content?.trim()) {
                  prompt.showToast({ message: '请输入内容' });
                  return;
                }
                this.dialogController.open()

              })
          }
          .width('100%')

          Grid() {
            ForEach([...this.selectUris, ...(this.selectUris.length < 9 ? [$r('app.media.community_icon_add_picture')] : [])],
              (uri: ResourceStr) => {
                GridItem() {
                  Image(uri)
                    .width(100)
                    .aspectRatio(1)
                    .borderRadius(8)
                    .onClick(() => {
                      this.isPhotoPickerComponentPickShow = true;
                    })
                    .bindContentCover(this.isPhotoPickerComponentPickShow,
                      this.PickerBuilder,
                      {
                        backgroundColor: Color.White
                      }
                    )

                }
                .width(100)
                .height(100)
              })
          }
          .margin({ top: 20 })
          .width('90%')
          .columnsTemplate('1fr 1fr 1fr')
          .rowsTemplate(this.getRowsTemplate(this.selectUris.length + (this.selectUris.length < 9 ? 1 : 0)))
          .height(this.getGridHeight(
            this.selectUris.length + (this.selectUris.length < 9 ? 1 : 0)
          ))

          TextArea({ text: this.newPost.post_title, placeholder: '标题内容(最多30字)' })
            .width('90%')
            .onChange((value) => {
              this.newPost.post_title = value
            })
            .maxLength(30)
            .margin({ top: 20 })
            .backgroundColor(Color.White)
            .fontSize(18)
            .lineHeight(28)
            .fontWeight(FontWeight.Medium)

          TextArea({ text: this.newPost.post_content, placeholder: '正文内容' })
            .width('90%')
            .onChange((value) => {
              this.newPost.post_content = value
            })
            .margin({ top: 10 })
            .backgroundColor(Color.White)
            .fontSize(15)
            .lineHeight(25)
            .fontWeight(FontWeight.Regular)
        }
      }
    }
    .hideBackButton(true)
  }

  // 动态计算容器高度
  private getGridHeight(count: number): number {
    return Math.ceil(count / 3) * 100;
  }

  private getRowsTemplate(count: number): string {
    if( count < 4) {
      return '1fr'
    } else if( count > 3 && count < 7) {
      return '1fr 1fr'
    } else {
      return '1fr 1fr 1fr'
    }
  }

}

@CustomDialog
struct CustomDialogExample {
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text('温馨提示')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 5 })
      Text('确定发布帖子吗?')
        .fontSize(14)
        .margin({ top: 20, bottom: 20 })
      Row() {
        Button('取消')
          .onClick(() => {
            this.controller?.close()
            this.cancel()
          })
          .margin({ right: 20 })
          .width(120)
          .fontSize(15)
          .backgroundColor(Color.White)
          .fontColor(Color.Black)
        Button('确定')
          .onClick(() => {
            this.controller?.close()
            this.confirm()
          })
          .width(120)
          .fontSize(15)
          .backgroundColor("#ff22c1ff")
      }
      .margin({ bottom: 20 })
    }
  }
}

@Builder
export function PostPublishPage(value: object) {
  PostPublish()
}

const builderName = BuilderNameConstants.COMMUNITY_POSTPUBLISHPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PostPublishPage);
  RouterModule.registerBuilder(builderName, builder);
}