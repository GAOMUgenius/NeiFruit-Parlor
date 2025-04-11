import { UserData } from "datastore"
import { BuilderNameConstants } from "routermodule"

export interface UserInfoData {
  id: InfoType
  title: string
  infoRouter?: string
  key: keyof UserData//对个人信息的关联
}

export enum InfoType {
  NAME = 0,
  EMAIL,
  INTRODUCE,
  PASSWORD,
  BACKGROUND
}
export const UserInfo: UserInfoData[] = [
  {
    id: InfoType.NAME,
    title: "昵称",
    infoRouter: BuilderNameConstants.MINE_NAMECHANGE,
    key: 'username'
  },
  {
    id: InfoType.EMAIL,
    title: "邮箱",
    infoRouter: BuilderNameConstants.MINE_EMAILCHANGE,
    key: 'useremail'
  },
  {
    id: InfoType.INTRODUCE,
    title: "个人简介",
    infoRouter: BuilderNameConstants.MINE_INTRODUCECHANGEPAGE,
    key: "user_introduction"
  },
  {
    id: InfoType.PASSWORD,
    title: "密码",
    key: 'password'
  },
  {
    id: InfoType.BACKGROUND,
    title: "背景",
    key: 'background'
  },
]

