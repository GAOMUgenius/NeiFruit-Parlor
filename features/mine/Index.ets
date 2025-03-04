import { BuilderNameConstants, RouterNameConstants } from "routermodule";
export function harInit(builderName: string): void {
  switch (builderName) {
    case BuilderNameConstants.MINE_MINEPAGE:
      import ("./src/main/ets/pages/MinePage");
      break;
    case BuilderNameConstants.MINE_USERINFORMATION:
      import ("./src/main/ets/pages/UserInformation");
      break;
      case BuilderNameConstants.MINE_NAMECHANGE:
        import ("./src/main/ets/pages/NameChange");
        break
      case BuilderNameConstants.MINE_EMAILCHANGE:
        import ("./src/main/ets/pages/EmailChange");
        break
    default:
      break;
  }
}

export { MinePageStruct } from "./src/main/ets/pages/MinePage"
