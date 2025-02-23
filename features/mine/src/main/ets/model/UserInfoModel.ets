import { BuilderNameConstants } from "routermodule"

export interface UserInfoData {
  id: InfoType
  title: string
  infoRouter: string
}

export enum InfoType {
  NAME = 0
}
export const UserInfo: UserInfoData[] = [
  {
    id: InfoType.NAME,
    title: "昵称",
    infoRouter: BuilderNameConstants.MINE_NAMECHANGE
  }
]

