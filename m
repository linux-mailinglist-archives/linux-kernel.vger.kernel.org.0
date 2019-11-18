Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9BFFE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 07:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKRGjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 01:39:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfKRGjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:39:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 61B1DEE64FB8E6ED1E0D;
        Mon, 18 Nov 2019 14:39:12 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 14:38:56 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <richardw.yang@linux.intel.com>,
        <sfr@canb.auug.org.au>, <rppt@linux.ibm.com>, <jannh@google.com>,
        <steve.capper@arm.com>, <catalin.marinas@arm.com>,
        <aarcange@redhat.com>, <chenjianhong2@huawei.com>,
        <walken@google.com>, <dave.hansen@linux.intel.com>,
        <tiny.windzz@gmail.com>, <jhubbard@nvidia.com>, <david@redhat.com>
CC:     <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] mm: get rid of odd jump labels in find_mergeable_anon_vma()
Date:   Mon, 18 Nov 2019 14:39:07 +0800
Message-ID: <1574059147-13678-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

The jump labels try_prev and none are not really needed
in find_mergeable_anon_vma(), eliminate them to improve
readability.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
-v2:
	Fix commit descriptions and further simplify the code
	as suggested by David Hildenbrand and John Hubbard.
-v3:
	Rewrite patch version info. Don't show this in commit log.
---
 mm/mmap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4d4db76a07da..ff02c23fd375 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1276,26 +1276,25 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_
  */
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
-	struct anon_vma *anon_vma;
+	struct anon_vma *anon_vma = NULL;
 	struct vm_area_struct *near;
 
+	/* Try next first. */
 	near = vma->vm_next;
-	if (!near)
-		goto try_prev;
+	if (near) {
+		anon_vma = reusable_anon_vma(near, vma, near);
+		if (anon_vma)
+			return anon_vma;
+	}
 
-	anon_vma = reusable_anon_vma(near, vma, near);
-	if (anon_vma)
-		return anon_vma;
-try_prev:
+	/* Try prev next. */
 	near = vma->vm_prev;
-	if (!near)
-		goto none;
+	if (near)
+		anon_vma = reusable_anon_vma(near, near, vma);
 
-	anon_vma = reusable_anon_vma(near, near, vma);
-	if (anon_vma)
-		return anon_vma;
-none:
 	/*
+	 * We might reach here with anon_vma == NULL if we can't find
+	 * any reusable anon_vma.
 	 * There's no absolute need to look only at touching neighbours:
 	 * we could search further afield for "compatible" anon_vmas.
 	 * But it would probably just be a waste of time searching,
@@ -1303,7 +1302,7 @@ struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 	 * We're trying to allow mprotect remerging later on,
 	 * not trying to minimize memory used for anon_vmas.
 	 */
-	return NULL;
+	return anon_vma;
 }
 
 /*
-- 
2.19.1

