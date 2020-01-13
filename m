Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3A1392C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAMN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:57:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:48397 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgAMN4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:56:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 05:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="224903910"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2020 05:56:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E76DB795; Mon, 13 Jan 2020 15:56:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/36] platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
Date:   Mon, 13 Jan 2020 16:56:08 +0300
Message-Id: <20200113135623.56286-22-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used anywhere so drop them completely.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h | 12 ------
 drivers/platform/x86/intel_pmc_ipc.c | 59 ----------------------------
 2 files changed, 71 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 966ff2171ff9..e6da1ce26256 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -34,9 +34,7 @@
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen);
 int intel_pmc_s0ix_counter_read(u64 *data);
-int intel_pmc_gcr_read(u32 offset, u32 *data);
 int intel_pmc_gcr_read64(u32 offset, u64 *data);
-int intel_pmc_gcr_write(u32 offset, u32 data);
 
 #else
 
@@ -51,21 +49,11 @@ static inline int intel_pmc_s0ix_counter_read(u64 *data)
 	return -EINVAL;
 }
 
-static inline int intel_pmc_gcr_read(u32 offset, u32 *data)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_gcr_read64(u32 offset, u64 *data)
 {
 	return -EINVAL;
 }
 
-static inline int intel_pmc_gcr_write(u32 offset, u32 data)
-{
-	return -EINVAL;
-}
-
 #endif /*CONFIG_INTEL_PMC_IPC*/
 
 #endif
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 83f47df1c4a5..677ed470e14e 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -210,35 +210,6 @@ static inline int is_gcr_valid(u32 offset)
 	return 0;
 }
 
-/**
- * intel_pmc_gcr_read() - Read a 32-bit PMC GCR register
- * @offset:	offset of GCR register from GCR address base
- * @data:	data pointer for storing the register output
- *
- * Reads the 32-bit PMC GCR register at given offset.
- *
- * Return:	negative value on error or 0 on success.
- */
-int intel_pmc_gcr_read(u32 offset, u32 *data)
-{
-	int ret;
-
-	spin_lock(&ipcdev.gcr_lock);
-
-	ret = is_gcr_valid(offset);
-	if (ret < 0) {
-		spin_unlock(&ipcdev.gcr_lock);
-		return ret;
-	}
-
-	*data = readl(ipcdev.gcr_mem_base + offset);
-
-	spin_unlock(&ipcdev.gcr_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_gcr_read);
-
 /**
  * intel_pmc_gcr_read64() - Read a 64-bit PMC GCR register
  * @offset:	offset of GCR register from GCR address base
@@ -268,36 +239,6 @@ int intel_pmc_gcr_read64(u32 offset, u64 *data)
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_read64);
 
-/**
- * intel_pmc_gcr_write() - Write PMC GCR register
- * @offset:	offset of GCR register from GCR address base
- * @data:	register update value
- *
- * Writes the PMC GCR register of given offset with given
- * value.
- *
- * Return:	negative value on error or 0 on success.
- */
-int intel_pmc_gcr_write(u32 offset, u32 data)
-{
-	int ret;
-
-	spin_lock(&ipcdev.gcr_lock);
-
-	ret = is_gcr_valid(offset);
-	if (ret < 0) {
-		spin_unlock(&ipcdev.gcr_lock);
-		return ret;
-	}
-
-	writel(data, ipcdev.gcr_mem_base + offset);
-
-	spin_unlock(&ipcdev.gcr_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_gcr_write);
-
 /**
  * intel_pmc_gcr_update() - Update PMC GCR register bits
  * @offset:	offset of GCR register from GCR address base
-- 
2.24.1

