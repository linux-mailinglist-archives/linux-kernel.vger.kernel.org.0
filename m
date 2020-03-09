Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC917E801
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCITFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbgCITE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191B62468D;
        Mon,  9 Mar 2020 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780667;
        bh=64cjWCbiThdHFvvHyU3CCz9FjTHDjRwEeHSwlRZf0BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Udws6YeYpOcyByJ+CcccVQH8qZfCiLSomJ08n0VhegRHjEwtpHU4Kt6ZNtjoAL2n7
         vFBVbrcVx3KTSd8TjUv6rkYjR+hfHUvHSM/DkU7YNdxY7G1ZAtdg0aiNmyNfEFoF6L
         JMhPt2TdLiaQvn6fuJr9HDMinMlovucALLyiVMHk=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 20/32] kcsan: Fix misreporting if concurrent races on same address
Date:   Mon,  9 Mar 2020 12:04:08 -0700
Message-Id: <20200309190420.6100-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

If there are at least 4 threads racing on the same address, it can
happen that one of the readers may observe another matching reader in
other_info. To avoid locking up, we have to consume 'other_info'
regardless, but skip the report. See the added comment for more details.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 3bc590e..abf6852 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -422,6 +422,44 @@ static bool prepare_report(unsigned long *flags, const volatile void *ptr,
 			return false;
 		}
 
+		access_type |= other_info.access_type;
+		if ((access_type & KCSAN_ACCESS_WRITE) == 0) {
+			/*
+			 * While the address matches, this is not the other_info
+			 * from the thread that consumed our watchpoint, since
+			 * neither this nor the access in other_info is a write.
+			 * It is invalid to continue with the report, since we
+			 * only have information about reads.
+			 *
+			 * This can happen due to concurrent races on the same
+			 * address, with at least 4 threads. To avoid locking up
+			 * other_info and all other threads, we have to consume
+			 * it regardless.
+			 *
+			 * A concrete case to illustrate why we might lock up if
+			 * we do not consume other_info:
+			 *
+			 *   We have 4 threads, all accessing the same address
+			 *   (or matching address ranges). Assume the following
+			 *   watcher and watchpoint consumer pairs:
+			 *   write1-read1, read2-write2. The first to populate
+			 *   other_info is write2, however, write1 consumes it,
+			 *   resulting in a report of write1-write2. This report
+			 *   is valid, however, now read1 populates other_info;
+			 *   read2-read1 is an invalid conflict, yet, no other
+			 *   conflicting access is left. Therefore, we must
+			 *   consume read1's other_info.
+			 *
+			 * Since this case is assumed to be rare, it is
+			 * reasonable to omit this report: one of the other
+			 * reports includes information about the same shared
+			 * data, and at this point the likelihood that we
+			 * re-report the same race again is high.
+			 */
+			release_report(flags, KCSAN_REPORT_RACE_SIGNAL);
+			return false;
+		}
+
 		/*
 		 * Matching & usable access in other_info: keep other_info_lock
 		 * locked, as this thread consumes it to print the full report;
-- 
2.9.5

