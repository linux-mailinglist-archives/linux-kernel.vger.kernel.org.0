Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA59129718
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 15:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfLWOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 09:18:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:47078 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfLWOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="417276265"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Dec 2019 06:17:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1179EC3A; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/37] platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
Date:   Mon, 23 Dec 2019 17:16:58 +0300
Message-Id: <20191223141716.13727-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not called outside of intel_pmc_ipc.c so we can make it
static instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h | 6 ------
 drivers/platform/x86/intel_pmc_ipc.c | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 3b2e8b461520..b4f804877651 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -31,7 +31,6 @@
 
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
-int intel_pmc_ipc_simple_command(int cmd, int sub);
 int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen, u32 dptr, u32 sptr);
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
@@ -43,11 +42,6 @@ int intel_pmc_gcr_write(u32 offset, u32 data);
 
 #else
 
-static inline int intel_pmc_ipc_simple_command(int cmd, int sub)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen, u32 dptr, u32 sptr)
 {
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 9229c7a16536..53551f5474a7 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -404,7 +404,7 @@ static int intel_pmc_ipc_check_status(void)
  *
  * Return:	an IPC error code or 0 on success.
  */
-int intel_pmc_ipc_simple_command(int cmd, int sub)
+static int intel_pmc_ipc_simple_command(int cmd, int sub)
 {
 	int ret;
 
@@ -419,7 +419,6 @@ int intel_pmc_ipc_simple_command(int cmd, int sub)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_simple_command);
 
 /**
  * intel_pmc_ipc_raw_cmd() - IPC command with data and pointers
-- 
2.24.0

