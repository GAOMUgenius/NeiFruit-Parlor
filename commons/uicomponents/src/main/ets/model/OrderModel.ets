import { ProductData, ProductSelection } from "./ProductModel";

// OrderModel.ts
export interface OrderItem {
  productId: string;
  productName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
}

export interface OrderData {
  orderId: string;
  createTime: string;
  items: OrderItem[];
  totalAmount: number;
  status: PayStatus // 订单状态
}

export enum PayStatus {
  PAY = 0,
  DELIVERY,
  TAKEOVER,
  EVALUATE,
  SERVICE
}
// OrderModel.ts
export interface SelectedProduct {
  product: ProductData;
  selection: ProductSelection;
}