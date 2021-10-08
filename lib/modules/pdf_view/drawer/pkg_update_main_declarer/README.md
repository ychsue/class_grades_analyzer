# 說明：
## 1. Call it 呼叫：
這個 package 使用上只要呼叫 
``` dart
final controller = updateMainDeclarer(buildcontext);
```
再透過 `controller.iniParas` 與 `debounce(cotroller.toEnv,......)` 
即可顯示設定 `mainDeclarer` 的 `Dialog` 與取得回呼了。
而 `debounce` 需要在確定 `controller.canDispose=true` 記得 `dispose`
### 回呼的內容：
原則上即此dialog想設定的東西。

## 2. 介面與運作：
使用者可以設定 *標頭* 與 *標尾* 還有設定要顯示的主要 indices 的選取方式。
目前有提供 **全選**、**選碼** 與 **按照上一頁**
其中的 **選碼** 會讓使用者輸入要顯現的項目的碼，由
``` dart
List<num> selN2List(String input);
```
來負責，這也可以讓外部來呼叫。

確定時按 **確定** 就可以了。而它就會更新 `controller` 的 `toEnv` 好提醒environment已經有更新了，
這樣，就可以將要求送到 package 以外了。
