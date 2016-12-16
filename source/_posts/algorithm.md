---
title: 算法
date: 2016-12-14 20:05:29
tags:
- algorithm
categories: Programming
---


#### 汉诺塔算法

```Java
static void hannoi(int n, String from, String buffer, String to) {
    if (n == 1) {
        System.out.println("Move disk " + n + " from " + from + " to " + to);
    } else {
        hannoi(n - 1, from, to, buffer);
        System.out.println("Move disk " + n + " from " + from + " to " + to);
        hannoi(n - 1, buffer, from, to);
    }
}

public static void main(String[] args) {
    hannoi(3, "A", "B", "C");
}
```

#### 快速排序

快速排序（英语：Quicksort），又称划分交换排序（partition-exchange sort），一种排序算法，最早由东尼·霍尔提出。在平均状况下，排序n个项目要Ο(n log n)次比较。在最坏状况下则需要Ο(n2)次比较，但这种状况并不常见。事实上，快速排序通常明显比其他Ο(n log n)算法更快，因为它的内部循环（inner loop）可以在大部分的架构上很有效率地被实现出来。

快速排序使用分治法（Divide and conquer）策略来把一个序列（list）分为两个子序列（sub-lists）。
步骤为：
1. 从数列中挑出一个元素，称为"基准"（pivot）
2. 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区结束之后，该基准就处于数列的中间位置。这个称为分区（partition）操作。
3. 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。
递归的最底部情形，是数列的大小是零或一，也就是永远都已经被排序好了。虽然一直递归下去，但是这个算法总会结束，因为在每次的迭代（iteration）中，它至少会把一个元素摆到它最后的位置去。

```Java
public class QuickSort {

    static int[] arr;

    private static void swap(int x, int y) {
        int temp = arr[x];
        arr[x] = arr[y];
        arr[y] = temp;
    }

    private static void quick_sort_recursive(int start, int end) {
        if (start >= end)
            return;
        int mid = arr[end];
        int left = start, right = end - 1;
        while (left < right) {
            while (arr[left] < mid && left < right)
                left++;
            while (arr[right] >= mid && left < right)
                right--;
            swap(left, right);
        }
        if (arr[left] >= arr[end]) {
            swap(left, end);
        } else {
            left++;
        }
        quick_sort_recursive(start, left - 1);
        quick_sort_recursive(left + 1, end);
    }

    public static void sort(int[] arrin) {
        arr = arrin;
        quick_sort_recursive(0, arr.length - 1);
    }

    public static void main(String[] args) {
        int[] array = {1, 5, 3, 2};
        sort(array);
        for (int i = 0; i < array.length; i++) {
            int sortedElement = array[i];
            System.out.println(sortedElement);
        }
    }
}
```
