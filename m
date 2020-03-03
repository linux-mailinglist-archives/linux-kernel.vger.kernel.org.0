Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576E01785EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 23:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgCCWuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 17:50:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:13236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgCCWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:50:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 14:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="319622088"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.184.249])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2020 14:50:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] tools/power/x86/intel-speed-select: Fix last cpu number
Date:   Tue,  3 Mar 2020 14:50:44 -0800
Message-Id: <20200303225044.362525-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303225044.362525-1-srinivas.pandruvada@linux.intel.com>
References: <20200303225044.362525-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here topology_max_cpus is used for total CPU count, not the last CPU
number. So remove "-1".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 50db0cd23d8c..c922cfd7ba50 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -313,7 +313,6 @@ static void set_max_cpu_num(void)
 	while (fscanf(filep, "%lx,", &dummy) == 1)
 		topo_max_cpus += BITMASK_SIZE;
 	fclose(filep);
-	topo_max_cpus--; /* 0 based */
 
 	debug_printf("max cpus %d\n", topo_max_cpus);
 }
-- 
2.24.1

