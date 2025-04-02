import { PostModel } from '../model/PostModel'

@Component
export struct PostComponent {
  @Prop postData: PostModel

  build() {
    Column() {
      Row() {
        Image(this.postData.user_picture)
          .size({
            width: 20,
            height: 20
          })
          .margin({ left: 10 })
          .borderRadius(10)

        Text(this.postData.user_name)
          .fontSize(20)
      }
    }
  }
}