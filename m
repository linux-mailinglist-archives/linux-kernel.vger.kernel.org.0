Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DE8D0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHNKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:41:53 -0400
Received: from foss.arm.com ([217.140.110.172]:51882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfHNKlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B151576;
        Wed, 14 Aug 2019 03:41:46 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9024D3F706;
        Wed, 14 Aug 2019 03:41:44 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 3/9] kmemleak: correctly check for kthreads
Date:   Wed, 14 Aug 2019 11:41:25 +0100
Message-Id: <20190814104131.20190-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, a non-NULL current->mm doesn't imply that current is a
kthread, as kthreads can install an mm via use_mm(), and so it's
preferable to use is_kthread() to determine whether a thread is a
kthread.

For consistency, let's use is_kthread() here.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 mm/kmemleak.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6e9e8cca663e..42ea3c14b577 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1290,10 +1290,10 @@ static int scan_should_stop(void)
 	 * This function may be called from either process or kthread context,
 	 * hence the need to check for both stop conditions.
 	 */
-	if (current->mm)
-		return signal_pending(current);
-	else
+	if (is_kthread(current))
 		return kthread_should_stop();
+	else
+		return signal_pending(current);
 
 	return 0;
 }
-- 
2.11.0

