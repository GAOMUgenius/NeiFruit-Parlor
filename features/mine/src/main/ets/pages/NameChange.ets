import { PreferenceConstant, UserData } from "datastore";
import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";


@Component
struct NameChangeStruct{
  @State newUserData: UserData = new UserData()
  @StorageLink(PreferenceConstant.USER_DATA) userData: UserData | undefined = AppStorage.get(PreferenceConstant.USER_DATA)
  build() {
    NavDestination() {
      Row() {
        Column() {
          TextInput({ text: this.newUserData.username })
            .onChange((value: string) => {
              this.newUserData.username = value
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
              if (this.userData) {
                this.userData.username = this.newUserData.username
              }

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
    .title('昵称')
  }
}


@Builder
export function NameChange(value: object) {
  NameChangeStruct()
}

const builderName = BuilderNameConstants.MINE_NAMECHANGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(NameChange);
  RouterModule.registerBuilder(builderName, builder);
}