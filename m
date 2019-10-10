Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B9D3132
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJJTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:14:10 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:38039 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbfJJTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:14:09 -0400
Received: from [4.30.142.84] (helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1iIdWx-000aCB-2m; Thu, 10 Oct 2019 14:51:19 -0400
Subject: [PATCH 3/3] tracing/hwlat: Fix a few trivial nits
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     amakhalov@vmware.com, akaher@vmware.com, anishs@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu
Date:   Thu, 10 Oct 2019 11:51:17 -0700
Message-ID: <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
In-Reply-To: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
References: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Update the source file name in the comments, and fix a grammatical
error.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
---

 kernel/trace/trace_hwlat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 862f4b0..941cb82 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * trace_hwlatdetect.c - A simple Hardware Latency detector.
+ * trace_hwlat.c - A simple Hardware Latency detector.
  *
  * Use this tracer to detect large system latencies induced by the behavior of
  * certain underlying system hardware or firmware, independent of Linux itself.
@@ -276,7 +276,7 @@ static void move_to_next_cpu(void)
 		return;
 	/*
 	 * If for some reason the user modifies the CPU affinity
-	 * of this thread, than stop migrating for the duration
+	 * of this thread, then stop migrating for the duration
 	 * of the current test.
 	 */
 	if (!cpumask_equal(current_mask, current->cpus_ptr))

