export class UserData {
  uid: string = ''
  userType: UserTypeEnum = UserTypeEnum.OWNER
  username: string = '新用户'
  useremail: string = '2047772125@qq.com'
  user_introduction: string = '这个人很冷漠';
  background: string = '';
  community_location: string = '108.94,34.27'
  community: string = '西安'
  password: string = 'Lion123'
  user_picture: string = 'https://gitee.com/gomugenius/nei-fruit-palor_-picture/raw/master/img/8a7a8a9b01bed3d6ac5f858e7a048c3.jpg'
  token: string | null = null
}
@Observed
export class SginUser {
  email: string = '2047772125@qq.com'
  password1: string = ''
  password2: string = ''
}

export enum UserTypeEnum {
  OWNER = 1,
  PROPERTY= 2
}