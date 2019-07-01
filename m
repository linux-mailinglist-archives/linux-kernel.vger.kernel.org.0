Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91683217D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfEQLmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 07:42:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727727AbfEQLmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:42:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5610AECD;
        Fri, 17 May 2019 11:42:05 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH v2] memcg: make it work on sparse non-0-node systems
Date:   Fri, 17 May 2019 13:42:04 +0200
Message-Id: <20190517114204.6330-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517080044.tnwhbeyxcccsymgf@esperanza>
References: <20190517080044.tnwhbeyxcccsymgf@esperanza>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a single node system with node 0 disabled:
  Scanning NUMA topology in Northbridge 24
  Number of physical nodes 2
  Skipping disabled node 0
  Node 1 MemBase 0000000000000000 Limit 00000000fbff0000
  NODE_DATA(1) allocated [mem 0xfbfda000-0xfbfeffff]

This causes crashes in memcg when system boots:
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
  #PF error: [normal kernel read fault]
...
  RIP: 0010:list_lru_add+0x94/0x170
...
  Call Trace:
   d_lru_add+0x44/0x50
   dput.part.34+0xfc/0x110
   __fput+0x108/0x230
   task_work_run+0x9f/0xc0
   exit_to_usermode_loop+0xf5/0x100

It is reproducible as far as 4.12. I did not try older kernels. You have
to have a new enough systemd, e.g. 241 (the reason is unknown -- was not
investigated). Cannot be reproduced with systemd 234.

The system crashes because the size of lru array is never updated in
memcg_update_all_list_lrus and the reads are past the zero-sized array,
causing dereferences of random memory.

The root cause are list_lru_memcg_aware checks in the list_lru code.
The test in list_lru_memcg_aware is broken: it assumes node 0 is always
present, but it is not true on some systems as can be seen above.

So fix this by avoiding checks on node 0. Remember the memcg-awareness
by a bool flag in struct list_lru.

[v2] use the idea proposed by Vladimir -- the bool flag.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Suggested-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: <cgroups@vger.kernel.org>
Cc: <linux-mm@kvack.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 include/linux/list_lru.h | 1 +
 mm/list_lru.c            | 8 +++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index aa5efd9351eb..d5ceb2839a2d 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -54,6 +54,7 @@ struct list_lru {
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 	int			shrinker_id;
+	bool			memcg_aware;
 #endif
 };
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0730bf8ff39f..d3b538146efd 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
 
 static inline bool list_lru_memcg_aware(struct list_lru *lru)
 {
-	/*
-	 * This needs node 0 to be always present, even
-	 * in the systems supporting sparse numa ids.
-	 */
-	return !!lru->node[0].memcg_lrus;
+	return lru->memcg_aware;
 }
 
 static inline struct list_lru_one *
@@ -451,6 +447,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
 	int i;
 
+	lru->memcg_aware = memcg_aware;
+
 	if (!memcg_aware)
 		return 0;
 
-- 
2.21.0

