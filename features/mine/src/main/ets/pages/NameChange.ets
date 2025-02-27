import { BuilderNameConstants, RouterModule, RouterNameConstants } from "routermodule";

@Component
struct NameChangeStruct {
  @State name: string = ''

  build() {
    NavDestination() {
      Row() {
        Column() {
          TextInput({ text: this.name })
            .onChange((value: string) => {
              this.name = value
            })
            .textAlign(TextAlign.JUSTIFY)
            .width('100%')
            .height('5%')
            .margin({
              top: 10
            })

          Button('保存')
            .onClick(() => {
              //上传逻辑

              //回到上一级
              RouterModule.pop(RouterNameConstants.PHONE_INDEX)
            })
            .margin({
              top: 30
            })

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