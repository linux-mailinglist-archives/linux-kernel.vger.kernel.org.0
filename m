Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF9107DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 10:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKWJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 04:24:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfKWJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 04:24:45 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 585B888D9EFF8A87D87C;
        Sat, 23 Nov 2019 17:24:35 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 17:24:28 +0800
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
Subject: [RFC v3 3/5] perf report: Add --spe options for arm-spe
Date:   Sat, 23 Nov 2019 18:11:16 +0800
Message-ID: <20191123101118.12635-4-tanxiaojun@huawei.com>
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

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss, remote_access). This patch adds their help
instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/Documentation/perf-report.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7315f155803f..188a9477558b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -462,6 +462,16 @@ include::itrace.txt[]
 
 	To disable decoding entirely, use --no-itrace.
 
+--spe::
+	Options for decoding arm-spe tracing data. The options are:
+
+		l	synthesize llc miss events
+		t	synthesize tlb miss events
+		b	synthesize branch miss events
+		r	synthesize remote access events
+
+	The default is all events i.e. the same as --spe=ltbr
+
 --full-source-path::
 	Show the full path for source files for srcline output.
 
-- 
2.17.1

