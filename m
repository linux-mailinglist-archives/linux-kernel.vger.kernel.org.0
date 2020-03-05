Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5B17B1BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCEWqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:46:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:5039 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgCEWp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674670"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:55 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 25/27] tools/power/x86/intel-speed-select: Add display for enabled cpus count
Date:   Thu,  5 Mar 2020 14:45:36 -0800
Message-Id: <20200305224538.490864-26-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to total CPU count also display "enabled-cpu-count" for
perf-profile info command. This will show number of CPUs in the
"enable-cpu-mask".

For example:

 perf-profile-level-4
        cpu-count:32
        enable-cpu-count:16
        enable-cpu-mask:e42d0000,e42d0000

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index ed51d8b79c41..4f4c42147a90 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -354,6 +354,14 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 		snprintf(value, sizeof(value), "%d", j);
 		format_and_print(outf, base_level + 4, header, value);
 
+		j = CPU_COUNT_S(ctdp_level->core_cpumask_size,
+				ctdp_level->core_cpumask);
+		if (j) {
+			snprintf(header, sizeof(header), "enable-cpu-count");
+			snprintf(value, sizeof(value), "%d", j);
+			format_and_print(outf, base_level + 4, header, value);
+		}
+
 		if (ctdp_level->core_cpumask_size) {
 			snprintf(header, sizeof(header), "enable-cpu-mask");
 			printcpumask(sizeof(value), value,
-- 
2.24.1

