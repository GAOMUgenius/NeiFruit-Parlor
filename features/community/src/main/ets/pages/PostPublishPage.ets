import { BuilderNameConstants, RouterModule, RouterNameConstants } from 'routermodule'
import { PickerDemo } from 'uicomponents/src/main/ets/components/PhotoPickerComponent'
import { PostPublishModel } from '../model/PostModel';


@Component
struct PostPublish {
  @State isPhotoPickerComponentPickShow: boolean = false;
  @State selectUris: Array<string> = new Array<string>();
  @State newPost: PostPublishModel = new PostPublishModel()

  @Builder
  PickerBuilder() {
    Column() {
      PickerDemo({ parentSelectUris: $selectUris, isPhotoPickerComponentPickShow: $isPhotoPickerComponentPickShow })
        .onDisAppear(() => {
          this.isPhotoPickerComponentPickShow = false;
        })
    }
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

@Builder
export function PostPublishPage(value: object) {
  PostPublish()
}

const builderName = BuilderNameConstants.COMMUNITY_POSTPUBLISHPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(PostPublishPage);
  RouterModule.registerBuilder(builderName, builder);
}