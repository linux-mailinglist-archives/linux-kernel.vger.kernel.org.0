Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066D4199C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgCaQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:55:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgCaQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:55:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09140ADBB;
        Tue, 31 Mar 2020 16:55:03 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] mm, dump_page(): do not crash with invalid mapping pointer
Date:   Tue, 31 Mar 2020 18:54:54 +0200
Message-Id: <20200331165454.12263-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have seen a following problem on a RPi4 with 1G RAM:

BUG: Bad page state in process systemd-hwdb  pfn:35601
page:ffff7e0000d58040 refcount:15 mapcount:131221 mapping:efd8fe765bc80080 index:0x1 compound_mapcount: -32767
Unable to handle kernel paging request at virtual address efd8fe765bc80080
Mem abort info:
  ESR = 0x96000004
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[efd8fe765bc80080] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] SMP
Modules linked in: btrfs libcrc32c xor xor_neon zlib_deflate raid6_pq mmc_block xhci_pci xhci_hcd usbcore sdhci_iproc sdhci_pltfm sdhci mmc_core clk_raspberrypi gpio_raspberrypi_exp pcie_brcmstb bcm2835_dma gpio_regulator phy_generic fixed sg scsi_mod efivarfs
Supported: No, Unreleased kernel
CPU: 3 PID: 408 Comm: systemd-hwdb Not tainted 5.3.18-8-default #1 SLE15-SP2 (unreleased)
Hardware name: raspberrypi rpi/rpi, BIOS 2020.01 02/21/2020
pstate: 40000085 (nZcv daIf -PAN -UAO)
pc : __dump_page+0x268/0x368
lr : __dump_page+0xc4/0x368
sp : ffff000012563860
x29: ffff000012563860 x28: ffff80003ddc4300
x27: 0000000000000010 x26: 000000000000003f
x25: ffff7e0000d58040 x24: 000000000000000f
x23: efd8fe765bc80080 x22: 0000000000020095
x21: efd8fe765bc80080 x20: ffff000010ede8b0
x19: ffff7e0000d58040 x18: ffffffffffffffff
x17: 0000000000000001 x16: 0000000000000007
x15: ffff000011689708 x14: 3030386362353637
x13: 6566386466653a67 x12: 6e697070616d2031
x11: 32323133313a746e x10: 756f6370616d2035
x9 : ffff00001168a840 x8 : ffff00001077a670
x7 : 000000000000013d x6 : ffff0000118a43b5
x5 : 0000000000000001 x4 : ffff80003dd9e2c8
x3 : ffff80003dd9e2c8 x2 : 911c8d7c2f483500
x1 : dead000000000100 x0 : efd8fe765bc80080
Call trace:
 __dump_page+0x268/0x368
 bad_page+0xd4/0x168
 check_new_page_bad+0x80/0xb8
 rmqueue_bulk.constprop.26+0x4d8/0x788
 get_page_from_freelist+0x4d4/0x1228
 __alloc_pages_nodemask+0x134/0xe48
 alloc_pages_vma+0x198/0x1c0
 do_anonymous_page+0x1a4/0x4d8
 __handle_mm_fault+0x4e8/0x560
 handle_mm_fault+0x104/0x1e0
 do_page_fault+0x1e8/0x4c0
 do_translation_fault+0xb0/0xc0
 do_mem_abort+0x50/0xb0
 el0_da+0x24/0x28
Code: f9401025 8b8018a0 9a851005 17ffffca (f94002a0)
---[ end trace 703ac54becfd8094 ]---

Besides the underlying issue with page->mapping containing a bogus value for
some reason, we can see that __dump_page() crashed by trying to read the
pointer at mapping->host, turning a recoverable warning into full Oops.

It can be expected that when page is reported as bad state for some reason, the
pointers there should not be trusted blindly. So this patch treats all data in
__dump_page() that depends on page->mapping as lava, using
probe_kernel_read_strict(). Ideally this would include the dentry->d_parent
recursively, but that would mean changing printk handler for %pd. Chances of
reaching the dentry printing part with an initially bogus mapping pointer
should be rather low, though.

Also prefix printing mapping->a_ops with a description of what is being
printed.  In case the value is bogus, %ps will print raw value instead of
the symbol name and then it's not obvious at all that it's printing a_ops.

Reported-by: Petr Tesarik <ptesarik@suse.cz>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/debug.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 2189357f0987..f2ede2df585a 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -110,13 +110,57 @@ void __dump_page(struct page *page, const char *reason)
 	else if (PageAnon(page))
 		type = "anon ";
 	else if (mapping) {
-		if (mapping->host && mapping->host->i_dentry.first) {
-			struct dentry *dentry;
-			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
-			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
-		} else
-			pr_warn("%ps\n", mapping->a_ops);
+		const struct inode *host;
+		const struct address_space_operations *a_ops;
+		const struct hlist_node *dentry_first;
+		const struct dentry *dentry_ptr;
+		struct dentry dentry;
+
+		/*
+		 * mapping can be invalid pointer and we don't want to crash
+		 * accessing it, so probe everything depending on it carefully
+		 */
+		if (probe_kernel_read_strict(&host, &mapping->host,
+						sizeof(struct inode *)) ||
+		    probe_kernel_read_strict(&a_ops, &mapping->a_ops,
+				sizeof(struct address_space_operations *))) {
+			pr_warn("failed to read mapping->host or a_ops, mapping not a valid kernel address?\n");
+			goto out_mapping;
+		}
+
+		if (!host) {
+			pr_warn("mapping->a_ops:%ps\n", a_ops);
+			goto out_mapping;
+		}
+
+		if (probe_kernel_read_strict(&dentry_first,
+			&host->i_dentry.first, sizeof(struct hlist_node *))) {
+			pr_warn("mapping->a_ops:%ps with invalid mapping->host inode address %px\n",
+				a_ops, host);
+			goto out_mapping;
+		}
+
+		if (!dentry_first) {
+			pr_warn("mapping->a_ops:%ps\n", a_ops);
+			goto out_mapping;
+		}
+
+		dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
+		if (probe_kernel_read_strict(&dentry, dentry_ptr,
+							sizeof(struct dentry))) {
+			pr_warn("mapping->aops:%ps with invalid mapping->host->i_dentry.first %px\n",
+				a_ops, dentry_ptr);
+		} else {
+			/*
+			 * if dentry is corrupted, the %pd handler may still
+			 * crash, but it's unlikely that we reach here with a
+			 * corrupted struct page
+			 */
+			pr_warn("mapping->aops:%ps dentry name:\"%pd\"\n",
+								a_ops, &dentry);
+		}
 	}
+out_mapping:
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
 	pr_warn("%sflags: %#lx(%pGp)%s\n", type, page->flags, &page->flags,
-- 
2.26.0

