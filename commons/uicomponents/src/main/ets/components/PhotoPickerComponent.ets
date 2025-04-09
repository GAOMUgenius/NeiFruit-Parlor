import {
  PhotoPickerComponent, PickerController, PickerOptions,
  DataType, BaseItemInfo, ItemInfo, PhotoBrowserInfo,
  ItemType, ClickType,  PhotoBrowserRange
} from '@ohos.file.PhotoPickerComponent';
import photoAccessHelper from '@ohos.file.photoAccessHelper';

@Component
export struct PickerDemo {
  pickerOptions: PickerOptions = new PickerOptions();
  @State pickerController: PickerController = new PickerController();
  // @State selectUris: Array<string> = new Array<string>();
  @State currentUri: string = '';
  @State isBrowserShow: boolean = false;
  @Link parentSelectUris: Array<string>;
  @Link isPhotoPickerComponentPickShow: boolean

  aboutToAppear() {
    this.pickerOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
    this.pickerOptions.maxSelectNumber = 9;
    this.pickerOptions.isSearchSupported = false;
    this.pickerOptions.isPhotoTakingSupported = false;
    this.pickerOptions.preselectedUris = [...this.parentSelectUris];
  }

  private onSelect(uri: string): void {
    if (uri && this.parentSelectUris.length < 9) {
      this.parentSelectUris.push(uri);
    }
  }

  private onDeselect(uri: string): void {
    if (uri) {
      this.parentSelectUris = this.parentSelectUris.filter((item: string) => {
        return item != uri;
      });
    }
  }

  private onItemClicked(itemInfo: ItemInfo, clickType: ClickType): boolean {
    if (!itemInfo) {
      return false;
    }
    let type: ItemType | undefined = itemInfo.itemType;
    let uri: string | undefined = itemInfo.uri;
    if (type === ItemType.CAMERA) {

      return true;
    } else {
      if (clickType === ClickType.SELECTED) {
        if (uri && this.parentSelectUris.length < 9) {
          this.parentSelectUris.push(uri);
          this.pickerOptions.preselectedUris = [...this.parentSelectUris];
        }
        return true;
      } else {
        if (uri) {
          this.parentSelectUris = this.parentSelectUris.filter((item: string) => {
            return item != uri;
          });
          this.pickerOptions.preselectedUris = [...this.parentSelectUris];
        }
      }
      return true;
    }
  }

  private onEnterPhotoBrowser(photoBrowserInfo: PhotoBrowserInfo): boolean {
    this.isBrowserShow = true;
    return true;
  }

  private onExitPhotoBrowser(photoBrowserInfo: PhotoBrowserInfo): boolean {
    this.isBrowserShow = false;
    return true;
  }

  private onPickerControllerReady(): void {
  }

  private onPhotoBrowserChanged(browserItemInfo: BaseItemInfo): boolean {
    this.currentUri = browserItemInfo.uri ?? '';
    return true;
  }

  private async uploadImages() {
  }

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }) {
      PhotoPickerComponent({
        pickerOptions: this.pickerOptions,
        onItemClicked: (itemInfo: ItemInfo, clickType: ClickType): boolean => this.onItemClicked(itemInfo, clickType),
        onEnterPhotoBrowser: (photoBrowserInfo: PhotoBrowserInfo): boolean => this.onEnterPhotoBrowser(photoBrowserInfo),
        onExitPhotoBrowser: (photoBrowserInfo: PhotoBrowserInfo): boolean => this.onExitPhotoBrowser(photoBrowserInfo),
        onPickerControllerReady: (): void => this.onPickerControllerReady(),
        onPhotoBrowserChanged: (browserItemInfo: BaseItemInfo): boolean => this.onPhotoBrowserChanged(browserItemInfo),
        pickerController: this.pickerController,
      })
        .height('80%')
        .width('100%')
        .margin({ top: '15%' })


      if (this.isBrowserShow) {
        Row() {
          ForEach(this.parentSelectUris, (uri: string) => {
            if (uri === this.currentUri) {
              Image(uri).height('10%').width('10%').onClick(() => {
              }).borderWidth(1).borderColor('red')
            } else {
              Image(uri).height('10%').width('10%').onClick(() => {
                this.pickerController.setData(DataType.SET_SELECTED_URIS, this.parentSelectUris);
                this.pickerController.setPhotoBrowserItem(uri, PhotoBrowserRange.ALL);
              })
            }
          }, (uri: string) => JSON.stringify(uri))
        }
      } else {
        Row() {
          Button('预览')
            .width('50%')
            .height('5%')
            .backgroundColor('#309fff')
            .onClick(() => {
            if (this.parentSelectUris.length > 0) {
              this.pickerController.setPhotoBrowserItem(this.parentSelectUris[0], PhotoBrowserRange.SELECTED_ONLY);
            }
          })

          Button('完成选择')
            .width('50%')
            .backgroundColor('#309fff')
            .onClick(() => {
              this.isPhotoPickerComponentPickShow = false;
            })
        }
      }
    }
  }
}
