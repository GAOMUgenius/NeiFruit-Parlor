import { BuilderNameConstants, RouterModule } from "routermodule";

@Component
struct NameChangeStruct {

  build() {
    NavDestination() {

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