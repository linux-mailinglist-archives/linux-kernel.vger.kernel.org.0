Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A243219AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfEJJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 05:31:20 -0400
Received: from foss.arm.com ([217.140.101.70]:41152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfEJJbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:31:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D099CA78;
        Fri, 10 May 2019 02:31:18 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3CF73F738;
        Fri, 10 May 2019 02:31:17 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4/4] coresight: etb10: Do not call smp_processor_id from preemptible
Date:   Fri, 10 May 2019 10:31:03 +0100
Message-Id: <1557480663-16759-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557480663-16759-1-git-send-email-suzuki.poulose@arm.com>
References: <1557480663-16759-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We find the current CPU using smp_processor_id() if the event is not bound
to a CPU, to find the node for memory allocation. Use the safe
numa_node_id() instead, to avoid BUG(). e.g:

 BUG: using smp_processor_id() in preemptible [00000000] code: perf/2544

Fixes: 2997aa4063d97fdb39 ("coresight: etb10: implementing AUX API")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index bdd4fd5..a38b38a 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -374,12 +374,10 @@ static void *etb_alloc_buffer(struct coresight_device *csdev,
 			      struct perf_event *event, void **pages,
 			      int nr_pages, bool overwrite)
 {
-	int node, cpu = event->cpu;
+	int node;
 	struct cs_buffers *buf;
 
-	if (cpu == -1)
-		cpu = smp_processor_id();
-	node = cpu_to_node(cpu);
+	node = (event->cpu == -1) ? numa_node_id() : cpu_to_node(event->cpu);
 
 	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
 	if (!buf)
-- 
2.7.4

