import { UserAccount } from "datastore"
import { Logger } from "utils"

//处理用户信息跳转的接口
interface UserAccountJSONToParseInterface{
  _photo_:string,
  UserAccount:UserAccount
}
//将router跳转的value转换为UserAccount的工具
export function UserAccountJSONToParse(value: object): UserAccount {
  return (JSON.parse(JSON.stringify(value)) as UserAccountJSONToParseInterface).UserAccount
}

//处理用户信息跳转的接口
interface UserInfoJSONToPareseInterface {
  _photo_:string,
  value: string
}
//将router跳转的value转换为UserName的工具
export function UserNameJSONToParse(value: object): string {
  return (JSON.parse(JSON.stringify(value)) as UserInfoJSONToPareseInterface).value
}
