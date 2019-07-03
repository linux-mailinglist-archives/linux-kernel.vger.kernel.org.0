Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02C5E6FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGCOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:41:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60035 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGCOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:41:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EeJBY3329263
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:40:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EeJBY3329263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164820;
        bh=UEdOFydQGy8OSSloP0N3Ai6LSB0S5b2jw8pBRqi/bQs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HNkfUXk/q3IN4QrelD93pj4vWygqePaxQvz1n5SigBnhFYF7LPuZ95OYXRpZpSZvc
         lu21d89i8K7B9MYQt61sHyuaIoYVnW7KDxboFSG2+B8t70kfIpZlTEdA5OSYLKFy1T
         bJ9BsXw9iYgsBAEtPUSkXyYH2qW7w2YwYZ0VgXE9Sg7Fr6Sxarh4SZdewj5Sx3hy54
         Bwj8CwN0PGra/mCmv9TWgzyLKUwiAUI7F3hzrqtJ8v1jJeB60u+ELlRN8qLZpj4iV2
         hf/GLS2dKo5Ok6+GxyLOPn57AJuBN1/pANs6E0udL+5ay2zOxmNaA0JborFpcNt/Tv
         VSFwbwyUAYf9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EeIwk3329260;
        Wed, 3 Jul 2019 07:40:18 -0700
Date:   Wed, 3 Jul 2019 07:40:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-edd93a4076cf18ede423c167de6d6fb8e4211e7b@git.kernel.org>
Cc:     hpa@zytor.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, namhyung@kernel.org, kan.liang@linux.intel.com,
        john.garry@huawei.com, brueckner@linux.ibm.com,
        mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        peterz@infradead.org, ben@decadent.org.uk, ak@linux.intel.com,
        jolsa@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, mathieu.poirier@linaro.org,
        will.deacon@arm.com, acme@redhat.com
Reply-To: ben@decadent.org.uk, ak@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, mathieu.poirier@linaro.org,
          tmricht@linux.ibm.com, will.deacon@arm.com, acme@redhat.com,
          hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
          zhangshaokun@hisilicon.com, mark.rutland@arm.com,
          brueckner@linux.ibm.com, john.garry@huawei.com
In-Reply-To: <1561732552-143038-5-git-send-email-john.garry@huawei.com>
References: <1561732552-143038-5-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jevents: Add support for Hisi hip08 L3C PMU
 aliasing
Git-Commit-ID: edd93a4076cf18ede423c167de6d6fb8e4211e7b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  edd93a4076cf18ede423c167de6d6fb8e4211e7b
Gitweb:     https://git.kernel.org/tip/edd93a4076cf18ede423c167de6d6fb8e4211e7b
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Fri, 28 Jun 2019 22:35:52 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:16 -0300

perf jevents: Add support for Hisi hip08 L3C PMU aliasing

Add support for Hisi hip08 L3C PMU aliasing.

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1561732552-143038-5-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     | 37 ++++++++++++++++++++++
 tools/perf/pmu-events/jevents.c                    |  1 +
 2 files changed, 38 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
new file mode 100644
index 000000000000..ca48747642e1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
@@ -0,0 +1,37 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_l3c.rd_cpipe",
+	    "BriefDescription": "Total read accesses",
+	    "PublicDescription": "Total read accesses",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_l3c.wr_cpipe",
+	    "BriefDescription": "Total write accesses",
+	    "PublicDescription": "Total write accesses",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
+	    "BriefDescription": "Total read hits",
+	    "PublicDescription": "Total read hits",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_l3c.wr_hit_cpipe",
+	    "BriefDescription": "Total write hits",
+	    "PublicDescription": "Total write hits",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x04",
+	    "EventName": "uncore_hisi_l3c.victim_num",
+	    "BriefDescription": "l3c precharge commands",
+	    "PublicDescription": "l3c precharge commands",
+	    "Unit": "hisi_sccl,l3c",
+   },
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 3c95affd85a4..287a6f10ca48 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -238,6 +238,7 @@ static struct map {
 	{ "UPI LL", "uncore_upi" },
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
+	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
 	{}
 };
 
