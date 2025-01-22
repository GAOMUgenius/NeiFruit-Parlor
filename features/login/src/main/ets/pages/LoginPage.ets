import { RouterModule, BuilderNameConstants, RouterNameConstants } from "routermodule";

@Builder
export function LoginPage(value: object) {
  NavDestination() {
    Text('登录界面')
  }
  .onBackPressed(() => {
    RouterModule.pop(RouterNameConstants.PHONE_INDEX);
    return true;
  })
}

const builderName = BuilderNameConstants.LOGIN_LOGINPAGE;
if (!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(LoginPage);
  RouterModule.registerBuilder(builderName, builder);
}