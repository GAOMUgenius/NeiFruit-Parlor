import { buildRouterModel, RouterNameConstants } from "routermodule"
import { InfoType, UserInfo, UserInfoData } from "../model/UserInfoModel"

@Component
export struct CustomUserInfomation {
  build() {
    Row() {
      ForEach(UserInfo, (item: UserInfoData)  => {
        UserInfoItem({
          index: item.id,
          title: item.title,
          infoRouter: item.infoRouter
        })
      }, (item: UserInfoData) => item.id.toString())
    }
  }
}

@Component
struct UserInfoItem {
  @Prop index: number
  @Prop title: string
  @Prop infoRouter: string
  build() {
    Row() {
      Text(this.title)
        .fontSize(20)
    }.justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      buildRouterModel(RouterNameConstants.PHONE_INDEX, this.infoRouter)
    })
  }
}