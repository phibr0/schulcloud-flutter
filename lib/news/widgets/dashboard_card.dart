import 'package:flutter/material.dart';
import 'package:schulcloud/app/app.dart';
import 'package:schulcloud/dashboard/dashboard.dart';

import '../data.dart';
import '../news.dart';
import 'article_screen.dart';

class NewsDashboardCard extends StatelessWidget {
  static const articleCount = 3;

  @override
  Widget build(BuildContext context) {
    final s = context.s;

    return DashboardCard(
      title: s.news_dashboardCard,
      footerButtonText: s.news_dashboardCard_all,
      onFooterButtonPressed: () => context.navigator
          .push(MaterialPageRoute(builder: (context) => NewsScreen())),
      child: FancyCachedBuilder<List<Article>>.handleLoading(
        controller: services.storage.root.news.controller,
        builder: (context, articles, isFetching) {
          if (articles.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(s.news_dashboardCard_empty),
            );
          }

          articles.sort((a1, a2) => -a1.publishedAt.compareTo(a2.publishedAt));
          articles = articles.take(articleCount).toList();

          return Column(
            children: <Widget>[
              for (final article in articles)
                _buildArticlePreview(context, article),
            ],
          );
        },
      ),
    );
  }

  Widget _buildArticlePreview(BuildContext context, Article article) {
    return InkWell(
      onTap: () => context.navigator.push(MaterialPageRoute(
        builder: (context) => ArticleScreen(article: article),
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Expanded(
                  child: Text(article.title, style: context.textTheme.subhead),
                ),
                SizedBox(width: 8),
                Text(
                  article.publishedAt.shortDateString,
                  style: context.textTheme.caption,
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              article.content.withoutLinebreaks,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.body1.copyWith(
                color: context.theme.mediumEmphasisColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
