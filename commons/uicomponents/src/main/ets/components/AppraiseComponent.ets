import { AppraiseData } from "../model/AppraiseModel"



@Component
struct AppraiseComponent {
  @Prop appraise: AppraiseData

  build() {
    Row() {
      Column() {
        Row() {
          Image(this.appraise.user_picture)
            .size({
              width: 20,
              height: 20
            })
            .borderRadius(10)
            .margin({ left: 15 })
          Text(this.appraise.user_name)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .margin({ left: 5 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .width('100%')

        Row() {
          Text(this.appraise.user_content)
            .fontWeight(FontWeight.Regular)
            .maxLines(2)
            .fontSize(12)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .flexShrink(1)
            .textAlign(TextAlign.Start)
            .margin({ left: 20, top: 10 })
            .height(70)
            .textAlign(TextAlign.Start)
            .width(this.appraise.user_content_picture? 230 : 280)

          if (this.appraise.user_content_picture) {
            Image(this.appraise.user_content_picture[0])
              .size({
                height: 70,
                width: 70
              })
              .objectFit(ImageFit.Cover)
          }
        }

      }
      .justifyContent(FlexAlign.Start)
      .height('100%')
      .width('100%')
      .margin({ top: 10 })
    }
    .height(100)
  }
}

@Component
export struct AppraiseListComponent {
  @Prop productAppraise: AppraiseData[]

  aboutToAppear(): void {
    if (!Array.isArray(this.productAppraise)) {
      throw new Error('数据源必须为数组');
    }
  }

  build() {
    List() {
      ForEach(this.productAppraise, (item: AppraiseData) => {
        ListItem() {
          AppraiseComponent({
            appraise: item
          })
        }
      })
    }
    .divider({ strokeWidth: 0.5, color: '#ffdedede', startMargin: 10, endMargin: 10 })
    .height('auto')
    .width('100%')
    .margin({ top: 15 })
  }
}