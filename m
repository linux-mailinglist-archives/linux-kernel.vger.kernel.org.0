Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53ACE8D0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfHNKl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:41:58 -0400
Received: from foss.arm.com ([217.140.110.172]:51934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfHNKlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:41:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648A1360;
        Wed, 14 Aug 2019 03:41:51 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E2F63F706;
        Wed, 14 Aug 2019 03:41:49 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        riel@surriel.com, will@kernel.org
Subject: [PATCH 5/9] arm64: correctly check for ktrheads
Date:   Wed, 14 Aug 2019 11:41:27 +0100
Message-Id: <20190814104131.20190-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814104131.20190-1-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit:

  6eb6c80187c55b7f ("arm64: kernel thread don't need to save fpsimd context.")

... we skip saving the fpsimd state for kernel threads in
arch_dup_task_struct(). We determine whether current is a kthread by
looking at current->mm.

In general, a non-NULL current->mm doesn't imply that current is a
kthread, as kthreads can install an mm via use_mm(), and so it's
preferable to use is_kthread() to determine whether a thread is a
kthread.

For consistency, let's use is_kthread() here.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 288012687c29..82b0a7a257cd 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -335,7 +335,7 @@ void arch_release_task_struct(struct task_struct *tsk)
  */
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	if (current->mm)
+	if (!is_kthread(current))
 		fpsimd_preserve_current_state();
 	*dst = *src;
 
-- 
2.11.0

