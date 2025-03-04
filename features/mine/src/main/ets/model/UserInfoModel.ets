import { UserAccount } from "datastore"
import { BuilderNameConstants } from "routermodule"

export interface UserInfoData {
  id: InfoType
  title: string
  infoRouter?: string
  key: keyof UserAccount//对个人信息的关联
}

export enum InfoType {
  NAME = 0,
  EMAIL,
  INTRODUCE,
  BACKGROUND
}
export const UserInfo: UserInfoData[] = [
  {
    id: InfoType.NAME,
    title: "昵称",
    infoRouter: BuilderNameConstants.MINE_NAMECHANGE,
    key: 'userName'
  },
  {
    id: InfoType.EMAIL,
    title: "邮箱",
    infoRouter: BuilderNameConstants.MINE_EMAILCHANGE,
    key: 'userEmail'
  },
  {
    id: InfoType.INTRODUCE,
    title: "个人简介",
    key: "introduce"
  },
  {
    id: InfoType.BACKGROUND,
    title: "背景",
    key: 'background'
  },
]

