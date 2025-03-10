import { UserData } from "datastore/src/main/ets/model/UserDataModel";
import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import { replaceRouterModel } from "routermodule/src/main/ets/model/RouterModel";
import { UserAccountJSONToParse } from "../model/JSONToParse";

@Component
export struct  EmailChangeStruct {
  @Prop userData: object
  @State newUserData: UserData = UserAccountJSONToParse(this.userData)
  build() {
    NavDestination() {
      Row() {
        Column() {
          TextInput({ text: this.newUserData.useremail })
            .onChange((value: string) => {
              this.newUserData.useremail = value
            })
            .textAlign(TextAlign.JUSTIFY)
            .width('80%')
            .height('5%')
            .margin({
              top: 20
            })

          Button('保存')
            .onClick(() => {
              //上传逻辑

              //回到上一级
              replaceRouterModel(RouterNameConstants.TABPAGE, BuilderNameConstants.MINE_USERINFORMATION)
            })
            .backgroundColor($r('app.color.mine_namechange_save_button'))
            .margin({
              top: 40
            })
            .width(100)
        }
      }
      .backgroundColor("#ebf5f5f5")
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Top)
      .size({
        height: '100%',
        width: '100%'
      })
    }
    .title('邮箱')
  }
}

@Builder
export function EmailChange(value: object) {
  EmailChangeStruct({ userData: value })
}

const builderName = BuilderNameConstants.MINE_EMAILCHANGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(EmailChange);
  RouterModule.registerBuilder(builderName, builder);
}