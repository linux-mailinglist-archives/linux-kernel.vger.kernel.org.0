Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52CA169D59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 06:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgBXFDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 00:03:55 -0500
Received: from foss.arm.com ([217.140.110.172]:57754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXFDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:03:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48584101E;
        Sun, 23 Feb 2020 21:03:53 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB6DF3F534;
        Sun, 23 Feb 2020 21:03:51 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V2 4/4] mm/vma: Replace all remaining open encodings with vma_is_anonymous()
Date:   Mon, 24 Feb 2020 10:33:13 +0530
Message-Id: <1582520593-30704-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
References: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces all remaining open encodings with vma_is_anonymous().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index c8ffe2e61f03..58c8cbfeded6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -146,7 +146,8 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 	 * But we can only make this optimization where a hole would surely
 	 * be zero-filled if handle_mm_fault() actually did handle it.
 	 */
-	if ((flags & FOLL_DUMP) && (!vma->vm_ops || !vma->vm_ops->fault))
+	if ((flags & FOLL_DUMP) &&
+			(vma_is_anonymous(vma) || !vma->vm_ops->fault))
 		return ERR_PTR(-EFAULT);
 	return NULL;
 }
-- 
2.20.1

