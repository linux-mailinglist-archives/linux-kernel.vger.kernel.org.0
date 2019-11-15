Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5269DFDE03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKOMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 07:35:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727272AbfKOMfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:35:46 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0945A2EB0BF6AD6BB5B6;
        Fri, 15 Nov 2019 20:35:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 20:35:27 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH -next] perf/core: make two symbols static
Date:   Fri, 15 Nov 2019 20:42:51 +0800
Message-ID: <1573821771-42748-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

kernel/events/core.c:6278:6: warning: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?
kernel/events/core.c:10118:1: warning: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 kernel/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 16d80ad..9fc62e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6275,10 +6275,10 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 	return data->aux_size;
 }

-long perf_pmu_snapshot_aux(struct ring_buffer *rb,
-			   struct perf_event *event,
-			   struct perf_output_handle *handle,
-			   unsigned long size)
+static long perf_pmu_snapshot_aux(struct ring_buffer *rb,
+				  struct perf_event *event,
+				  struct perf_output_handle *handle,
+				  unsigned long size)
 {
 	unsigned long flags;
 	long ret;
@@ -10115,7 +10115,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,

 	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
 }
-DEVICE_ATTR_RO(nr_addr_filters);
+static DEVICE_ATTR_RO(nr_addr_filters);

 static struct idr pmu_idr;

--
2.7.4

