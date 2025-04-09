import { AnnouncementData, announcementDataDemo } from "../model/AnnouncementModel"

@Component
export struct CommunityAnnouncementComponent {
  @State communityAnnouncementData: AnnouncementData = announcementDataDemo

  build() {
    Column() {
      Text(this.communityAnnouncementData.title)
        .fontSize(30)
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .height('20%')
        .padding({ left: 10, right: 10 })


      Text(this.communityAnnouncementData.content)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .width('100%')
        .height('60%')
        .padding({ left: 10, right: 10 })

      Text(this.communityAnnouncementData.date)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .width('100%')
        .height('20%')
        .textAlign(TextAlign.End)
        .padding({ left: 10, right: 10 })

    }
    .linearGradient({
      direction: GradientDirection.LeftBottom, // 渐变方向
      repeating: true, // 渐变颜色是否重复
      colors: [[0xfbc2eb, 0.0], [0xa6c1ee, 1.0]] // 数组末尾元素占比小于1时满足重复着色效果
    })
    .width('100%')
    .height('100%')
  }
}