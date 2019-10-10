Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C07D29C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfJJMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 08:43:39 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:41667 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387832AbfJJMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:43:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 888533F9B2;
        Thu, 10 Oct 2019 14:43:30 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=FrkINqaN;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VWP0wce9Z00i; Thu, 10 Oct 2019 14:43:25 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id B7F5B3F9A5;
        Thu, 10 Oct 2019 14:43:23 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 134C636105C;
        Thu, 10 Oct 2019 14:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570711403; bh=xt6K1qPexhW5+7CwvPsIafay+fRiZP0wYtH6Fh+QJgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrkINqaNILpNgwmduymMcYIyCzxNuqG6EjcKLmBoNqw6kDFDvAX81c2NJRYJU7f+D
         qr2ZwCt9VnN8ks21TbYFmP2wtdsUWhTV9kggC7iBYpWOZiAGaAnVoPQkVURZQTolmx
         MRRmWbGMa1SuZ0GDjlf/h2kDLEmpBj62/P0p+hrI=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH v5 2/8] mm: pagewalk: Take the pagetable lock in walk_pte_range()
Date:   Thu, 10 Oct 2019 14:43:08 +0200
Message-Id: <20191010124314.40067-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010124314.40067-1-thomas_os@shipmail.org>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Without the lock, anybody modifying a pte from within this function might
have it concurrently modified by someone else.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 mm/pagewalk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d48c2a986ea3..c5fa42cab14f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -10,8 +10,9 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *pte;
 	int err = 0;
 	const struct mm_walk_ops *ops = walk->ops;
+	spinlock_t *ptl;
 
-	pte = pte_offset_map(pmd, addr);
+	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	for (;;) {
 		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
 		if (err)
@@ -22,7 +23,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		pte++;
 	}
 
-	pte_unmap(pte);
+	pte_unmap_unlock(pte, ptl);
 	return err;
 }
 
-- 
2.21.0

