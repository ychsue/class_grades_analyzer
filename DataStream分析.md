# Data stream

## 1. 先得到先備知識
1. 首先，得先知道 `student` 辨識用的 `ids` (如`姓名`，`座號`) 與 `courseNames` ，
2. 至於 `examNames`，則是各個 Sheet 的名字，且由各個 Sheet 中可取得以 `ids` 標示的 `student`。
3. 所以，三個Dims`:
   1. `examNames`
   2. `student` : 以 `ids` 來區隔
   3. `courseNames` 
   
## 2. 利用 `ids` 與 `courseNames` 取得 `exams`
## 3. 對 `exams` 進行運算，好得出如 `sum`, `average`, `rank` 等物

## 4. 分三種方式觀察：即將整個 `exams` 先取一個維度為主要(Main)，另外兩個當 (x, y)，按照 Main 將一個個z 的 slice 片段變成 table
1. 可指示這三個維度哪些部份要顯現
   1. 所以，可用的尺標一個 `List`，而要顯現的則是它的 Sub-set，也是個 `List`