Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D902417B1D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCEWrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:47:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCEWps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674610"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:47 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 06/27] tools/power/x86/intel-speed-select: Max CPU count calculation when CPU0 is offline
Date:   Thu,  5 Mar 2020 14:45:17 -0800
Message-Id: <20200305224538.490864-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently /sys/devices/system/cpu/cpu0/topology/thread_siblings is used to
get the max CPU count. But when CPU0 is offline, then this file will be
absent.

So add processing so that we can get count from any first CPU in the
system. which is online.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../power/x86/intel-speed-select/isst-config.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index b8f4846d7c78..c773c6cc02a5 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -316,10 +316,24 @@ static void set_max_cpu_num(void)
 {
 	FILE *filep;
 	unsigned long dummy;
+	int i;
 
 	topo_max_cpus = 0;
-	filep = fopen_or_exit(
-		"/sys/devices/system/cpu/cpu0/topology/thread_siblings", "r");
+	for (i = 0; i < 256; ++i) {
+		char path[256];
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/topology/thread_siblings", i);
+		filep = fopen(path, "r");
+		if (filep)
+			break;
+	}
+
+	if (!filep) {
+		fprintf(stderr, "Can't get max cpu number\n");
+		exit(0);
+	}
+
 	while (fscanf(filep, "%lx,", &dummy) == 1)
 		topo_max_cpus += BITMASK_SIZE;
 	fclose(filep);
-- 
2.24.1

