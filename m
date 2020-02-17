Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F91609C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 06:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBQFEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 00:04:33 -0500
Received: from foss.arm.com ([217.140.110.172]:57596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBQFEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:04:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E4E511D4;
        Sun, 16 Feb 2020 21:04:31 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B28FC3F703;
        Sun, 16 Feb 2020 21:04:29 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] mm/vma: Replace all remaining open encodings with vma_is_anonymous()
Date:   Mon, 17 Feb 2020 10:33:53 +0530
Message-Id: <1581915833-21984-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
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

