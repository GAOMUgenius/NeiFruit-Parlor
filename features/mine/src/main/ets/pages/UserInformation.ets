import { UserAccount } from 'datastore'
import { BuilderNameConstants, RouterModule } from 'routermodule';
import { Logger } from 'utils';
import { CustomUserInfomation } from '../compenents/CustomUserInformation';
import { UserAccountJSONToParse } from '../model/JSONToParse';
import { UserInfo } from '../model/UserInfoModel';

@Builder
export function UserInformation(value: object) {
  // UserInformationStruct()
    NavDestination() {
      Row(){
        Column() {
          Row(){
            Image($r(UserAccountJSONToParse(value).imgResource))
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


          CustomUserInfomation(UserInfo, UserAccountJSONToParse(value))

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


const builderName = BuilderNameConstants.MINE_USERINFORMATION;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(UserInformation);
  RouterModule.registerBuilder(builderName, builder);
}