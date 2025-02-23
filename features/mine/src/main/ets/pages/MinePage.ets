import { UserAccount } from "datastore";
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";
import { MineHeaderView } from "../views/MineHeaderView";
import { PayManangeView } from "../views/PayManageView";
import { UserInfoView } from "../views/UserInfoView";

@Component
export struct MinePageStruct {
  // @Link user: UserAccount

  build() {
    Navigation() {
      Row() {
        Column() {
          MineHeaderView()
            .margin({ top: 10 })

          UserInfoView()
            .margin({ top: 20 })


          PayManangeView()
            .margin({ top: 20 })

        }
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)
        .width('100%')
      }
      .alignItems(VerticalAlign.Top)
      .width('100%')
      .height('100%')
    }
  }
}
