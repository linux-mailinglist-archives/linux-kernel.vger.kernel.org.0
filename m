Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7664A3795B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfFFQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 12:17:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49816 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbfFFQRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:17:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 120D515A2;
        Thu,  6 Jun 2019 09:17:01 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25B613F690;
        Thu,  6 Jun 2019 09:17:00 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 1/4] coresight: tmc-etr: Do not call smp_processor_id() from preemptible
Date:   Thu,  6 Jun 2019 17:16:44 +0100
Message-Id: <1559837807-15447-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559837807-15447-1-git-send-email-suzuki.poulose@arm.com>
References: <1559837807-15447-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a perf session we try to allocate buffers on the "node" associated
with the CPU the event is bound to. If it's not bound to a CPU, we use
the current CPU node, using smp_processor_id(). However this is unsafe
in a pre-emptible context and could generate the splats as below :

 BUG: using smp_processor_id() in preemptible [00000000] code: perf/1743
 caller is alloc_etr_buf.isra.6+0x80/0xa0
 CPU: 1 PID: 1743 Comm: perf Not tainted 5.1.0-rc6-147786-g116841e #344
 Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Feb  1 2019
  Call trace:
   dump_backtrace+0x0/0x150
   show_stack+0x14/0x20
   dump_stack+0x9c/0xc4
   debug_smp_processor_id+0x10c/0x110
   alloc_etr_buf.isra.6+0x80/0xa0
   tmc_alloc_etr_buffer+0x12c/0x1f0
   etm_setup_aux+0x1c4/0x230
   rb_alloc_aux+0x1b8/0x2b8
   perf_mmap+0x35c/0x478
   mmap_region+0x34c/0x4f0
   do_mmap+0x2d8/0x418
   vm_mmap_pgoff+0xd0/0xf8
   ksys_mmap_pgoff+0x88/0xf8
   __arm64_sys_mmap+0x28/0x38
   el0_svc_handler+0xd8/0x138
   el0_svc+0x8/0xc

Use NUMA_NO_NODE hint instead of using the current node for events
not bound to CPUs.

Fixes: 855ab61c16bf70b646 ("coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ce0114a..7c81f63 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1323,13 +1323,11 @@ static struct etr_perf_buffer *
 tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 		       int nr_pages, void **pages, bool snapshot)
 {
-	int node, cpu = event->cpu;
+	int node;
 	struct etr_buf *etr_buf;
 	struct etr_perf_buffer *etr_perf;
 
-	if (cpu == -1)
-		cpu = smp_processor_id();
-	node = cpu_to_node(cpu);
+	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
 
 	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
 	if (!etr_perf)
-- 
2.7.4

