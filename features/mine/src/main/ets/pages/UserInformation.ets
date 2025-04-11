import { PreferenceConstant, UserData } from 'datastore';
import { BuilderNameConstants, RouterModule } from 'routermodule';
import { Logger } from 'utils';
import { CustomUserInfomation } from '../compenents/CustomUserInformation';
import { UserInfo } from '../model/UserInfoModel';

@Component
struct UserInfoMationStruct {
  @StorageLink(PreferenceConstant.USER_DATA) userData: UserData | undefined = AppStorage.get(PreferenceConstant.USER_DATA)

  build() {
    NavDestination() {
      Row(){
        Column() {
          Row(){
            Image($r(this.userData?.user_picture))
              .size({
                width: 100,
                height: 100
              })
              .borderRadius(50)
              .margin({ top: 30, bottom: 30 })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .margin({
            top: 20
          })
          .width('90%')


          CustomUserInfomation(UserInfo, this.userData!)

        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .backgroundColor("#ebf5f5f5")
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .title('个人信息')
  }
}

@Builder
export function UserInformation(value: object) {
  UserInfoMationStruct()
}


const builderName = BuilderNameConstants.MINE_USERINFORMATION;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(UserInformation);
  RouterModule.registerBuilder(builderName, builder);
}