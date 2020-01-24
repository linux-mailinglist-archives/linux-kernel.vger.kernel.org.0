Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58522148A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbgAXOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:39:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388989AbgAXOjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 587E2253B7DCCCBE7187;
        Fri, 24 Jan 2020 22:39:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 Jan 2020 22:38:53 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <ak@linux.intel.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 2/7] perf vendor events arm64: Relocate hip08 core events
Date:   Fri, 24 Jan 2020 22:35:00 +0800
Message-ID: <1579876505-113251-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate the core events JSONs to match to future structure, which will
have separate folders for CPU and uncore/system events.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/{ => cpu}/core-imp-def.json      | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/core-imp-def.json (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/core-imp-def.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
rename to tools/perf/pmu-events/arch/arm64/hisilicon/hip08/cpu/core-imp-def.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 0d609149b82a..c92cb3b519fc 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -20,5 +20,5 @@
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
-0x00000000480fd010,v1,hisilicon/hip08,core
+0x00000000480fd010,v1,hisilicon/hip08/cpu,core
 0x00000000500f0000,v1,ampere/emag,core
-- 
2.17.1

