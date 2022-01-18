# 程式基本流程
1. [x] 給定Header 的文字，因為有的人會讓他們不在同一 Row 上
2. [x] 由Excel抓取資料，與轉為我們定義的格式
   1. [x] 由各個row 自行決定**平均**、**總分**
   2. [x] 由一個 exam 決定 **名次**、**最高分**、**最低分**、與**各科總平均**
3. [x] 工作中的ProgressRing顯示
4. [x] 分析與畫出來
   1. [x] 先抓取資料的主頁面
   2. [x] 以考試為主
   3. [x] 以學生為主
   4. [x] 以課目為主

# 放到 GitHub 上
1. [此篇](https://zonble.medium.com/use-github-pages-to-host-your-flutter-web-app-as-an-example-of-your-flutter-package-cb7b5b726eb1) 講到如何利用 `workflow.yml` 檔案來自動布置所要的 `GitHub Pages`
2. [此篇](https://github.com/francescopasin/flutter_workflow) 則講到較詳細的原理
3. [此為GitHub Flutter action的網頁](https://github.com/marketplace/actions/flutter-action)
4. [Medium文章](https://wiefel.medium.com/automatically-deploy-flutter-web-project-to-github-pages-using-github-actions-2ec743e830fa)
5. [Flutter 官網](https://docs.flutter.dev/deployment/cd)
6. [放到github上的教學](https://powerupwebdev.medium.com/deploy-your-projects-on-github-using-visual-studio-code-and-git-5f7221b272ca)
7. [如何修正 base href](https://github.com/flutter/flutter/issues/69760)

# 思考
1. [x] 原則上，這是一個3D問題。有 **exam**, **student** 與 **course** 三個維度。
2. [x] 而它的值可以是文字，如 **A++**，可以是 **數字** ，也可以是 **rank**
3. [ ] 可能還得考慮 **名次或成績進步速度** 與 **名次或成績進步加速度** 等，也就是關乎每個學生在意的特徵。
4. 此外，可以由三個方向投影，投影的法線我稱之為 virtual
   1. [x] 目前已經投影 **course** 為sum & average
   2. [X] 若投影 **student** 則可以為 average 與 highest 和 lowest
   3. [ ] **student** 也可以設定 SD (Standard Deviation)標準差
5. [x] 使用 **TabBar** 來顯示這三種類型，由 **Drawer** 來操控個別類型

# 進度
## [2022-01-17] 沒看到它自動 deploy耶?
## [2022-01-17] 已經讓使用者可以設定最高、最低與平均的名稱，並且也可以存起來下次使用。

## [2022-01-14] 讓最高、最低與平均可以選擇是否要列印出來。利用`showHLA` 來達成。
## [2022-01-13] 能夠更新 `VCourseNames` 與相應的 平均與總分 的名稱了。

## [2022-01-11] 現在可以儲存pdf_declarer 的設定了。

## [2022-01-06] 現在可以存取 pdf_declarer 的資料了。

## [2021-12-31] 雖然成功的將 show_cases 變成可以用 GetStorage 存取，但是，似乎用了反而更混淆，還是先不使用它吧。

## [2021-11-28] 新增可用來修改欄位名與要忽略的表單名的輸入格了。

## [2021-11-23] 能夠設定成績與ID欄位名稱了。
由於輸入中文並沒有真正完成確認(按Enter鍵)就會變更，所以，只好用 `FocusNode.unfocus()` 來強迫它更新了。

## [2021-11-16] 可以產生所有學生的Average、最高與最低分了
不過，目前限定只有當主軸為 Student ， 而 y軸只有一項時才顯現。
## [2021-11-10] 修正一些錯誤與美化 Table

## [2021-11-06] 能夠將多份名單擠在同一個PDF 頁面了。
## [2021-11-01] 可以自由設定 declarer 了
主軸與XY軸皆可了。

## [2021-10-08] 完成下面的任務(mainDeclarer 的 Dialog的顯現與操控)了
目前，先在外面創生出`pkg_update_main_declarer` 的 package 來產生 Dialog，並且移植回來了。
接下來，要產生各個圖表的小Card與他們的 Dialog 了，看來，又要在外面創生了。這樣比較容易執行與維護。

## [2021-10-04] 試著使用Form來調整 mainDeclarer 的值
在 [此篇Stack Overflow](https://stackoverflow.com/questions/64544571/flutter-getx-forms-validation) 有些例子可以參考。

## [2021-10-03] 可以得到PDF圖表了
## [2021-09-27] 初步印出頁面的標頭了
## [2021-09-24] packages 的問題
1. 首先， `printing` 與 `excel` 都用到了 `xml`, `archive` 等 packages，然而，由於 `excel` 的新版有問題，所以我用的是舊版，結果就有了 `xml`與`archive` 相衝的問題。
   1. 解決法是在 pubspec.yaml 的 `dependency-overrides` 裡將上述兩個的較新版本宣告進來，還在測試中，不知會否出問題。
   2. 目前能動。
2. 其次，`pdf` 這個package 的 3.6.0 版有問題，無法正確使用 `wt001.ttf` 的字形，只好，硬是將其版本宣告成 3.5.0，目前這樣能動。
3. 中文 `ttf` 檔一堆版權問題，而網路上的 `otf` 又不能直接在 `pdf` 裡使用，真傷腦筋。難道選擇使用 `pdf` 是錯誤的決定？
## [2021-09-11] 可以選擇要顯示 grade 或者 rank 了
以後可以顯示標準差嗎？

## [2021-09-10] 加上VirtualCourse的部分、修正大小等問題，但似乎變得很卡，到底哪裡在卡？
還有，`SingleChildScrollView` 需要用到 `LimitedBox`，這很傷腦筋，因為其大小很難限定。
不要使用它會否比較不卡一點？
## [2021-09-04] 已經能夠列出 Table 了，而且也可以連動了。
可是，關於UI物件大小控制還不大會。

## [2021-09-02] 試著抓取所需的資料，暫不考慮效能，僅考慮方便性。(也尚未寫好View 的部分)
## [2021-08-28] 能夠重排，也知道如何運用 `Theme` 了
用 `Theme` 會比較好，這樣，可以一次整個改變主題。
## [2021-08-27] 考量到未來可能會希望不同case 下順序不同，所以，創造一個 `PairModel` 來同時存 indices 與 是否被選取。
目前只差 reorder的部分，可能要由 `SimpleDialog` 換到 `Dialog` 了。
## [2021-08-26] 將 `exam`, `student` 與 `course` 看成是 `x`, `y`, `z` 三個軸(Axes)
1. 既然這些叫軸，那麼它其上的 `indices` 就不是連續實數，而是各考試、各學生與各科了。
2. 而slice它時，主要有沿三個軸切的，所以有三種cases，它們以 `TabsEnum` 來區隔是哪個當法線。
3. 因為這三個 cases 要顯示的 `indices` 可改變，所以，需要紀錄起來。記在 global的 `caseShows` 裡。
   
## [2021-08-21] 想讓不同狀態下 Drawer 的 `onTap` 有不停功能
1. 要做到這點，我可能得有一個 `StateController` 當作大家的頭，不然，這些 `Controller` 互相關聯，也會使得除錯變得困難。
2. 星狀的話，就可以用假的來做測試了。 
## [2021-08-20] 為了能夠加速開發，因此，將整筆Data變成 JSON 檔
1. 結果 `JsonDecoder().convert(...)` 所得到的結果還需要修改才能由 `fromJson` 灌入 Model 裡
2. 參考 [此篇 StackOverflow](https://stackoverflow.com/questions/53376518/dart-json-string-convert-to-list-string) 可以解決。
   1. `String`, `num` 等不用轉換即可使用。
   2. 透過 `List<String>.from(JSONVALUE)` 或 `Map<String,int>.from(JSONVALUE)` 來轉換 `List` 與 `Map`
   3. 自訂 `class` 則要用 `(JSONVALUE as List<dynamic>).map((e)=>CLASS.fromJson(e)).toList()` 來達成
## [2021-08-20] 已經加入 `TabBar` 與 `TabBarView` 了。
1. 先將excel檔案讀入後變成 JSON 檔，再將人名前兩個變成 ~XX~ ，這樣避免個資外流
``` regexp
   尋找：  ("姓名":\s{1}")(.{2})(.{1})
   替換：  $1XX$3
```
