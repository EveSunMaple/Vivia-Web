---
title: 全站统计
date: 2023-05-14 10:29:55
---
<!-- 文章发布时间统计图 -->
<div id="posts-chart" data-start="2021-01" style="border-radius: 8px; height: 300px; padding: 10px;"></div>
<!-- 文章标签统计图 -->
<div id="tags-chart" data-length="10" style="border-radius: 8px; height: 300px; padding: 10px;"></div>
<!-- 文章分类统计图 -->
<div id="categories-chart" data-parent="true" style="border-radius: 8px; height: 300px; padding: 10px;"></div>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    站点访问量 <span id="qexo-site-pv">Loading...</span>
    站点访客数 <span id="qexo-site-uv">Loading...</span>
    页面访问量 <span id="qexo-page-pv">Loading...</span>
    <script src="https://cdn.jsdelivr.net/npm/qexo-static@1.6.0/hexo/statistic.js"></script>
    <script>
        loadStatistic("https://qexo.yoursite.com")
    </script>
</body>
</html>