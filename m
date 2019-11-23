Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509E1107DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKWJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 04:24:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfKWJYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 04:24:38 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 61DD3EA833AE4F9BAA7C;
        Sat, 23 Nov 2019 17:24:35 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 17:24:26 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC v3 1/5] perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
Date:   Sat, 23 Nov 2019 18:11:14 +0800
Message-ID: <20191123101118.12635-2-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123101118.12635-1-tanxiaojun@huawei.com>
References: <20191123101118.12635-1-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new arm-spe-decoder directory for subsequent extensions and
move arm-spe-pkt-decoder.h/c to this directory. No code changes.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/util/Build                                       | 2 +-
 tools/perf/util/arm-spe-decoder/Build                       | 1 +
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c | 0
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h | 0
 tools/perf/util/arm-spe.c                                   | 2 +-
 5 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (100%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dcfca1a882f..f2e5a217e0aa 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -100,7 +100,7 @@ perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-$(CONFIG_AUXTRACE) += arm-spe.o
-perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
new file mode 100644
index 000000000000..16efbc245028
--- /dev/null
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -0,0 +1 @@
+perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.c
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
diff --git a/tools/perf/util/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.h
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 53be12b23ff4..f3382a38d48e 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -23,7 +23,7 @@
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
-#include "arm-spe-pkt-decoder.h"
+#include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
 struct arm_spe {
 	struct auxtrace			auxtrace;
-- 
2.17.1

