Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3433B2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbfFJKBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 06:01:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389030AbfFJKBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:01:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0AE522FA1468851684E8;
        Mon, 10 Jun 2019 18:01:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Jun 2019 18:00:52 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/5] perf jevents: Add support for Hisi hip08 HHA PMU aliasing
Date:   Mon, 10 Jun 2019 17:59:31 +0800
Message-ID: <1560160772-210844-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
References: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Hisi hip08 HHA PMU aliasing.

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_hha_pmu.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/uncore-hha.json     | 51 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
new file mode 100644
index 000000000000..f94b8513166e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -0,0 +1,51 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_sccl_hha.rx_ops_num",
+	    "BriefDescription": "The number of all operations received by the HHA",
+	    "PublicDescription": "The number of all operations received by the HHA",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_sccl_hha.rx_outer",
+	    "BriefDescription": "The number of all operations received by the HHA from another socket",
+	    "PublicDescription": "The number of all operations received by the HHA from another socket",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_sccl_hha.rx_sccl",
+	    "BriefDescription": "The number of all operations received by the HHA from another SCCL in this socket",
+	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1c",
+	    "EventName": "uncore_hisi_sccl_hha.rd_ddr_64b",
+	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
+	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 64bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1d",
+	    "EventName": "uncore_hisi_sccl_hha.wr_dr_64b",
+	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
+	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1e",
+	    "EventName": "uncore_hisi_sccl_hha.rd_ddr_128b",
+	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
+	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1f",
+	    "EventName": "uncore_hisi_sccl_hha.wr_ddr_128b",
+	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
+	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index cf9a60333554..909e53e3b5bd 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -237,6 +237,7 @@ static struct map {
 	{ "CPU-M-SF", "cpum_sf" },
 	{ "UPI LL", "uncore_upi" },
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
+	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{}
 };
 
-- 
2.17.1

