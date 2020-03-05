Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA04617B1A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 23:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCEWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 17:45:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgCEWpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674606"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 05/27] tools/power/x86/intel-speed-select: Special handling for CPU 0 online/offline
Date:   Thu,  5 Mar 2020 14:45:16 -0800
Message-Id: <20200305224538.490864-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "-o" option for force online/offline is used with command:
perf-profile set-config-level

If the config level calls for CPU 0 online/offline, then call fails
as there is special kernel setup required for CPU 0 online/offline
and the currently not setup for that.

But when call is for online CPU 0, then don't fail. Just warn that
this system is not setup for CPU 0 online/offline.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 405b03cba248..b8f4846d7c78 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -220,8 +220,14 @@ static void set_cpu_online_offline(int cpu, int state)
 		 "/sys/devices/system/cpu/cpu%d/online", cpu);
 
 	fd = open(buffer, O_WRONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		if (!cpu && state) {
+			fprintf(stderr, "This system is not configured for CPU 0 online/offline\n");
+			fprintf(stderr, "Ignoring online request for CPU 0 as this is already online\n");
+			return;
+		}
 		err(-1, "%s open failed", buffer);
+	}
 
 	if (state)
 		ret = write(fd, "1\n", 2);
-- 
2.24.1

