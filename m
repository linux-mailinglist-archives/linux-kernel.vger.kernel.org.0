Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64BB177764
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 14:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgCCNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 08:37:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:26134 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgCCNhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:37:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 05:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="263198908"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2020 05:36:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1541644F; Tue,  3 Mar 2020 15:36:50 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 15/19] x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
Date:   Tue,  3 Mar 2020 16:36:45 +0300
Message-Id: <20200303133649.39819-16-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to call the functions even when CONFIG_X86_INTEL_MID is not
enabled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 8e5af119dc2d..de58391bdee0 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -88,11 +88,17 @@ static inline bool intel_mid_has_msic(void)
 	return (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_PENWELL);
 }
 
+extern void intel_scu_devices_create(void);
+extern void intel_scu_devices_destroy(void);
+
 #else /* !CONFIG_X86_INTEL_MID */
 
 #define intel_mid_identify_cpu()	0
 #define intel_mid_has_msic()		0
 
+static inline void intel_scu_devices_create(void) { }
+static inline void intel_scu_devices_destroy(void) { }
+
 #endif /* !CONFIG_X86_INTEL_MID */
 
 enum intel_mid_timer_options {
@@ -115,9 +121,6 @@ extern enum intel_mid_timer_options intel_mid_timer_options;
 #define SFI_MTMR_MAX_NUM		8
 #define SFI_MRTC_MAX			8
 
-extern void intel_scu_devices_create(void);
-extern void intel_scu_devices_destroy(void);
-
 /* VRTC timer */
 #define MRST_VRTC_MAP_SZ		1024
 /* #define MRST_VRTC_PGOFFSET		0xc00 */
-- 
2.25.1

