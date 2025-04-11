import { PostModel } from '../model/PostModel'

@Component
export struct PostComponent {
  @Prop postData: PostModel
  @State contentPicture: ResourceStr[] = []
  @State isLikesOn: boolean = false

  aboutToAppear(): void {
    if (this.postData.post_content_picture.length > 3) {
    this.contentPicture = this.postData.post_content_picture.slice(0, 3);
  } else {
    this.contentPicture = this.postData.post_content_picture;
    }
  }

  build() {
    Column() {
      Row() {
        Image($r(this.postData.user_picture))
          .size({
            width: 18,
            height: 18
          })
          .margin({ left: 10 })
          .borderRadius(9)

        Text(this.postData.user_name)
          .fontSize(10)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Text(this.postData.post_title)
        .width('100%')
        .padding({ left: 10, right: 10 })
        .margin({ top: 10 })
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .flexShrink(1)
        .lineHeight(28)

      Text(this.postData.post_content)
        .fontWeight(FontWeight.Medium)
        .fontSize(15)
        .lineHeight(25)
        .width('100%')
        .padding({ left: 10, right: 10 })
        .margin({ top: 10, bottom: 10 })
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .flexShrink(1)


      if(this.postData.post_content_picture) {
        Row() {
          ForEach(this.contentPicture, (item: ResourceStr) => {
            Image(item)
              .width('33%')
              .aspectRatio(1)
              .objectFit(ImageFit.Cover)
              .margin({ right: 5 })
              .borderRadius(10)
          })
        }
        .margin({ bottom: 10 })
        .padding({ left: 5 })
        .width('100%')
      }

      Row() {
          Text(this.postData.user_community)
            .backgroundColor('#ebf5f5f5')
            .fontSize(10)
            .margin({ left: 10 })
            .padding(5)
            .borderRadius(5)

        Row() {
          Image($r('app.media.community_appraise_icon'))
            .size({
              width: 20,
              height: 20
            })
            .margin({ right: 5 })

          Text(this.postData.post_appraise_number.toString())
            .textAlign(TextAlign.Start)
            .width(30)
            .fontSize(13)
            .fontColor(Color.Gray)
            .margin({ right: 10 })

          Image(this.isLikesOn ? $r('app.media.community_likes_on_icon') : $r('app.media.community_likes_off_icon'))
            .size({
              width: 20,
              height: 20
            })
            .margin({ right: 5 })
            .onClick(() => {
              this.isLikesOn ? this.postData.post_likes_number-- : this.postData.post_likes_number++
              this.isLikesOn = !this.isLikesOn
            })

          Text(this.postData.post_likes_number.toString())
            .textAlign(TextAlign.Start)
            .width(30)
            .fontSize(13)
            .fontColor(Color.Gray)
            .margin({ right: 10 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ right: 10 })

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ bottom: 10 })
    }
    .width('95%')
    .backgroundColor(Color.White)
    .borderRadius(10)
  }
}