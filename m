Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1D1817DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 13:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgCKMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 08:21:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:31410 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgCKMV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:21:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 05:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,540,1574150400"; 
   d="scan'208";a="234694368"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2020 05:21:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf intel-pt: Update intel-pt.txt file with new location of the documentation
Date:   Wed, 11 Mar 2020 14:20:34 +0200
Message-Id: <20200311122034.3697-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311122034.3697-1-adrian.hunter@intel.com>
References: <20200311122034.3697-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easy for people looking in intel-pt.txt to find the new file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/intel-pt.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/perf/Documentation/intel-pt.txt

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
new file mode 100644
index 000000000000..fd9241a1b987
--- /dev/null
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -0,0 +1 @@
+Documentation for support for Intel Processor Trace within perf tools' has moved to file perf-intel-pt.txt
-- 
2.17.1

