import { PreferenceConstant } from "datastore";
import { UserData } from "datastore/src/main/ets/model/UserDataModel";
import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import { replaceRouterModel } from "routermodule/src/main/ets/model/RouterModel";

@Component
export struct  EmailChangeStruct {
  @State newUserData: UserData = new UserData()
  @StorageLink(PreferenceConstant.USER_DATA) userData: UserData | undefined = AppStorage.get(PreferenceConstant.USER_DATA)

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
              this.userData!.useremail = this.newUserData.useremail
              //回到上一级
              RouterModule.pop(RouterNameConstants.TABPAGE)
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
  EmailChangeStruct()
}

const builderName = BuilderNameConstants.MINE_EMAILCHANGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(EmailChange);
  RouterModule.registerBuilder(builderName, builder);
}