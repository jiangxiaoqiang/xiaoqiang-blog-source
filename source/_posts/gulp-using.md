---
title: gulp-using
date: 2017-02-20 10:45:16
tags:
---


gulp只有五个方法： `task`，`run`，`watch`，`src`，和`dest`。

<!-- more -->

#### task

```javascript
gulp.task('img', function () {
    gulp.src(['./site/img/**/*.*'])
        .pipe(
            gulp.dest('./dist/site/img/')
        );
});
```

将图标拷贝到目标目录.

#### watch

使用`.watch()`方法去监听指定目录的文件变化，当有文件变化时，会运行回调定义的其他任务。

```javascript
gulp.task('watch', function () {
    gulp.watch('./site/**/*.html', ['ejs']);
    gulp.watch('./site/js/**/*.js', ['js']);
    gulp.watch('./site/css/**/*.less', ['less']);
    gulp.watch('./site/img/**/*.*', ['img']);
});
```

### #





