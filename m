Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E047997
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 07:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfFQFBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 01:01:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:51879 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfFQFBg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 01:01:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 22:01:36 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2019 22:01:35 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 7/7] perf diff: Documentation -c cycles option
Date:   Mon, 17 Jun 2019 20:50:57 +0800
Message-Id: <1560775857-22355-8-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560775857-22355-1-git-send-email-yao.jin@linux.intel.com>
References: <1560775857-22355-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation the new computation selection 'cycles'.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index facd91e..73903d2 100644
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
@@ -280,6 +281,13 @@ If specified the 'Weighted diff' column is displayed with value 'd' computed as:
     - WEIGHT-A being the weight of the data file
     - WEIGHT-B being the weight of the baseline data file
 
+cycles
+~~~~~~
+If specified the 'Block cycles diff [start:end]' column is displayed.
+It displays the cycles difference of same program basic block amongst
+two perf.data. The program basic block is the code block between
+two branches in a function (indicated by [start:end]).
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
-- 
2.7.4

