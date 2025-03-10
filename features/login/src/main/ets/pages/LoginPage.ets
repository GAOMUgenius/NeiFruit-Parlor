import { RouterModule, BuilderNameConstants, RouterNameConstants, buildRouterModel } from "routermodule";
import { ComponentContent, promptAction, router } from "@kit.ArkUI";
import { PreferenceManager, UserData } from "datastore";
import  'tab/src/main/ets/pages/TabPage'
import { UserService } from "../model/userchargeServer";

const TAG = '[LoginPage]'

@Entry
@Component
struct LoginPageStruct {
  @State userData: UserData = new UserData
  @State rememberMe: boolean = false
  @State stopLogin: boolean = false
  @State loging: boolean = false
  @State isAccountShow: boolean = false
  @State accountImg: string = this.isAccountShow ? 'app.media.up' : 'app.media.down'

  async aboutToAppear(): Promise<void> {
    const userService = new UserService();

    try {
      // 尝试自动登录
      const autoLoginSuccess = await userService.checkAutoLogin();
      if (autoLoginSuccess) {
        router.replaceNamedRoute({
          name: `TabPage`,
          params: {
            data1: 'message'
          }
        }, router.RouterMode.Standard, (err) => {
          if (err) {
            console.error(`replaceNamedRoute failed, code is ${err.code}, message is ${err.message}`);
            return;
          }
          console.info('replaceNamedRoute success');
        })

        // 跳转到主界面
        console.log('自动登录成功，进入主界面');
      } else {
        // 显示登录界面
        console.log('需要手动登录');
      }
    } catch (error) {
      console.error('应用启动异常:', error);
    }
  }


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
              TextInput({ text: this.userData.useremail })
                .type(InputType.Email)
                .width('80%')
                .onChange((value: string) => {
                  this.userData.useremail = value
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

              TextInput({ text: this.userData.password })
                .type(InputType.Password)
                .width('80%')
                .onChange((value: string) => {
                  this.userData.password = value
                })
            }
          }
          .margin({ bottom: 15 })

          // 修改登录按钮的onClick事件
          Button('登录')
            .type(ButtonType.Capsule)
            .borderRadius(8)
            .backgroundColor('#ff180258')
            .width('80%')
            .enabled(!this.loging) // 防止重复点击
            .onClick(async () => {
              // if (this.loging) return;
              //
              // this.loging = true;
              // const userService = new UserService();
              //
              // try {
              //   // 执行实际登录操作
              //   const success = await userService.manualLogin(
              //     this.userData.useremail,
              //     this.userData.password,
              //     this.rememberMe
              //   );
              //
              //   if (success) {
              //     // 登录成功跳转
              //     router.replaceNamedRoute({
              //       name: `TabPage`,
              //       params: { data1: 'message' }
              //     }, router.RouterMode.Standard, (err) => {
              //       if (err) {
              //         console.error(`跳转失败: ${err.message}`);
              //         promptAction.showToast({ message: '页面跳转异常' });
              //       }
              //     });
              //   }
              // } catch (error) {
              //   console.error('登录失败:', error);
              //   promptAction.showToast({
              //     message: error.message || '登录失败，请检查账号密码'
              //   });
              // } finally {
              //   this.loging = false;
              // }
              router.replaceNamedRoute({
                      name: `TabPage`,
                      params: { data1: 'message' }
                    }, router.RouterMode.Standard, (err) => {
                      if (err) {
                        console.error(`跳转失败: ${err.message}`);
                        promptAction.showToast({ message: '页面跳转异常' });
                      }
                    });
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
                  this.rememberMe = value
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