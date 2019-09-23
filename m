Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF6BAEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405508AbfIWHyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 03:54:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404826AbfIWHyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:54:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FB45B150;
        Mon, 23 Sep 2019 07:54:12 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 rebased] powerpc/fadump: when fadump is supported register the fadump sysfs files.
Date:   Mon, 23 Sep 2019 09:54:06 +0200
Message-Id: <20190923075406.5854-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently it is not possible to distinguish the case when fadump is
supported by firmware and disabled in kernel and completely unsupported
using the kernel sysfs interface. User can investigate the devicetree
but it is more reasonable to provide sysfs files in case we get some
fadumpv2 in the future.

With this patch sysfs files are available whenever fadump is supported
by firmware.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
v2: move the sysfs initialization earlier to avoid condition nesting
rebase: on top of the powernv fadump support
---
 arch/powerpc/kernel/fadump.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ed59855430b9..cdcdea6c6453 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1466,16 +1466,20 @@ static void fadump_init_files(void)
  */
 int __init setup_fadump(void)
 {
-	if (!fw_dump.fadump_enabled)
-		return 0;
-
-	if (!fw_dump.fadump_supported) {
+	if (!fw_dump.fadump_supported && fw_dump.fadump_enabled) {
 		printk(KERN_ERR "Firmware-assisted dump is not supported on"
 			" this hardware\n");
-		return 0;
 	}
 
+	if (!fw_dump.fadump_supported)
+		return 0;
+
+	fadump_init_files();
 	fadump_show_config();
+
+	if (!fw_dump.fadump_enabled)
+		return 1;
+
 	/*
 	 * If dump data is available then see if it is valid and prepare for
 	 * saving it to the disk.
@@ -1492,8 +1496,6 @@ int __init setup_fadump(void)
 	else if (fw_dump.reserve_dump_area_size)
 		fw_dump.ops->fadump_init_mem_struct(&fw_dump);
 
-	fadump_init_files();
-
 	return 1;
 }
 subsys_initcall(setup_fadump);
-- 
2.23.0

