Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D99E25FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfEVIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 04:44:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:41254 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbfEVIoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:44:12 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hTMr0-00022D-Lf; Wed, 22 May 2019 11:44:06 +0300
Subject: [PATCH] mm: Rename mm_vmscan_lru_shrink_inactive trace event
 variables
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mjeanson@efficios.com,
        rostedt@goodmis.org, lttng-dev@lists.lttng.org,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Wed, 22 May 2019 11:44:06 +0300
Message-ID: <155851455676.7870.1951762540769724271.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename nr_activate{0,1} into nr_activate{anon,file} since this
is exported into userspace, e.g., it's shown here:

/sys/kernel/debug/tracing/events/vmscan/mm_vmscan_lru_shrink_inactive/format.

Now we have:
field:unsigned int nr_activate0;	offset:64;	size:4;	signed:0;
field:unsigned int nr_activate1;	offset:68;	size:4;	signed:0;

The patch changes these to:
field:unsigned int nr_activate_anon;	offset:64;	size:4;	signed:0;
field:unsigned int nr_activate_file;	offset:68;	size:4;	signed:0;

which is better readable.

Suggested-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/trace/events/vmscan.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a5ab2973e8dc..c316279715f4 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -348,8 +348,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned long, nr_writeback)
 		__field(unsigned long, nr_congested)
 		__field(unsigned long, nr_immediate)
-		__field(unsigned int, nr_activate0)
-		__field(unsigned int, nr_activate1)
+		__field(unsigned int, nr_activate_anon)
+		__field(unsigned int, nr_activate_file)
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
 		__field(int, priority)
@@ -364,8 +364,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_writeback = stat->nr_writeback;
 		__entry->nr_congested = stat->nr_congested;
 		__entry->nr_immediate = stat->nr_immediate;
-		__entry->nr_activate0 = stat->nr_activate[0];
-		__entry->nr_activate1 = stat->nr_activate[1];
+		__entry->nr_activate_anon = stat->nr_activate[0];
+		__entry->nr_activate_file = stat->nr_activate[1];
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
 		__entry->priority = priority;
@@ -377,7 +377,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
-		__entry->nr_activate0, __entry->nr_activate1,
+		__entry->nr_activate_anon, __entry->nr_activate_file,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
 		__entry->priority,
 		show_reclaim_flags(__entry->reclaim_flags))

