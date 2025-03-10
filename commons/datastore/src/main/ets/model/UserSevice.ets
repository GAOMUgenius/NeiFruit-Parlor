// import { UserAccount } from "./UserAccount";
//
// export class UserService {
//   private static STORAGE_KEY = 'GlobalUser';
//   private static _instance: UserService;
//
//   // 响应式存储
//   @StorageLink(UserService.STORAGE_KEY)
//   private static currentUser: UserAccount = new UserAccount();
//
//   // 单例模式
//   static get instance(): UserService {
//     if (!UserService._instance) {
//       UserService._instance = new UserService();
//       this.initialize();
//     }
//     return UserService._instance;
//   }
//
//   // 初始化用户数据
//   private static initialize() {
//     const stored = LocalStorage.Get(this.STORAGE_KEY);
//     if (stored) {
//       this.currentUser = Object.assign(new UserAccount(), stored);
//     }
//   }
//
//   // 获取当前用户（响应式）
//   static get user(): UserAccount {
//     return this.currentUser;
//   }
//
//   // 更新用户数据
//   static updateUser(partialUser: Partial<UserAccount>) {
//     this.currentUser = Object.assign({}, this.currentUser, partialUser);
//     this.saveToStorage();
//   }
//
//   // 持久化到本地存储
//   static saveToStorage() {
//     LocalStorage.Set(this.STORAGE_KEY, this.currentUser);
//   }
//
//   // 清除用户数据
//   static clear() {
//     this.currentUser = new UserAccount();
//     LocalStorage.Delete(this.STORAGE_KEY);
//   }
// }