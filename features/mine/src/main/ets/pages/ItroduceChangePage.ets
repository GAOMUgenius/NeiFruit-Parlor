import { PreferenceConstant } from "datastore";
import { UserData } from "datastore/src/main/ets/model/UserDataModel";
import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import { replaceRouterModel } from "routermodule/src/main/ets/model/RouterModel";

@Component
export struct  IntroduceChangeStruct {
  @State newUserData: UserData = new UserData()
  @StorageLink(PreferenceConstant.USER_DATA) userData: UserData | undefined = AppStorage.get(PreferenceConstant.USER_DATA)

  build() {
    NavDestination() {
      Row() {
        Column() {
          TextArea({ text: this.newUserData.user_introduction })
            .onChange((value: string) => {
              this.newUserData.user_introduction = value
            })
            .textAlign(TextAlign.JUSTIFY)
            .width('80%')
            .margin({
              top: 20
            })

          Button('保存')
            .onClick(() => {
              //上传逻辑
              this.userData!.user_introduction = this.newUserData.user_introduction
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
export function IntroduceChangeStructPage(value: object) {
  IntroduceChangeStruct()
}

const builderName = BuilderNameConstants.MINE_INTRODUCECHANGEPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(IntroduceChangeStructPage);
  RouterModule.registerBuilder(builderName, builder);
}