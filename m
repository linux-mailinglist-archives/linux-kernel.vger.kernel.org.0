Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0995E142F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgATQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:08:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:61699 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgATQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:08:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="221477735"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2020 08:08:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DA6E978; Mon, 20 Jan 2020 18:08:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/9] x86/platform: Rename x86/apple.h -> x86/machine.h
Date:   Mon, 20 Jan 2020 18:07:53 +0200
Message-Id: <20200120160801.53089-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename linux/platform_data/x86/apple.h to linux/platform_data/x86/machine.h
in order to add new quirks later on. For sake of being less intrusive,
leave former file that includes a latter one.

While here, add include to linux/types.h due to bool type in use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/x86/apple.h   | 14 +-------------
 include/linux/platform_data/x86/machine.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/platform_data/x86/machine.h

diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3c21..1fd0af6ffea9 100644
--- a/include/linux/platform_data/x86/apple.h
+++ b/include/linux/platform_data/x86/apple.h
@@ -1,13 +1 @@
-#ifndef PLATFORM_DATA_X86_APPLE_H
-#define PLATFORM_DATA_X86_APPLE_H
-
-#ifdef CONFIG_X86
-/**
- * x86_apple_machine - whether the machine is an x86 Apple Macintosh
- */
-extern bool x86_apple_machine;
-#else
-#define x86_apple_machine false
-#endif
-
-#endif
+#include <linux/platform_data/x86/machine.h>
diff --git a/include/linux/platform_data/x86/machine.h b/include/linux/platform_data/x86/machine.h
new file mode 100644
index 000000000000..b1e7a560a046
--- /dev/null
+++ b/include/linux/platform_data/x86/machine.h
@@ -0,0 +1,15 @@
+#ifndef PLATFORM_DATA_X86_MACHINE_H
+#define PLATFORM_DATA_X86_MACHINE_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_X86
+/**
+ * x86_apple_machine - whether the machine is an x86 Apple Macintosh
+ */
+extern bool x86_apple_machine;
+#else
+#define x86_apple_machine			false
+#endif
+
+#endif	/* PLATFORM_DATA_X86_MACHINE_H */
-- 
2.24.1

