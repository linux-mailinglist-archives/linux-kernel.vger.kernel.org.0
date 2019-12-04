Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9DE11358F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfLDTQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:16:30 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35441 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbfLDTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:16:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Tk-OVMC_1575486978;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tk-OVMC_1575486978)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Dec 2019 03:16:25 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        shakeelb@google.com, guro@fb.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: vmscan: protect shrinker idr replace with CONFIG_MEMCG
Date:   Thu,  5 Dec 2019 03:16:18 +0800
Message-Id: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
protect shrinker idr replace with CONFIG_MEMCG_KMEM.

Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee4eecc..e7f10c4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
-- 
1.8.3.1

