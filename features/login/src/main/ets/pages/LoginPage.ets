import { RouterModule, BuilderNameConstants, RouterNameConstants, buildRouterModel } from "routermodule";
import { promptAction } from "@kit.ArkUI";
import { ResourceConstants } from "../constants/ResourceConstants";
import { UserAccount } from "../model/UserAccount";

@Component
struct LoginPageStruct {
  @Prop user: UserAccount = new UserAccount()
  @State rememberPassword: boolean = false
  @State stopLogin: boolean = false
  @State loading: boolean = false
  @Prop isAccountShow: boolean = false
  @State accountImg: string = this.isAccountShow ? 'app.media.up' : 'app.media.down'
  build() {
    NavDestination() {
      Column() {
        Column({ space: 15 }) {
          Stack() {
            Image($r('app.media.login'))
              .width('100%')

            Text('Log In.')
              .fontSize(44)
              .fontWeight(FontWeight.Bolder)
              .fontColor('#ff201d5d')
              .textAlign(TextAlign.Center)
              .margin({ left: 10, top: 10 })
          }
          .width('100%')
          .alignContent(Alignment.TopStart)
          .padding({ top: 20 })

          Column() {
            Column() {
              Text('账号')
                .fontSize(15)
                .fontFamily('HarmonyHeiTi')
                .fontWeight(FontWeight.Medium)
                .width('80%')
                .fontColor('#ff201d5d')
                .grayscale(0)
                .padding({ bottom: 5 })
              TextInput({ text: this.user.userAccount })
                .type(InputType.Email)
                .width('80%')
                .onChange((value: string) => {
                  this.user.userAccount = value
                })
            }
            .margin({ bottom: 15 })
            Column() {
              Text('密码')
                .fontSize(15)
                .fontFamily('HarmonyHeiTi')
                .fontWeight(FontWeight.Medium)
                .width('80%')
                .fontColor('#ff201d5d')
                .grayscale(0)
                .padding({ bottom: 5 })

              TextInput({ text: this.user.password })
                .type(InputType.Password)
                .width('80%')
                .onChange((value: string) => {
                  this.user.password = value
                })
            }
          }
          .margin({ bottom: 15 })

          Button('登录')
            .type(ButtonType.Capsule)
            .borderRadius(8)
            .backgroundColor('#ff180258')
            .width('80%')
            .onClick(() => {

            })

          Row() {
            Text('注册账号')
              .fontSize(12)
              .fontColor('#ff5f5d5d')
              .onClick(()=> {
                buildRouterModel( RouterNameConstants.PHONE_INDEX, BuilderNameConstants.LOGIN_SGINPAGE )
              })

            Row() {
              Checkbox()
                .onChange((value: boolean) => {

                })

              Text('自动登录')
                .fontSize(12)
                .fontColor('#ff5f5d5d')

            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('60%')

        }
        .width('100%')
      }
      .height('100%')
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      RouterModule.pop(RouterNameConstants.PHONE_INDEX);
      return true;
    })
  }
}

@Builder
export function LoginPage(vaule: object) {
  LoginPageStruct()
}

const builderName = BuilderNameConstants.LOGIN_LOGINPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(LoginPage);
  RouterModule.registerBuilder(builderName, builder);
}