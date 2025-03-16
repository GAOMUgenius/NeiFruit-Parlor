import { ProductData, ProductDataSource } from 'uicomponents'
import { ShopCarPage } from '../components/ShopCarPage';

export const shopCarInfo: ProductData[] = [
  new ProductData(
    '1',
    $r('app.media.OIP'),
    "有机小米",
    "78.5",
    "袋",
    "1.8",
    "kg",
    false,
    1
  ),
  new ProductData(
    '2',
    $r('app.media.OIP'),
    "有机小米",
    "78.5",
    "袋",
    "1.8",
    "kg",
    false,
    1
  ),
  new ProductData(
    '3',
    $r('app.media.OIP'),
    "有机小米",
    "78.5",
    "袋",
    "1.8",
    "kg",
    false,
    1
  )
]

export interface ShopChangeInterface {
  onItemContentChange(): void
}
