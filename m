Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B299899D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 04:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfHVCzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 22:55:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfHVCzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:55:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6B26189DAE0;
        Thu, 22 Aug 2019 02:55:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4152600CD;
        Thu, 22 Aug 2019 02:55:28 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86/kdump: Reserve extra memory when SME or SEV is active
Date:   Thu, 22 Aug 2019 10:53:28 +0800
Message-Id: <20190822025328.17151-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 22 Aug 2019 02:55:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
SWIOTLB will be enabled even if there is less than 4G of memory when SME
is active, to support DMA of devices that not support address with the
encrypt bit.

And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.

Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
encryption") will always force SWIOTLB to be enabled when SEV is active
in all cases.

Now, when either SME or SEV is active, SWIOTLB will be force enabled,
and this is also true for kdump kernel. As a result kdump kernel will
run out of already scarce pre-reserved memory easily.

So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
is specified or any offset is used. As for the high reservation case, an
extra low memory region will always be reserved and that is enough for
SWIOTLB. Else if the offset format is used, user should be fully aware
of any possible kdump kernel memory requirement and have to organize the
memory usage carefully.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/setup.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf879f5..ed91fa9d9f6e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
 
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
+	unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
 	bool high = false;
 	int ret;
 
@@ -550,6 +550,17 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
+	/*
+	 * When SME/SEV is active, it will always required an extra SWIOTLB
+	 * region.
+	 */
+	if (sme_active() || sev_active()) {
+		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
+		pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
+				(unsigned long)(mem_enc_req >> 20));
+	} else
+		mem_enc_req = 0;
+
 	/* 0 means: find the address automatically */
 	if (!crash_base) {
 		/*
@@ -563,11 +574,19 @@ static void __init reserve_crashkernel(void)
 		if (!high)
 			crash_base = memblock_find_in_range(CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base)
+						crash_size + mem_enc_req,
+						CRASH_ALIGN);
+		/*
+		 * For high reservation, an extra low memory for SWIOTLB will
+		 * always be reserved later, so no need to reserve extra
+		 * memory for memory encryption case here.
+		 */
+		if (!crash_base) {
+			mem_enc_req = 0;
 			crash_base = memblock_find_in_range(CRASH_ALIGN,
 						CRASH_ADDR_HIGH_MAX,
 						crash_size, CRASH_ALIGN);
+		}
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
@@ -583,6 +602,7 @@ static void __init reserve_crashkernel(void)
 			return;
 		}
 	}
+	crash_size += mem_enc_req;
 	ret = memblock_reserve(crash_base, crash_size);
 	if (ret) {
 		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
-- 
2.21.0

