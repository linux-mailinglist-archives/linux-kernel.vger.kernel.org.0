Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF195E452A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407557AbfJYIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 04:04:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405453AbfJYIEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:04:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E26BB92D;
        Fri, 25 Oct 2019 08:04:05 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] xen: issue deprecation warning for 32-bit pv guest
Date:   Fri, 25 Oct 2019 09:38:58 +0200
Message-Id: <20191025073858.15081-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the kernel as Xen 32-bit PV guest will soon be removed.
Issue a warning when booted as such.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 58f79ab32358..5bfea374a160 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -117,6 +117,14 @@ static void __init xen_banner(void)
 	printk(KERN_INFO "Xen version: %d.%d%s%s\n",
 	       version >> 16, version & 0xffff, extra.extraversion,
 	       xen_feature(XENFEAT_mmu_pt_update_preserve_ad) ? " (preserve-AD)" : "");
+
+#ifdef CONFIG_X86_32
+	pr_warn("WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!\n"
+		"Support for running as 32-bit PV-guest under Xen will soon be removed\n"
+		"from the Linux kernel!\n"
+		"Please use either a 64-bit kernel or switch to HVM or PVH mode!\n"
+		"WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!\n");
+#endif
 }
 
 static void __init xen_pv_init_platform(void)
-- 
2.16.4

