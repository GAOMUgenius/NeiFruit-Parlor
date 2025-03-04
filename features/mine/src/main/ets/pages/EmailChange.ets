import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";
import { UserNameJSONToParse } from "../model/JSONToParse";

@Builder
export function EmailChange(value: object) {
  NavDestination() {
    Row() {
      Column() {
        TextInput({ text: UserNameJSONToParse(value) })
          .onChange((value: string) => {
            let email = value
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

const builderName = BuilderNameConstants.MINE_EMAILCHANGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(EmailChange);
  RouterModule.registerBuilder(builderName, builder);
}