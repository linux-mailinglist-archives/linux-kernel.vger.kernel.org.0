Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE18A15917D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 15:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgBKOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 09:05:15 -0500
Received: from foss.arm.com ([217.140.110.172]:46742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgBKOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:05:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C41BFEC;
        Tue, 11 Feb 2020 06:05:07 -0800 (PST)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.36.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B1D33F68F;
        Tue, 11 Feb 2020 06:05:04 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v4 3/4] perf report: Add SPE options to --itrace argument
Date:   Tue, 11 Feb 2020 14:04:44 +0000
Message-Id: <20200211140445.21986-4-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211140445.21986-1-james.clark@arm.com>
References: <20200210122509.GA2005279@krava>
 <20200211140445.21986-1-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

The previous patch added support in "perf report" for some arm-spe
events(llc-miss, tlb-miss, branch-miss, remote_access). This patch
adds their help instructions.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/itrace.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index 82ff7dad40c2..8e1488de1fb3 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,5 +1,5 @@
 		i	synthesize instructions events
-		b	synthesize branches events
+		b	synthesize branches events (branch misses on Arm)
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
 		x	synthesize transactions events
@@ -12,6 +12,9 @@
 		g	synthesize a call chain (use with i or x)
 		l	synthesize last branch entries (use with i or x)
 		s       skip initial number of events
+		m	synthesize LLC miss events
+		t	synthesize TLB miss events
+		a	synthesize remote access events
 
 	The default is all events i.e. the same as --itrace=ibxwpe,
 	except for perf script where it is --itrace=ce
-- 
2.17.1

