Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FD196781
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgC1QoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 12:44:00 -0400
Received: from mx.sdf.org ([205.166.94.20]:49870 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgC1Qn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:58 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhIFR001177
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:18 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhIOY022599;
        Sat, 28 Mar 2020 16:43:18 GMT
Message-Id: <202003281643.02SGhIOY022599@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 20 Mar 2019 23:07:46 -0400
Subject: [RFC PATCH v1 29/50] fs/ocfs2/journal: Use prandom_u32() and not
 /dev/random for timeout
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_random_bytes() is expensive crypto-quality random numbers.
If we're just doing random backoff, prandom_u32() is plenty.

(Not to mention fetching 8 bytes of seed material only to
reduce it modulo 5000 is a huge waste.)

Also, convert timeouts to jiffies at compile time; convert
milliseconds to jiffies before picking a random number in the
range to take advantage of compile-time constant folding.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@oss.oracle.com
---
 fs/ocfs2/journal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 68ba354cf3610..939a12e57fa8b 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1884,11 +1884,8 @@ int ocfs2_mark_dead_nodes(struct ocfs2_super *osb)
  */
 static inline unsigned long ocfs2_orphan_scan_timeout(void)
 {
-	unsigned long time;
-
-	get_random_bytes(&time, sizeof(time));
-	time = ORPHAN_SCAN_SCHEDULE_TIMEOUT + (time % 5000);
-	return msecs_to_jiffies(time);
+	return msecs_to_jiffies(ORPHAN_SCAN_SCHEDULE_TIMEOUT) +
+		prandom_u32_max(5 * HZ);
 }
 
 /*
-- 
2.26.0

