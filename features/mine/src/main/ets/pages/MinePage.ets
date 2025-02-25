import { UserAccount } from "datastore";
import { BuilderNameConstants, buildRouterModel, RouterNameConstants } from "routermodule";
import { MineHeaderView } from "../views/MineHeaderView";
import { PayManangeView } from "../views/PayManageView";
import { ProductView } from "../views/ProductView";
import { UserInfoView } from "../views/UserInfoView";

@Component
export struct MinePageStruct {
  // @Link user: UserAccount

  build() {
    Navigation() {
      Scroll() {
        Row() {
          Column() {
            MineHeaderView()
              .margin({ top: 10 })

            UserInfoView()
              .margin({ top: 20 })


            PayManangeView()
              .margin({ top: 20 })

            //商品信息数据流
            ProductView()
              .margin({ top: 20 })

            Line()

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
