import { PreferenceConstant } from 'datastore'
import { AppraiseData, AppraiseDataSource } from 'uicomponents'

@Component
export struct PostAppraiseView {
  @State postAppraise: AppraiseData[] = [new AppraiseData(), new AppraiseData()]
  @State postAppraiseData: AppraiseDataSource = new AppraiseDataSource()
  @State isLoading: boolean = false

  aboutToAppear(): void {
    this.postAppraiseData.pushDataList(this.postAppraise)
  }

  build() {
      Stack() {
        Scroll() {
          List() {
            LazyForEach(this.postAppraiseData, (item: AppraiseData) => {
              ListItem() {
                PostAppraiseListItem({
                  postAppraise: item,
                  isLoading: this.isLoading
                })
              }
            })
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height('100%')
        .margin({ bottom: 40 })
      }
      .alignContent(Alignment.Bottom)
      .width('100%')
    }
}

@Component
struct PostAppraiseListItem {
  @Prop postAppraise: AppraiseData
  @Link isLoading: boolean
  build() {
    Column() {
      Row() {
        Row() {
          Image(this.postAppraise.user_picture)
            .size({
              width: 30,
              height: 30
            })
            .borderRadius(15)
            .margin({ left: 15 })
          Text(this.postAppraise.user_name)
            .fontSize(15)
            .fontWeight(FontWeight.Normal)
            .margin({ left: 5 })
        }

        Rating({ rating: this.postAppraise.user_rating, indicator: true })
          .stars(5)
          .stepSize(0.5)
          .size({
            width: 80,
            height: 40
          })
          .margin({ right: 30 })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      Text(this.postAppraise.user_content)
        .fontSize(15)
        .fontWeight(FontWeight.Regular)
        .width('80%')
        .flexShrink(0)
        .margin({ top: 20, bottom: 20 })

      if(this.postAppraise.user_content_picture?.length !== 0) {
        Row() {
          ForEach(this.postAppraise.user_content_picture, (item: ResourceStr) => {
            Image(item)
              .width(this.getImageSize())
              .aspectRatio(1)             // 保持1:1正方形比例
              .margin({ right: 4 })        // 右侧间距
              .objectFit(ImageFit.Cover)  // 图片填充模式
          })
        }
        .width('80%')
      }

      if (this.isLoading) {
        LoadingProgress()
          .color(Color.White)
          .width(80)
          .height(80)
      }
    }
  }

  //根据图片数量计算图片大小
  private getImageSize(): string {
    if(this.postAppraise.user_content_picture?.length != 3) {
      return '50%'
    } else {
      return '33.3%'
    }
  }
}