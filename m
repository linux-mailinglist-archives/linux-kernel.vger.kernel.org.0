Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5869B5E6E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGCOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:37:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:37:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EbGOE3328604
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:37:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EbGOE3328604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164637;
        bh=0TglNZ76Idl1FaNDZVMBLCeud0yjzx5WinfO7wQJE8w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uvd8aHcf0qbemm5f7fUzTq6mVu2WpQxGgKARKOWpUNAsMpiHK/N/F8xfMHxijzhXy
         hMkVkL+h8DdBwBOP+ct//xsrxkhh2uJb15eLWolHP1LAHLVmARszL9+PxgZnT9IgH2
         WVgZd7DpN6urxA5LwrrdQYhsFANcdsu0I2kC3cawUGhosKWChyz3qfYsPZUBMQlbR0
         OTTw27LlqVx5QCqrSAaPj/PN7PjzVIAmTfYp3/KknE1DmiM+yuC1KlLNxKw5nfAlcl
         Hjji72ZxNBO6yehzaqMF5n1YX4MVmbgjcCS17we5HHL6NtcoGHk3sXJI2A8uBNrKeo
         IiyTV1wgGQrLg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EbGPN3328601;
        Wed, 3 Jul 2019 07:37:16 -0700
Date:   Wed, 3 Jul 2019 07:37:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-c8f7bc1a080b081a178bff20356cb7575d385f84@git.kernel.org>
Cc:     tglx@linutronix.de, kan.liang@linux.intel.com,
        peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        yao.jin@linux.intel.com, acme@redhat.com, yao.jin@intel.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, hpa@zytor.com, yao.jin@intel.com,
          acme@redhat.com, yao.jin@linux.intel.com, ak@linux.intel.com
In-Reply-To: <1561713784-30533-8-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-8-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf diff: Documentation -c cycles option
Git-Commit-ID: c8f7bc1a080b081a178bff20356cb7575d385f84
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

Commit-ID:  c8f7bc1a080b081a178bff20356cb7575d385f84
Gitweb:     https://git.kernel.org/tip/c8f7bc1a080b081a178bff20356cb7575d385f84
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 17:23:04 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 13:20:51 -0300

perf diff: Documentation -c cycles option

Documentation the new computation selection 'cycles'.

 v4:
 ---
 Change the column 'Block cycles diff [start:end]' to
 '[Program Block Range] Cycles Diff'

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1561713784-30533-8-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index facd91e4e945..d5cc15e651cf 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -90,9 +90,10 @@ OPTIONS
 
 -c::
 --compute::
-        Differential computation selection - delta, ratio, wdiff, delta-abs
-        (default is delta-abs).  Default can be changed using diff.compute
-        config option.  See COMPARISON METHODS section for more info.
+        Differential computation selection - delta, ratio, wdiff, cycles,
+        delta-abs (default is delta-abs).  Default can be changed using
+        diff.compute config option.  See COMPARISON METHODS section for
+        more info.
 
 -p::
 --period::
@@ -280,6 +281,16 @@ If specified the 'Weighted diff' column is displayed with value 'd' computed as:
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
 
+cycles
+~~~~~~
+If specified the '[Program Block Range] Cycles Diff' column is displayed.
+It displays the cycles difference of same program basic block amongst
+two perf.data. The program basic block is the code between two branches.
+
+'[Program Block Range]' indicates the range of a program basic block.
+Source line is reported if it can be found otherwise uses symbol+offset
+instead.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
