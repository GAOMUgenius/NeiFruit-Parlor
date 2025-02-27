import { UserAccount } from 'datastore'
import { BuilderNameConstants, RouterModule } from 'routermodule';
import { CustomUserInfomation } from '../compenents/CustomUserInformation';

@Component
struct UserInformationStruct {
  @State userAccount: UserAccount = new UserAccount()
  build() {
    NavDestination() {
      Row(){
        Column() {
          CustomUserInfomation()
            .width('90%')
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
  UserInformationStruct()
}

const builderName = BuilderNameConstants.MINE_USERINFORMATION;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(UserInformation);
  RouterModule.registerBuilder(builderName, builder);
}