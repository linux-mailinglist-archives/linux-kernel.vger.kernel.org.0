Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F6E94F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 03:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfJ3CBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 22:01:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfJ3CBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:01:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48AB779C9883EABF377B;
        Wed, 30 Oct 2019 10:01:42 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 10:01:31 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <hannes@cmpxchg.org>, <guro@fb.com>, <shakeelb@google.com>,
        <chris@chrisdown.name>, <yang.shi@linux.alibaba.com>,
        <tj@kernel.org>, <tglx@linutronix.de>, <hushiyuan@huawei.com>,
        <wuxu.wu@huawei.com>, <zhangpan26@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix a typo of memcg annotation.
Date:   Wed, 30 Oct 2019 10:01:57 +0800
Message-ID: <1572400917-28079-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a annotation forgot to follow the patchset of `Move LRU page reclaim from zones to nodes`.
I corrected it to avoid misunderstanding.

Signed-off-by: Pan Zhang <zhangpan26@huawei.com>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ae703ea..e211689 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -112,7 +112,7 @@ struct memcg_shrinker_map {
 };
 
 /*
- * per-zone information in memory controller.
+ * per-node information in memory controller.
  */
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
-- 
2.7.4

