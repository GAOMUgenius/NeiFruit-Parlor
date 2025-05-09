
import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';

const PREFERENCES_NAME: string = 'NeiFruitStore';

export class PreferenceManager {
  public preferences?: preferences.Preferences;
  public context = getContext(this) as common.UIAbilityContext;
  public static instance: PreferenceManager;

  public constructor() {
    this.initPreference(PREFERENCES_NAME);
  }

  public static getInstance(): PreferenceManager {
    if (!PreferenceManager.instance) {
      PreferenceManager.instance = new PreferenceManager();
    }
    return PreferenceManager.instance;
  }

  async initPreference(storeName: string): Promise<void> {
    return preferences.getPreferences(this.context, storeName)
      .then((preferences: preferences.Preferences) => {
        this.preferences = preferences;
      });
  }

  async setValue<T>(key: string, value: T): Promise<void> {
    if (this.preferences) {
      this.preferences.put(key, JSON.stringify(value)).then(() => {
        this.saveUserData();
      })
    } else {
      this.initPreference(PREFERENCES_NAME).then(() => {
        this.setValue<T>(key, value);
      });
    }
  }

  async getValue<T>(key: string): Promise<T | null> {
    if (this.preferences) {
      return this.preferences.get(key, '').then((res: preferences.ValueType) => {
        let value: T | null = null;
        if (res) {
          value = JSON.parse(res as string) as T;
        }
        return value;
      });
    } else {
      return this.initPreference(PREFERENCES_NAME).then(() => {
        return this.getValue<T>(key);
      });
    }
  }

  async hasValue(key: string): Promise<boolean> {
    if (this.preferences) {
      return this.preferences.has(key);
    } else {
      return this.initPreference(PREFERENCES_NAME).then(() => {
        return this.hasValue(key);
      });
    }
  }

  async deleteValue(key: string): Promise<void> {
    if (this.preferences) {
      this.preferences.delete(key).then(() => {
        this.saveUserData();
      });
    } else {
      this.initPreference(PREFERENCES_NAME).then(() => {
        this.deleteValue(key);
      });
    }
  }

  saveUserData() {
    this.preferences?.flush();
  }

  // 通用存储方法（不依赖具体类型）
  // async setGenericValue<T>(key: string, value: T ): Promise<void> {
  //   if (this.preferences) {
  //     await this.preferences.put(key, JSON.stringify(value))
  //     this.saveUserData()
  //   }
  // }
  //
  // // 通用读取方法
  // async getGenericValue<T>(key: string): Promise<T | null> {
  //   if (!this.preferences) return null
  //   const value = await this.preferences.get(key, '')
  //   return value ? JSON.parse(value.toString()) as T : null
  // }
}