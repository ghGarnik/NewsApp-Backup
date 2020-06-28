//
//  MockArticleObject.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 28/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation
@testable import NewsApp

enum MockArticleObject {
    private static let mockArticleResponse = ArticleDetailResponse(content: "Future Workshops has over a decade of experience building Apps and Platforms for millions of people worldwide. We want to share our knowledge, connections and expertise to help entrepreneurs grow their ideas and companies — so we started a regular meetup which is open to everyone and includes pizza!\nOur meetup thrives on the startups and speakers who have shared their inspirational stories. In return, previous attendees found investment leads, business opportunities, new sales, and received technical advice.\n— — — — — — — — — — — — — — — — — — — — — — — — — — — — — —\nWe want you to succeed\nOur goal is to help you, the startups. We want you to be direct, and tell us how we can help. For example, you may be looking for investment, need focussed advice on how to conduct user research, or want to go over your prototype or elevator pitch. Tell us at the start of your pitch, and tell us again at the end. Talk to us and we will arrange followups with relevant experts. We want to follow and assist in your startup journey — it doesn’t end once the meetup is over.\nWe want to share diverse stories with our audiences\nBeing successful in business doesn’t just mean running a big profitable business or being an expert in what you do. We’ve heard stories about failure, impostor syndrome, challenges of parenting, and business ideas ranging from personal care to finance.\nWe want to have an inclusive speaker selection\nWe welcome all startups and ideas to speak at the Meetup, regardless of your background, experience, maturity of your business or what you do for work. Please feel welcome to get in touch and chat with us, even if you feel unsure about presenting. We can give guidance, advice, provide help with slideshow presentations and provide previous examples.\n♀ In March, we celebrated Women’s History Month by having a full startup panel led by female Entrepreneurs. Its our goal to welcome speakers from diverse backgrounds in tech.",
                                                   date: "2019-05-15",
                                                   id: 127,
                                                   imageUrl: "https://miro.medium.com/1*hFIdXmRlY278dzunhO5Mew.png",
                                                   summary: "Apps4Startups is an event for entrepreneurs to discuss, share, pitch and network, run by Future Workshops.",
                                                   title: "Speaking at Apps4Startups")
    static let mockArticle = ArticleDetail(response: MockArticleObject.mockArticleResponse)
}
