Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469B42CB20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfE1QJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 12:09:05 -0400
Received: from relay.sw.ru ([185.231.240.75]:38258 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1QJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:09:05 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hVeet-0005lz-4x; Tue, 28 May 2019 19:09:03 +0300
Subject: [PATCH] mm: Fix recent_rotated history
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Tue, 28 May 2019 19:09:02 +0300
Message-ID: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes pointed that after commit 886cf1901db9
we lost all zone_reclaim_stat::recent_rotated
history. This commit fixes that.

Fixes: 886cf1901db9 "mm: move recent_rotated pages calculation to shrink_inactive_list()"
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d9c3e873eca6..1d49329a4d7d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1953,8 +1953,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (global_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
-	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
-	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
+	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
+	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
 
 	move_pages_to_lru(lruvec, &page_list);
 

