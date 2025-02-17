export class UserAccount {
  uid: string = ''
  userType: UserTypeEnum = UserTypeEnum.OWNER
  userName: string = '新用户'
  userAccount: string = '123'
  community: string = ''
  password: string = '123'
  imgResource: Resource = $r('app.media.userImg')
  balance: string = '0.00'
}

export class SginUser {
  email: string = ''
  password: String = ''
}

export enum UserTypeEnum {
  OWNER = 1,
  PROPERTY= 2
}