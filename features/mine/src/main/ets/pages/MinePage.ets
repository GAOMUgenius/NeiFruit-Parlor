import { MineHeaderView } from "../views/MineHeaderView";
import { PayManangeView } from "../views/PayManageView";
import { ProductView, RecommendComponent } from "uicomponents";
import { UserInfoView } from "../views/UserInfoView";
import { getUserInfo, UserInfo } from "../model/UserInfoServer";
import { UserData } from "datastore/src/main/ets/model/UserDataModel";
import { PreferenceConstant, PreferenceManager } from "datastore";

@Component
export struct MinePageStruct {
  @State userData: UserData = new UserData()

  async aboutToAppear(): Promise<void> {
    let preferenceManager = PreferenceManager.getInstance()
    let token = await preferenceManager.getValue<string>(PreferenceConstant.USER_TOKEN_KEY)
    let getUserInfoData: UserInfo | undefined = undefined

    if (token) {
      getUserInfoData = await getUserInfo(token)
    }
    if (getUserInfoData) {
      this.userData = getUserInfoData.data
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Row() {
          Column() {
            Column() {
              MineHeaderView()
                .margin({ top: 10 })

              UserInfoView({ userData: this.userData })
                .margin({ top: 20 })
            }
            .linearGradient({
              angle: 135, // 设置颜色渐变起始角度为顺时针方向135°
              colors: [
                [0xe0c3fc, 0.0],
                [0xa6c1ee, 1.0],
              ]
            })

            PayManangeView()
              .margin({ top: 20 })

            RecommendComponent()
              .margin({ top: 10 })

            //商品信息数据流
            ProductView()
              .margin({ top: 10 })
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
        }
        .alignItems(VerticalAlign.Top)
        .width('100%')
      }
      .width('100%')
    }
  }
}
