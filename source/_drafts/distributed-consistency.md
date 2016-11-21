---
title: 分布式一致性问题
tags:
- distributed consistency
categories: Programming
---

分布式领域CAP理论告诉我们，任何一个分布式系统都无法同时满足Consistency(一致性)、Availability(可用性)、Partition tolerance(分区容错性) 这三个基本需求。最多只能满足其中两项。 但是，一个分布式系统无论在CAP三者之间如何权衡，都无法彻底放弃一致性（Consistency），如果真的放弃一致性，那么就说明这个系统中的数据根本不可信，数据也就没有意义，那么这个系统也就没有任何价值可言。所以，无论如何，分布式系统的一致性问题都需要重点关注。(分布式系统的CAP理论、分布式系统的BASE理论)


