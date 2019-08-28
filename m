Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249869FB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH1HSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:18:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38969 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1HSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:18:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id g8so1812473edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4tygEA7hdMTAmlKH0W1U33PjlTpQI6lJR6+C+DfktA=;
        b=NPP15WugbrbQXPEDmaZwn4X/yzFmF9FPlFpBNpqUy6g0lTD0fI1ulsRmIC/U00xjq6
         W+O6BU+u2ugWUn3Q1/XxWKcVuHKZYot6PjBlmVgrXmTOHb6e9yDczMIcRzA+eDuD2lkz
         V+GOzbWTrRXY3b1dEyX7dIhWckjcqfZS52KNNZkN7SD8tWgKGVluUdd1GP6oujNFAHfZ
         Q20gQknIEUzEnswemjqb+UOBKuGzvYOSH/Xf6qAVaTA8Znlm1cIwDy3kLTcR6IdbQttQ
         IEVX407vJa3WvJdQJAo0ldDZROdyeu6iKHiLrenXUGU5ZwhykHEanzQCnz7J5c/XETw7
         eO0g==
X-Gm-Message-State: APjAAAWsGQffgvabnGLgsEw9AKN6p6Kki3faw11fQh7aYkHM2uKEicbJ
        AU/tGDj+aqEg77Fyln1gjF4=
X-Google-Smtp-Source: APXvYqx8RZh3jXZjSGE4MwlVL2inkV97jj78gIfYfWZpFlCJSBjw/ehfjxk7ZWkKSVITMEKA1h8pEA==
X-Received: by 2002:a50:c90d:: with SMTP id o13mr2607574edh.148.1566976721988;
        Wed, 28 Aug 2019 00:18:41 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y19sm278969edu.90.2019.08.28.00.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:18:39 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hillf Danton <hdanton@sina.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Adric Blake <promarbler14@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH] mm, memcg: do not set reclaim_state on soft limit reclaim
Date:   Wed, 28 Aug 2019 09:18:08 +0200
Message-Id: <20190828071808.20410-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Adric Blake has noticed[1] the following warning:
[38491.963105] WARNING: CPU: 7 PID: 175 at mm/vmscan.c:245 set_task_reclaim_state+0x1e/0x40
[...]
[38491.963239] Call Trace:
[38491.963246]  mem_cgroup_shrink_node+0x9b/0x1d0
[38491.963250]  mem_cgroup_soft_limit_reclaim+0x10c/0x3a0
[38491.963254]  balance_pgdat+0x276/0x540
[38491.963258]  kswapd+0x200/0x3f0
[38491.963261]  ? wait_woken+0x80/0x80
[38491.963265]  kthread+0xfd/0x130
[38491.963267]  ? balance_pgdat+0x540/0x540
[38491.963269]  ? kthread_park+0x80/0x80
[38491.963273]  ret_from_fork+0x35/0x40
[38491.963276] ---[ end trace 727343df67b2398a ]---

which tells us that soft limit reclaim is about to overwrite the
reclaim_state configured up in the call chain (kswapd in this case but
the direct reclaim is equally possible). This means that reclaim stats
would get misleading once the soft reclaim returns and another reclaim
is done.

Fix the warning by dropping set_task_reclaim_state from the soft reclaim
which is always called with reclaim_state set up.

Reported-by: Adric Blake <promarbler14@gmail.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>

[1] http://lkml.kernel.org/r/CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com
---
 mm/vmscan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c77d1e3761a7..a6c5d0b28321 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3220,6 +3220,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 
 #ifdef CONFIG_MEMCG
 
+/* Only used by soft limit reclaim. Do not reuse for anything else. */
 unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 						gfp_t gfp_mask, bool noswap,
 						pg_data_t *pgdat,
@@ -3235,7 +3236,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	};
 	unsigned long lru_pages;
 
-	set_task_reclaim_state(current, &sc.reclaim_state);
+	WARN_ON_ONCE(!current->reclaim_state);
+
 	sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
 
@@ -3253,7 +3255,6 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 
 	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
 
-	set_task_reclaim_state(current, NULL);
 	*nr_scanned = sc.nr_scanned;
 
 	return sc.nr_reclaimed;
-- 
2.20.1

