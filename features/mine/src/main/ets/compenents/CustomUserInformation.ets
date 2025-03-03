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
          .margin(
            item.id === 0
            ? { bottom: 10, top: 10 }
            : { bottom: 10 }
          )
      }, (item: UserInfoData) => item.id.toString())
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(12)
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
          .margin({ left: 15 })

        Image($r('app.media.right'))
          .size({
            width: 15,
            height: 20
          })
          .margin({ right: 8 })

      }
      .height(25)
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        if (this.infoRouter) {
          buildRouterModel(RouterNameConstants.TABPAGE, this.infoRouter)
        }
      })

      if ( this.index != 4 ) {
        Line()
          .margin({ top: 5 })
          .width('95%')
          .height(1)
          .backgroundColor("#3ebcbcbc")
      }
    }
  }
}