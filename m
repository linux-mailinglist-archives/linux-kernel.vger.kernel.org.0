Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FF139839
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 19:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgAMSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 13:00:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:10778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgAMSAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:00:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 10:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="304903949"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2020 10:00:17 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     yu.chen.surf@gmail.com, andy@infradead.org, dvhart@infradead.org,
        andy@kernel.org, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/2] MAINTAINERS: Update for the intel uncore frequency control
Date:   Mon, 13 Jan 2020 10:00:15 -0800
Message-Id: <20200113180015.503314-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113180015.503314-1-srinivas.pandruvada@linux.intel.com>
References: <20200113180015.503314-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for drivers/platform/x86/intel-uncore-frequency.c.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4017e6b760be..dbdadb369082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8562,6 +8562,12 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
 F:	drivers/platform/x86/intel_telemetry*
 
+INTEL UNCORE FREQUENCY CONTROL
+M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel-uncore-frequency.c
+
 INTEL VIRTUAL BUTTON DRIVER
 M:	AceLan Kao <acelan.kao@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.24.1

