import { PreferenceConstant, PreferenceManager } from "datastore";
import { ProductData } from "./ProductModel";



//
// export class CartService {
//   private static prefs = PreferenceManager.getInstance()
//
//   static async addToCart(item: ProductData): Promise<boolean> {
//     const currentCart = await CartService.getCart()
//     const existingIndex = currentCart.findIndex(i => i.product_id === item.product_id)
//
//
//       // 检测是否已存在
//       if (existingIndex !== -1) {
//         return false
//       }
//       // 不存在则添加
//       currentCart.push(item)
//       CartService.syncCart(currentCart)
//       return true
//   }
//
//   static async getCart(): Promise<ProductData[]> {
//     const cart = await CartService.prefs.getGenericValue<ProductData[]>(PreferenceConstant.CART_KEY)
//     AppStorage.setOrCreate(PreferenceConstant.CART_KEY, cart || [])
//     return cart || []
//   }
//
//   static async clearCart(): Promise<void> {
//     await CartService.prefs.setGenericValue(PreferenceConstant.CART_KEY, [])
//   }
//
//   static async putCartList(data: ProductData[]): Promise<void> {
//     await CartService.prefs.setGenericValue(PreferenceConstant.CART_KEY, data)
//   }
//
//   static async syncCart(newData: ProductData[]): Promise<void> {
//     const current = await CartService.getCart();
//     if (JSON.stringify(current) === JSON.stringify(newData)) return;
//
//     await CartService.prefs.setGenericValue(PreferenceConstant.CART_KEY, newData);
//     AppStorage.setOrCreate(PreferenceConstant.CART_KEY, [...newData]);
//   }
// }