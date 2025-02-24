import { UserAccount } from 'datastore'
import { BuilderNameConstants, RouterModule } from 'routermodule';
<<<<<<< HEAD
import { CustomUserInfomation } from '../compenents/CustomUserInformation';
=======
>>>>>>> origin/main

@Component
struct UserInformationStruct {
  @State userAccount: UserAccount = new UserAccount()
  build() {
    NavDestination() {
      Row(){
<<<<<<< HEAD
        CustomUserInfomation()
=======

>>>>>>> origin/main
      }
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