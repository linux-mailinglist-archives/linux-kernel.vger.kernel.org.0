Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F348A04B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1OUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:20:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfH1OUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zl4G8WtuziQvLKFqDgMdC9UCvqeacC6em8tdHCZigf0=; b=OkB8WmnON97oS6Y/JoC0YQ4U0E
        IslxnmG7+sUaZwQg4Yi1yE68jOJc8TkEnEfgn7GdDAYmzNN+0GVCubBhKmjjcDXg/H32Nz8ZDKaTb
        19DGkJh2XSDQ48/p5CJFqPFr7krGLZvjpZ460jfdJ+r61yH2Ng3CZyvliJ4Bawc4gKd/RwGomc08I
        nHnqQ6SuMzevS/QTCFkiztqG2QNar+ZUvWNRYmSNrFc+gKZbX0qQ2TUR0qQ3pnnXA4CJ2OTC0S4Ql
        nns156DI7AWQKjg5dAKWdppB4FbZNora49ZcfbYVr4aq4Uc1PccDeBxlA7zrI3veBTAk5a0neMhrV
        h2OQOU2A==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2ynu-0004SO-I3; Wed, 28 Aug 2019 14:20:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 3/3] pagewalk: use lockdep_assert_held for locking validation
Date:   Wed, 28 Aug 2019 16:19:55 +0200
Message-Id: <20190828141955.22210-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828141955.22210-1-hch@lst.de>
References: <20190828141955.22210-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lockdep to check for held locks instead of using home grown
asserts.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 mm/pagewalk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index b8762b673a3d..d48c2a986ea3 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -317,7 +317,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	if (!walk.mm)
 		return -EINVAL;
 
-	VM_BUG_ON_MM(!rwsem_is_locked(&walk.mm->mmap_sem), walk.mm);
+	lockdep_assert_held(&walk.mm->mmap_sem);
 
 	vma = find_vma(walk.mm, start);
 	do {
@@ -367,7 +367,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 	if (!walk.mm)
 		return -EINVAL;
 
-	VM_BUG_ON(!rwsem_is_locked(&vma->vm_mm->mmap_sem));
+	lockdep_assert_held(&walk.mm->mmap_sem);
 
 	err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
 	if (err > 0)
-- 
2.20.1

