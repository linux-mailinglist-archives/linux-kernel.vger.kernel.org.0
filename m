Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246E47C43D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfGaN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:58:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:47382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfGaN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:58:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 06:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="177318832"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2019 06:58:53 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 7/7] perf intel-pt: Add brief documentation for PEBS via Intel PT
Date:   Wed, 31 Jul 2019 16:58:29 +0300
Message-Id: <20190731135829.54435-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
References: <20190731135829.54435-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Document how to select PEBS via Intel PT and how to display synthesized
PEBS samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 50c5b60101bd..8c40f898685b 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
 
 Note there is currently no advantage to using Intel PT instead of LBR, but
 that may change in the future if greater use is made of the data.
+
+
+PEBS via Intel PT
+=================
+
+Some hardware has the feature to redirect PEBS records to the Intel PT trace.
+Recording is selected by using the aux-source config term e.g.
+
+	perf record  -c 10000 -e cycles/aux-source/ppp -e intel_pt/branch=0/ uname
+
+Note that currently, software only supports redirecting at most one PEBS event.
+
+To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
+
+	perf script --itrace=oe
-- 
2.20.1

