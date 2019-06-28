Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0F58FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 03:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1Bd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 21:33:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:41605 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfF1Bdx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:33:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 18:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,425,1557212400"; 
   d="scan'208";a="189283653"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2019 18:33:51 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 7/7] perf diff: Documentation -c cycles option
Date:   Fri, 28 Jun 2019 17:23:04 +0800
Message-Id: <1561713784-30533-8-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation the new computation selection 'cycles'.

 v4:
 ---
 Change the column 'Block cycles diff [start:end]' to
 '[Program Block Range] Cycles Diff'

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index facd91e..d5cc15e 100644
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
-- 
2.7.4

