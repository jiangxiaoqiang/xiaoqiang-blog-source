---
title: React props的理解
date: 2017-03-22 22:10:44
tags:
- React
Categories: Front-end
---



props是property的缩写，props在父组件中制定，一经指定，在被指定组件的生命周期中不再改变。如果需要改变，使用state。props主要用于组件之间的通信，可以通过父组件向子组件传递数据。

<!-- more -->

#### 父组件向子组件传值

如下代码展示通过props向组件CustomBreadcrumb中传值：

```javascript
return (
  <div>
      <CustomBreadcrumb global={this.props.global}
                        globalService={this.props.globalService}
                        location={this.props.location}
                        items={breadcrumbItems}/>
      <SearchComponent {..._searchProps}/>
  </div>
);
```

##### Prop Validation

在子组件中进行使用之前，可以对props的类型进行验证，如下代码片段所示。

```javascript
export default class CustomBreadcrumb extends Component {
    static propTypes = {
        location: PropTypes.object.isRequired,
        global: PropTypes.object.isRequired,
        globalService: PropTypes.object.isRequired,
        items: PropTypes.arrayOf(PropTypes.object)
};
```



