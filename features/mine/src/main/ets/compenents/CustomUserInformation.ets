import { buildRouterModel, RouterNameConstants } from "routermodule"
import { InfoType, UserInfo, UserInfoData } from "../model/UserInfoModel"

@Component
export struct CustomUserInfomation {
  build() {
    Column() {
      ForEach(UserInfo, (item: UserInfoData)  => {
        UserInfoItem({
          index: item.id,
          title: item.title,
          infoRouter: item.infoRouter
        })
          .margin({
            bottom: 10
          })
      }, (item: UserInfoData) => item.id.toString())
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .height('100%')
    .width('100%')
    .margin({
      top: 20
    })
  }
}

@Component
struct UserInfoItem {
  @Prop index: number
  @Prop title: string
  @Prop infoRouter: string
  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(15)

        Image($r('app.media.right'))
          .size({
            width: 15,
            height: 20
          })

      }
      .height(23)
      .width('95%')
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        if (this.infoRouter) {
          buildRouterModel(RouterNameConstants.PHONE_INDEX, this.infoRouter)
        }
      })

      Line()
        .width('100%')
        .height(2)
    }
  }
}