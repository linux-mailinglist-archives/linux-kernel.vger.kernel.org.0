Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDEAB2CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfINTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 15:45:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:27816 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730448AbfINTpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:45:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2019 12:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,506,1559545200"; 
   d="scan'208";a="201286934"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.128.136])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2019 12:45:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy.shevchenko@gmail.com, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com, darcari@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/5] tools/power/x86/intel-speed-select: Fix some debug prints
Date:   Sat, 14 Sep 2019 12:45:46 -0700
Message-Id: <20190914194547.24271-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
References: <20190914194547.24271-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrong debug print for cpu, which is displayed as CLOS. Also
avoid printing clos id, when user is specify clos as parameter.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index c2892d86be36..889396d676cb 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -508,7 +508,7 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 		int write = 0;
 		int clos_id, core_id, ret = 0;
 
-		debug_printf("CLOS %d\n", cpu);
+		debug_printf("CPU %d\n", cpu);
 
 		if (parameter & BIT(MBOX_CMD_WRITE_BIT)) {
 			value = req_data;
@@ -1421,7 +1421,6 @@ static void parse_cmd_args(int argc, int start, char **argv)
 		/* CLOS related */
 		case 'c':
 			current_clos = atoi(optarg);
-			printf("clos %d\n", current_clos);
 			break;
 		case 'd':
 			clos_desired = atoi(optarg);
-- 
2.17.2

