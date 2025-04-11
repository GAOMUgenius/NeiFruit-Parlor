import { UserData } from "datastore/src/main/ets/model/UserDataModel"
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule"


//用户信息卡片片
@Component
export struct UserInfoView {
  @Prop userData: UserData
  build() {
    Column() {
      Row() {
        Image($r(this.userData.user_picture))
          .borderRadius(30)
          .width(60)
          .height(60)
          .margin({ left: 20 })
        Column(){
          Text((!this.userData.username) ? this.userData.useremail : this.userData.username)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 10, bottom: 10 })

          Text(this.userData.user_introduction)
            .fontSize(10)
            .fontWeight(FontWeight.Regular)
            .maxLines(1)
            .width('60%')
            .textOverflow({ overflow: TextOverflow.Ellipsis })

        }
        .margin({ right: 30 })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({
        left: 20,
        right: 20,
        top: 20,
        bottom: 10
      })
      .onClick(() => {
        buildRouterModel( RouterNameConstants.TABPAGE, BuilderNameConstants.MINE_USERINFORMATION)

      })
    }
    .linearGradient({
      angle: 135, // 设置颜色渐变起始角度为顺时针方向135°
      colors: [
        [0xfbc2eb, 0.0],
        [0xa6c1ee, 1.0],
      ]
    })
    .borderRadius(30)
    .width('90%')
  }
}