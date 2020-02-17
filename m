Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4201612E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgBQNPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:30905 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgBQNPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 05:15:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="282522783"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2020 05:14:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7A4108B4; Mon, 17 Feb 2020 15:14:47 +0200 (EET)
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
Subject: [PATCH v6 19/19] MAINTAINERS: Update entry for Intel Broxton PMC driver
Date:   Mon, 17 Feb 2020 16:14:46 +0300
Message-Id: <20200217131446.32818-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver lives now under MFD so split the current entry into two parts
and add me as co-maintainer of the Intel Broxton PMC driver. While there
correct formatting of Zha Qipeng's email address.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d4e3241bf99..20e4353260f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8371,6 +8371,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_atomisp2_pm.c
 
+INTEL BROXTON PMC DRIVER
+M:	Mika Westerberg <mika.westerberg@linux.intel.com>
+M:	Zha Qipeng <qipeng.zha@intel.com>
+S:	Maintained
+F:	drivers/mfd/intel_pmc_bxt.c
+F:	include/linux/mfd/intel_pmc_bxt.h
+
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
 M:	Artur Paszkiewicz <artur.paszkiewicz@intel.com>
@@ -8579,6 +8586,13 @@ F:	drivers/dma/mic_x100_dma.c
 F:	drivers/dma/mic_x100_dma.h
 F:	Documentation/mic/
 
+INTEL P-Unit IPC DRIVER
+M:	Zha Qipeng <qipeng.zha@intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	arch/x86/include/asm/intel_punit_ipc.h
+F:	drivers/platform/x86/intel_punit_ipc.c
+
 INTEL PMC CORE DRIVER
 M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
 M:	Vishwanath Somayaji <vishwanath.somayaji@intel.com>
@@ -8586,15 +8600,6 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel_pmc_core*
 
-INTEL PMC/P-Unit IPC DRIVER
-M:	Zha Qipeng<qipeng.zha@intel.com>
-L:	platform-driver-x86@vger.kernel.org
-S:	Maintained
-F:	arch/x86/include/asm/intel_pmc_ipc.h
-F:	arch/x86/include/asm/intel_punit_ipc.h
-F:	drivers/platform/x86/intel_pmc_ipc.c
-F:	drivers/platform/x86/intel_punit_ipc.c
-
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
-- 
2.25.0

