import { BuilderNameConstants, RouterModule } from 'routermodule'
import { AccountInputView } from '../components/AccountInPutView'
import { SginUser } from '../model/UserAccount'
import { promptAction } from '@kit.ArkUI'
import { getVerificationCode } from 'network/src/main/ets/usercharge/usercharge'

@Component
struct SginPageStruct {
  @State sginuser: SginUser = new SginUser()
  @State code: string = ''
  @State countdownTime: number = 60
  @State isCounting: boolean = false
  private timerId: number = -1

  // 启动倒计时
  startCountdown() {
    if (this.isCounting) return

    this.isCounting = true
    this.timerId = setInterval(() => {
      if (this.countdownTime > 0) {
        this.countdownTime--
      } else {
        this.resetCountdown()
      }
    }, 1000)
  }

  // 重置倒计时
  resetCountdown() {
    clearInterval(this.timerId)
    this.isCounting = false
    this.countdownTime = 60
  }

  build() {
    NavDestination() {
      Column() {
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

          Button(this.isCounting ? `${this.countdownTime}s后重新获取` : '获取验证码')
            .width('30%')
            .height(30)
            .fontColor(this.isCounting ? '#ff000000' : '#CCCCCC')
            .backgroundColor(this.isCounting ? '#CCCCCC' : '#ff201d5d')
            .enabled(!this.isCounting)
            .margin({ right: 40 })
            .onClick(async () => {
              if(!this.isCounting) {
                if(!this.sginuser.email) {
                  promptAction.showToast({
                    message: "邮箱不能为空"
                  })
                } else {
                  this.startCountdown()
                  // 获取验证码
                  this.code =  await getVerificationCode(this.sginuser.email)
                }
              } else {
                // 什么也不做
              }

            })

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

          Column() {
            Text('密码')
              .fontSize(15)
              .fontFamily('HarmonyHeiTi')
              .fontWeight(FontWeight.Medium)
              .width('80%')
              .fontColor('#ff201d5d')
              .grayscale(0)
              .margin({ bottom: 10 })

            TextInput({ text: this.sginuser.password })
              .type(InputType.Password)
              .width('80%')
              .onChange((value: string) => {
                this.sginuser.password = value
              })
              .margin({ bottom: 10 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text('确认密码')
              .fontSize(15)
              .fontFamily('HarmonyHeiTi')
              .fontWeight(FontWeight.Medium)
              .width('80%')
              .fontColor('#ff201d5d')
              .grayscale(0)
              .margin({ bottom: 10 })

            TextInput({ text: this.sginuser.password })
              .type(InputType.Password)
              .width('80%')
              .onChange((value: string) => {
                this.sginuser.password = value
              })
              .margin({ bottom: 10 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

        }
        .alignItems(HorizontalAlign.End)
        .width('100%')

        Button('注册并登录')
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#ff201d5d')
          .width('60%')
          .height(30)
          .margin({ top: 50 })

      }
      .width('100%')
      .height('100%')
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