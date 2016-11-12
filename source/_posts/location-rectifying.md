---
title: 地理位置纠偏
tags:
  - Location
categories: Programming
date: 2016-11-08 08:53:10
---


偏移的起因：天朝测绘局以国家安全为理由，用法律的形式对所有在天朝发行的地图类产品加了强制性规范，要求所有地图类产品都必须使用国家测绘局的一种加偏移的算法，对地图的真实坐标进行加偏移处理，之后才可能通过审批准许上市。因此，天朝的所有官方及商用地图的坐标都是偏移的，这种偏移属于非线性的，偏移量在300至500米不等，偏移方向也不定。这种加过偏移的地图坐标就是所谓“火星坐标”。GPS接收机本身接收卫星的信号，计算出本机所在位置的经纬度，在没有做特别处理的时候，这个经纬度是正确的。但是如果GPS支持加载地图的话，这个GPS中的地图就得受上述第一条法规的约束了，所以正式在天朝销售的行货GPS设备中的地图必须也得加偏移，处理成火星坐标。地理位置纠偏代码(处理成火星坐标)：

<!-- more -->

```Java
/*
* Created by jiangxiaoqiang on 2016/11/7.
* 适用于Google,高德体系的地图
*/
public class GpsDataTranslate {

    /**
     * 圆周率
     */
    private static double PI = Math.PI;

    /**
     * 地球的半径(单位:米)
     */
    private static double EARTH_RADIUS = 6378245.0;

    /**
     * ee: 椭球的偏心率(eccentricity of ellipsoid)
     */
    private static double ECCENTRICITY_OF_ELLIPSOID = 0.0066934216229659433;

    private static boolean IsOutOfChina(double latitude, double longitude) {
        return longitude < 72.004 || longitude > 137.8347 || (latitude < 0.8293 || latitude > 55.8271);
    }

    private static double TransformLat(double x, double y) {
        double num = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
        num += (20.0 * Math.sin(6.0 * x * PI) + 20.0 * Math.sin(2.0 * x * PI)) * 2.0 / 3.0;
        num += (20.0 * Math.sin(y * PI) + 40.0 * Math.sin(y / 3.0 * PI)) * 2.0 / 3.0;
        return num + (160.0 * Math.sin(y / 12.0 * PI) + 320.0 * Math.sin(y * PI / 30.0)) * 2.0 / 3.0;
    }

    private static double TransformLon(double x, double y) {
        double num = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
        num += (20.0 * Math.sin(6.0 * x * PI) + 20.0 * Math.sin(2.0 * x * PI)) * 2.0 / 3.0;
        num += (20.0 * Math.sin(x * PI) + 40.0 * Math.sin(x / 3.0 * PI)) * 2.0 / 3.0;
        return num + (150.0 * Math.sin(x / 12.0 * PI) + 300.0 * Math.sin(x / 30.0 * PI)) * 2.0 / 3.0;
    }

    /**
     * 地理位置纠偏
     *
     * @param wgLat
     * @param wgLon
     */
    public static double[] transform(double wgLat, double wgLon) {
        double[] latlng = new double[2];
        if (IsOutOfChina(wgLat, wgLon)) {
            latlng[0] = wgLat;
            latlng[1] = wgLon;
            return latlng;
        }
        double dLat = TransformLat(wgLon - 105.0, wgLat - 35.0);
        double dLon = TransformLon(wgLon - 105.0, wgLat - 35.0);
        double radLat = wgLat / 180.0 * PI;
        double magic = Math.sin(radLat);
        magic = 1 - ECCENTRICITY_OF_ELLIPSOID * magic * magic;
        double sqrtMagic = Math.sqrt(magic);
        dLat = (dLat * 180.0) / ((EARTH_RADIUS * (1 - ECCENTRICITY_OF_ELLIPSOID)) / (magic * sqrtMagic) * PI);
        dLon = (dLon * 180.0) / (EARTH_RADIUS / sqrtMagic * Math.cos(radLat) * PI);
        latlng[0] = (wgLat + dLat);
        latlng[1] = (wgLon + dLon);
        return latlng;
    }
}
```

一对纠偏的数据组示例：

```
原始数据：
29.54163(纬度)
106.508188(经度)

纠偏后数据：
29.538885930651567(纬度)
106.5120118854562(经度)
```


