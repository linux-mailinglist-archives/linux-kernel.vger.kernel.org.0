Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017218D0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfHNKmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:42:00 -0400
Received: from foss.arm.com ([217.140.110.172]:51982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfHNKl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59CC81570;
        Wed, 14 Aug 2019 03:41:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 846FD3F706;
        Wed, 14 Aug 2019 03:41:54 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 7/9] x86/lbr: correctly check for kthreads
Date:   Wed, 14 Aug 2019 11:41:29 +0100
Message-Id: <20190814104131.20190-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 lbr branch_type() functions looks at current->mm, apparently to
determine whether the thread is a kthread without any valid user
context.

In general, a non-NULL current->mm doesn't imply that current is a
kthread, as kthreads can install an mm via use_mm(), and so it's
preferable to use is_kthread() to determine whether a thread is a
kthread.

For consistency, let's use is_kthread() here.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/events/intel/lbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6f814a27416b..ed2b7e57a249 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -857,7 +857,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 		 * can happen if measuring at the user level only
 		 * and we interrupt in a kernel thread, e.g., idle.
 		 */
-		if (!current->mm)
+		if (is_kthread(current))
 			return X86_BR_NONE;
 
 		/* may fail if text not present */
-- 
2.11.0

