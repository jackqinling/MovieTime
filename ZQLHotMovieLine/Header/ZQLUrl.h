//
//  ZQLUrl.h
//  ZQLHotMovieLine
//
//  Created by MS on 16-1-9.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#ifndef ZQLHotMovieLine_ZQLUrl_h
#define ZQLHotMovieLine_ZQLUrl_h

#define BaseUrl @"http://api.m.mtime.cn/"

//首页 POST
#define FirstPageUrl @"http://api.m.mtime.cn/PageSubArea/GetFirstPageAdvAndNews.api"
//首页头视图 GET
#define HeadUrl @"http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api"

//搜索按钮
#define SearchMovieUrl @"http://api.m.mtime.cn/Search/HotKeyWords.api"

//电影详情页  拼locationId  movieId
#define MovieDetailUrl @"http://m.mtime.cn/Service/callback.mi/movie/Detail.api"
//评论详情页  传入 movieId 和 pageIndex
#define CommentUrl @"http://api.m.mtime.cn/Movie/HotLongComments.api?movieId=192895&pageIndex=1"

//电影周边  传入 relatedId 对应movieId
#define RelatedGoodsUrl @"http://api.m.mtime.cn/Search/RelatedGoodsById.api?relatedObjType=1"
//http://api.m.mtime.cn/Search/RelatedGoodsById.api?relatedId=177861&relatedObjType=1
//传入movieId
#define ActorsUrl @"http://m.mtime.cn/Service/callback.mi/Movie/MovieCreditsWithTypes.api"
//http://m.mtime.cn/Service/callback.mi/movie/Detail.api?locationId=290&movieId=229451
//http://api.m.mtime.cn/Advertisement/MovieDetailAdvertisement.api?locationId=290&movieId=209410
#define CityUrl @"http://m.mtime.cn/Service/callback.mi/Showtime/HotCitiesByCinema.api"

//头视图 电影详情页  参数  movieId  pageIndex

//评论
#define LongCommentUrl @"http://api.m.mtime.cn/Movie/HotLongComments.api"
//传入 movieId 164011 pageIndex
//http://api.m.mtime.cn/Movie/HotLongComments.api?movieId=229451&pageIndex=1
#define ShortCommentUrl @"http://api.m.mtime.cn/Showtime/MovieComments.api"
//http://api.m.mtime.cn/Showtime/MovieComments.api?movieId=205222&pageIndex=1

//电影预告片&拍摄花絮
//传入movieId  和  pageIndex 对应videoList键 返回数组
//http://api.m.mtime.cn/Movie/Video.api?movieId=205222&pageIndex=1
#define VideoListUrl @"http://api.m.mtime.cn/Movie/Video.api"

/*******购票  第二页********/
//上映的电影
#define ShowingUrl @"http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=290"

//在线电影院
#define CinemaUrl @"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api?locationId=290&deviceToken={1}"


/*******商城  第三页*********/

#define MarketUrl @"http://api.m.mtime.cn/PageSubArea/MarketFirstPageNew.api"
//四个商城按钮

//玩具
#define ToyUrl @"http://mall.wv.mtime.cn/Service/callback.mi/ECommerce/SearchGoods.api?keyword=&pageIndex=3&sf=0&sm=2&topicId=0&movieId=0&roleId=0&categoryId1=25&categoryId2=0&brandId=0&fmin=0&fmax=0&salefid=0&cd=0&t=20161102024012468"
//数码
#define DigitalUrl @"http://mall.wv.mtime.cn/Service/callback.mi/ECommerce/SearchGoods.api?keyword=&pageIndex=1&sf=0&sm=2&topicId=0&movieId=0&roleId=0&categoryId1=8&categoryId2=0&brandId=0&fmin=0&fmax=0&salefid=0&cd=0&t=20161102062879069"

//服饰
#define ClothUrl @"http://mall.wv.mtime.cn/Service/callback.mi/ECommerce/SearchGoods.api?keyword=&pageIndex=6&sf=0&sm=2&topicId=0&movieId=0&roleId=0&categoryId1=42&categoryId2=0&brandId=0&fmin=0&fmax=0&salefid=0&cd=0&t=201611020192633616"

//家居
#define FurnitureUrl @"http://mall.wv.mtime.cn/Service/callback.mi/ECommerce/SearchGoods.api?keyword=&pageIndex=2&sf=0&sm=2&topicId=0&movieId=0&roleId=0&categoryId1=43&categoryId2=0&brandId=0&fmin=0&fmax=0&salefid=0&cd=0&t=201611020211321408"

/******发现  第四页*****/

//四个头视图  新闻  预告片 排行榜  影评
#define DiscoverUrl @"http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api"

//1.新闻单页

//新闻表单
#define NewLineUrl @"http://api.m.mtime.cn/News/NewsList.api?pageIndex=1"

//内地票房榜  全球票房榜
//内地 2020  北美 2015  韩国 2018  台湾  2019   日本 2017  香港 2016
#define MainLandRankUrl @"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?pageIndex=1&pageSubAreaID=2020"

//2.预告片

#define PreviewUrl @"http://api.m.mtime.cn/PageSubArea/TrailerList.api"

//3.排行榜
#define AllRankUrl @"http://www.bejson.com/jsonviewernew/"

//4.影评
#define ReviewUrl @"http://api.m.mtime.cn/MobileMovie/Review.api?needTop=false"

//影评页  传入reviewId
#define ReviewDetailUrl @"http://api.m.mtime.cn/Review/Detail.api?reviewId=7935365"
//货物详情
//http://mall.wv.mtime.cn/Service/callback.mi/ECommerce/GoodsInfo.api?goodsId=101778&t=201623811035950
#endif
