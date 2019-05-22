Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4F262D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfEVLPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 07:15:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48256 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfEVLPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:15:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B76DC341;
        Wed, 22 May 2019 04:15:43 -0700 (PDT)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8AA43F575;
        Wed, 22 May 2019 04:15:42 -0700 (PDT)
From:   Andrew Murray <andrew.murray@arm.com>
To:     peterz@infradead.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Date:   Wed, 22 May 2019 12:15:37 +0100
Message-Id: <20190522111537.27815-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are able to allocate a cpumask in on_each_cpu_cond_mask
we call functions with on_each_cpu_mask - this masks out offline
cpus via smp_call_function_many.

However when we fail to allocate a cpumask in on_each_cpu_cond_mask
we call functions with smp_call_function_single - this will return
-ENXIO from generic_exec_single if a CPU is offline which will
result in a WARN_ON_ONCE.

Let's avoid the WARN by only calling smp_call_function_single when
the CPU is online and thus making both paths consistent with each
other.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 kernel/smp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index f4cf1b0bb3b8..10970692f1c0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -259,6 +259,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 
 /*
  * smp_call_function_single - Run a function on a specific CPU
+ * @cpu:  The CPU to run on.
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
  * @wait: If true, wait until function has completed on other CPUs.
@@ -657,6 +658,8 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  *		completed on other CPUs.
  * @gfp_flags:	GFP flags to use when allocating the cpumask
  *		used internally by the function.
+ * @mask:	The set of cpus to run on (only runs on online
+		subset).
  *
  * The function might sleep if the GFP flags indicates a non
  * atomic allocation is allowed.
@@ -690,12 +693,13 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
 		 * just have to IPI them one by one.
 		 */
 		preempt_disable();
-		for_each_cpu(cpu, mask)
-			if (cond_func(cpu, info)) {
+		for_each_cpu(cpu, mask) {
+			if (cpu_online(cpu) && cond_func(cpu, info)) {
 				ret = smp_call_function_single(cpu, func,
 								info, wait);
 				WARN_ON_ONCE(ret);
 			}
+		}
 		preempt_enable();
 	}
 }
-- 
2.21.0

