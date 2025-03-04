import { UserAccount } from "datastore"
import { buildRouterModel, RouterNameConstants } from "routermodule"
import { UserInfoData } from "../model/UserInfoModel"

@Builder
export function CustomUserInfomation(UserInfo: UserInfoData[], userAccount: UserAccount) {
    Column() {
      ForEach(UserInfo, (item: UserInfoData)  => {
        UserInfoItem({
          index: item.id,
          title: item.title,
          infoRouter: item.infoRouter,
          userAccount: userAccount,
          keys: item.key
        })
          .margin(
            item.id === 0
            ? { bottom: 10, top: 10 }
            : { bottom: 10 }
          )
      }, (item: UserInfoData) => item.id.toString())
    }
    .width('90%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(12)
    .margin({
      top: 20
    })

}

@Component
struct UserInfoItem {
  @Prop userAccount: UserAccount
  @Prop index: number
  @Prop title: string
  @Prop infoRouter: string
  @Prop keys: keyof UserAccount

  // 根据 key 获取对应的属性值
  private getValue(): string {
    switch (this.keys) {
      case 'userName':
        return this.userAccount.userName;
      case 'userEmail':
        return this.userAccount.userEmail;
      case 'introduce':
        return this.userAccount.introduce;
      case 'background':
        return this.userAccount.background;
      default:
        return ''; // 默认处理
    }
  }

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(13)
          .margin({ left: 15 })

        Text(this.getValue() || '')
          .fontWeight(FontWeight.Medium)
          .fontSize(15)
          .width('70%')
          .textAlign(TextAlign.End)
          .flexShrink(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Image($r('app.media.right'))
          .size({
            width: 15,
            height: 20
          })
          .margin({ right: 15 })

      }
      .height(25)
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        if (this.infoRouter) {
          buildRouterModel(RouterNameConstants.TABPAGE, this.infoRouter, new Object({value: this.getValue()}))
        }
      })

      if ( this.title != '背景' ) {
        Line()
          .margin({ top: 5 })
          .width('95%')
          .height(1)
          .backgroundColor("#3ebcbcbc")
      }
    }
  }
}