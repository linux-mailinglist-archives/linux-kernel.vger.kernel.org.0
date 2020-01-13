Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB88A138C23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 08:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAMHD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 02:03:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:40143 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgAMHD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:03:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 23:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="247622717"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2020 23:03:57 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/gup.c: use is_vm_hugetlb_page() to check whether to follow huge
Date:   Mon, 13 Jan 2020 15:03:22 +0800
Message-Id: <20200113070322.26627-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, just leverage the helper function to improve
readability as others.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7646bf993b25..7705929cc920 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -323,7 +323,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	pmdval = READ_ONCE(*pmd);
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
-	if (pmd_huge(pmdval) && vma->vm_flags & VM_HUGETLB) {
+	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
 		page = follow_huge_pmd(mm, address, pmd, flags);
 		if (page)
 			return page;
@@ -433,7 +433,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pud_offset(p4dp, address);
 	if (pud_none(*pud))
 		return no_page_table(vma, flags);
-	if (pud_huge(*pud) && vma->vm_flags & VM_HUGETLB) {
+	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
 		page = follow_huge_pud(mm, address, pud, flags);
 		if (page)
 			return page;
-- 
2.17.1

