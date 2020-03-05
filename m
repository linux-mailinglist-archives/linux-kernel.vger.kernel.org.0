Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBD17B1C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCEWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:46:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:5035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgCEWpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674656"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:53 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 21/27] tools/power/x86/intel-speed-select: Show error for invalid CPUs in the options
Date:   Thu,  5 Mar 2020 14:45:32 -0800
Message-Id: <20200305224538.490864-22-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When --cpu or -c is used to specify target CPUs and non of them are valid,
display error.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 7a8a315ac8d1..386791aaeca1 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -425,7 +425,7 @@ static void for_each_online_target_cpu_in_set(
 	void (*callback)(int, void *, void *, void *, void *), void *arg1,
 	void *arg2, void *arg3, void *arg4)
 {
-	int i;
+	int i, found = 0;
 
 	for (i = 0; i < topo_max_cpus; ++i) {
 		int online;
@@ -439,9 +439,14 @@ static void for_each_online_target_cpu_in_set(
 			online =
 				1; /* online entry for CPU 0 needs some special configs */
 
-		if (online && callback)
+		if (online && callback) {
 			callback(i, arg1, arg2, arg3, arg4);
+			found = 1;
+		}
 	}
+
+	if (!found)
+		fprintf(stderr, "No valid CPU in the list\n");
 }
 
 #define BITMASK_SIZE 32
-- 
2.24.1

