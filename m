Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408447EFAD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404528AbfHBI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 04:57:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728157AbfHBI5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:57:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C339E4D9BF8F1180A1DC;
        Fri,  2 Aug 2019 16:57:29 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 16:57:20 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jeremy.linton@arm.com>, <linux-perf-users@vger.kernel.org>
Subject: [RFC PATCH 3/3] perf report: add --spe options for arm-spe
Date:   Fri, 2 Aug 2019 17:40:13 +0800
Message-ID: <1564738813-10944-4-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss). This patch adds their help
instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/Documentation/perf-report.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 987261d..d998d4b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -445,6 +445,15 @@ include::itrace.txt[]
 
 	To disable decoding entirely, use --no-itrace.
 
+--spe::
+	Options for decoding arm-spe tracing data. The options are:
+
+		l	synthesize llc miss events
+		t	synthesize tlb miss events
+		b	synthesize branch miss events
+
+	The default is all events i.e. the same as --spe=ltb
+
 --full-source-path::
 	Show the full path for source files for srcline output.
 
-- 
2.7.4

