Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB65140A54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 13:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgAQM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 07:58:51 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:24029 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579265930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4o9RJx4StHoB6G/jxqKKoPDaZjJC3Q3+qMbkHErq6tg=;
  b=SpQSiS9/KHUuklPY1uzrE47ds80wJ4lqcAK/1frmAUd1CtVvrpwlnThf
   SG5IMSj+DhZrdyn6UDT3Z1M58ZZKbHggy1crA2vMraXY5wImU5BygTXwe
   q5L/Syq/Fumxlp2d8VDrzmIhjgiEw+S8uKK3BhI4r3nLL4b800W3/JKuW
   Y=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: zD3guFlkH9JhD+uSChmLcxdihehn1gAY55V0yNOLmfd5xHNkkyjQkaG1rNe8JDLriMbXtqsdj0
 81dpZI705lNPF60X/LSI9Zed8Ipu/jX3FdGD0/VCa2xZQHYWL1ajeD5dMTEwtRTi9r2yF6xi9U
 BWpJr6wpKSm7udaVNwywU2OV5nt7AoxiT6BZueqhYAr6rFhXtL4h856U0/kqypBQmHvOBz7pSc
 dndcgglECoHTuRJtrokHRkSL/prOB0icVkoTw4UuoGG6SOWAn45h1sm75ZIutyTQgiKCbBK8cc
 FgM=
X-SBRS: 2.7
X-MesageID: 11502055
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,330,1574139600"; 
   d="scan'208";a="11502055"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v2 1/4] kasan: introduce set_pmd_early_shadow()
Date:   Fri, 17 Jan 2020 12:58:31 +0000
Message-ID: <20200117125834.14552-2-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117125834.14552-1-sergey.dyasli@citrix.com>
References: <20200117125834.14552-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is incorrect to call pmd_populate_kernel() multiple times for the
same page table from inside Xen PV domains. Xen notices it during
kasan_populate_early_shadow():

    (XEN) mm.c:3222:d155v0 mfn 3704b already pinned

This happens for kasan_early_shadow_pte when USE_SPLIT_PTE_PTLOCKS is
enabled. Fix this by introducing set_pmd_early_shadow() which calls
pmd_populate_kernel() only once and uses set_pmd() afterwards.

Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
v1 --> v2:
- Fix compilation without CONFIG_XEN_PV
- Slightly updated description

RFC --> v1:
- New patch
---
 mm/kasan/init.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ce45c491ebcd..7791fe0a7704 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -81,6 +81,26 @@ static inline bool kasan_early_shadow_page_entry(pte_t pte)
 	return pte_page(pte) == virt_to_page(lm_alias(kasan_early_shadow_page));
 }
 
+#ifdef CONFIG_XEN_PV
+static inline void set_pmd_early_shadow(pmd_t *pmd)
+{
+	static bool pmd_populated = false;
+	pte_t *early_shadow = lm_alias(kasan_early_shadow_pte);
+
+	if (likely(pmd_populated)) {
+		set_pmd(pmd, __pmd(__pa(early_shadow) | _PAGE_TABLE));
+	} else {
+		pmd_populate_kernel(&init_mm, pmd, early_shadow);
+		pmd_populated = true;
+	}
+}
+#else
+static inline void set_pmd_early_shadow(pmd_t *pmd)
+{
+	pmd_populate_kernel(&init_mm, pmd, lm_alias(kasan_early_shadow_pte));
+}
+#endif /* ifdef CONFIG_XEN_PV */
+
 static __init void *early_alloc(size_t size, int node)
 {
 	void *ptr = memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
@@ -120,8 +140,7 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 		next = pmd_addr_end(addr, end);
 
 		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
@@ -157,8 +176,7 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
 			pmd = pmd_offset(pud, addr);
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
@@ -198,8 +216,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
 			pmd = pmd_offset(pud, addr);
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
@@ -271,8 +288,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
 			pmd = pmd_offset(pud, addr);
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
-- 
2.17.1

