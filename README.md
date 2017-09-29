## 檔案說明
- taipei_stolen_map.Rmd: 用來產生 R markdown 的報告使用
- 臺北市10401-10608住宅竊盜點位資訊.csv: 已加上 lat/lon
- stolen_in_taipei_10401_10608.csv: 和  臺北市10401-10608住宅竊盜點位資訊.csv 一模一樣, 只是用英文檔名
- getLatLon_for_stolen_addr.py: 抓 臺北市10401-10608住宅竊盜點位資訊.csv 的Lat/Lon
- getLatLon_forA_Lvr.py: 抓實價登錄的 Lat/Lon, 這邊只會針對土地+房+車位(車位是可以可無) 的交易類別做轉換
- stolen_pricing.R: 針對住宅竊盜產生一些資訊並放在地圖上, 也有簡單的統計數據, 如果想要單純跑看看, 可以一行一行執行看結果

## 如何設定
- 請修改 taipei_stolen_map.Rmd 的

```
shp_file_name="/Users/sary357/Downloads/R_Report/TOWN_MOI_1060831.shp"
data_file_name="/Users/sary357/Downloads/R_Report/stolen_in_taipei_10401_10608.csv"
```
- data_file_name: 請寫明 stolen_in_taipei_10401_10608.csv 本機的絕對路徑
- shp_file_name: 請到 TOWN_MOI_1060831.shp 本機的絕對路徑
- 在 RStudio 執行 "Run Presentation" 即可
