Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07EF142F45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgATQIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:08:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:23180 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgATQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:08:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 08:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="215269721"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2020 08:08:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 146333CF; Mon, 20 Jan 2020 18:08:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/9] x86/quirks: Convert DMI matching to use a table
Date:   Mon, 20 Jan 2020 18:07:57 +0200
Message-Id: <20200120160801.53089-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to extend the DMI based quirks, convert them to a table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 6c122f35508a..78846a8dc88b 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -658,8 +658,37 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
 bool x86_apple_machine;
 EXPORT_SYMBOL(x86_apple_machine);
 
+static const struct dmi_system_id x86_machine_table[] __initconst = {
+	{
+		.ident = "x86 Apple Macintosh",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		},
+		.driver_data = &x86_apple_machine,
+	},
+	{
+		.ident = "x86 Apple Macintosh",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		},
+		.driver_data = &x86_apple_machine,
+	},
+	{}
+};
+
+static void __init early_platfrom_detect_quirk(void)
+{
+	const struct dmi_system_id *id;
+
+	id = dmi_first_match(x86_machine_table);
+	if (!id)
+		return;
+
+	printk(KERN_DEBUG "Detected %s platform\n", id->ident);
+	*((bool *)id->driver_data) = true;
+}
+
 void __init early_platform_quirks(void)
 {
-	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
-			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
+	early_platfrom_detect_quirk();
 }
-- 
2.24.1

