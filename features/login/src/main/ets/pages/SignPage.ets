import { BuilderNameConstants, RouterModule } from 'routermodule'
import { SginUser } from '../model/UserAccount'

@Component
struct SginPageStruct {
  @State sginuser: SginUser = new SginUser()
  @State code: string = ''

  build() {
    NavDestination() {
      Column() {
        Text('Sign Up')
          .fontSize(44)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#ff201d5d')
          .textAlign(TextAlign.Center)
          .margin({ left: 10, top: 10 })
          .textAlign(TextAlign.Start)
          .width('90%')
          .margin({ bottom: 30 })

        Column() {
          Text('账号')
            .fontSize(15)
            .fontFamily('HarmonyHeiTi')
            .fontWeight(FontWeight.Medium)
            .width('80%')
            .fontColor('#ff201d5d')
            .grayscale(0)
            .margin({ bottom: 10 })

          TextInput({ text: this.sginuser.email })
            .type(InputType.Email)
            .width('80%')
            .onChange((value: string) => {
              this.sginuser.email = value
            })
            .margin({ bottom: 10 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Button('获取验证码')
          .fontSize('30%')
          .onClick(() => {
            //获取验证码方法
          })
          .margin({ right: 30 })

        Column() {
          Text('验证码')
            .fontSize(15)
            .fontFamily('HarmonyHeiTi')
            .fontWeight(FontWeight.Medium)
            .width('80%')
            .fontColor('#ff201d5d')
            .grayscale(0)
            .margin({ bottom: 10 })

          TextInput({ text: this.code })
            .type(InputType.Email)
            .width('80%')
            .onChange((value: string) => {
              this.code = value
            })
            .margin({ bottom: 10 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

      }
      .alignItems(HorizontalAlign.End)
      .height('100%')
      .width('100%')
    }
  }
}
@Builder
export function SginPage(value: object) {
  SginPageStruct()
}

const builderName = BuilderNameConstants.LOGIN_SGINPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(SginPage);
  RouterModule.registerBuilder(builderName, builder);
}