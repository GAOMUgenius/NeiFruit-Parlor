import { PostModel } from '../model/PostModel'

@Component
 export struct PostInfoView {
  @Prop postInfo: PostModel
  @State contentPicture: ResourceStr[] = []; // 延迟初始化

 aboutToAppear() {
  // 确保在 postInfo 可用后赋值
  if (this.postInfo && this.postInfo.post_content_picture) {
   this.contentPicture = this.postInfo.post_content_picture;
  }
 }

  build() {
   NavDestination() {
    Scroll() {
     Column() {
      Swiper() {
       ForEach(this.contentPicture, (item: string) => {
        Image($r(item))
         .objectFit(ImageFit.Auto)
       })
      }
      .loop(false)

      Row() {
       Image($r(this.postInfo.user_picture))
        .size({
         width: 35,
         height: 35
        })
        .borderRadius(17.5)
        .margin({ left: 10 })

       Text(this.postInfo.user_name)
        .margin({ left: 5 })
        .fontSize(13)
        .fontWeight(FontWeight.Bold)
      }
      .margin({ top: 10 })
      .width('100%')

      Text(this.postInfo.post_title)
       .width('100%')
       .margin({ top: 10 })
       .padding({ left: 10, right: 10 })
       .fontWeight(FontWeight.Bold)
       .fontSize(18)
       .lineHeight(28)

      Text(this.postInfo.post_content)
       .width('100%')
       .margin({ top: 10 })
       .padding({ left: 10, right: 10 })
       .fontWeight(FontWeight.Medium)
       .fontSize(15)
       .lineHeight(25)

      Row() {
       Text(this.postInfo.user_community)
        .backgroundColor('#ebf5f5f5')
        .fontSize(10)
        .margin({ left: 10 })
        .padding(5)
        .borderRadius(5)
      }
      .margin({ top: 10 })
      .width('100%')

     }
     .margin({ top: 10, bottom: 10 })

    }
    .width('100%')
    .height(700)
   }

  }
}