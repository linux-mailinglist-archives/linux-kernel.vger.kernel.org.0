Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447B7EDD3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 12:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfKDLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 06:03:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:13209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbfKDLDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:03:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 03:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="232021228"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga002.fm.intel.com with ESMTP; 04 Nov 2019 03:03:09 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 05/10] tools/power/x86/intel-speed-select: Use mailbox for CLOS_PM_QOS_CONFIG
Date:   Mon,  4 Nov 2019 03:02:41 -0800
Message-Id: <20191104110246.70465-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
References: <20191104110246.70465-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mailbox to read/write CLOS_PM_QOS_CONFIG instead of read/write to
MMIO offset.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index c563ecaf44e1..2a3650f025b9 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -574,12 +574,6 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 			if (!ret && !write)
 				*resp = value;
 			break;
-		case CLOS_PM_QOS_CONFIG:
-			ret = isst_send_mmio_command(cpu, PM_QOS_CONFIG_OFFSET,
-						     write, &value);
-			if (!ret && !write)
-				*resp = value;
-			break;
 		case CLOS_STATUS:
 			break;
 		default:
-- 
2.17.2

