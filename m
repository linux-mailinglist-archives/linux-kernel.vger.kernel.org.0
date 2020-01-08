Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21B413431B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgAHM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 07:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAHM7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:59:01 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFAD206F0;
        Wed,  8 Jan 2020 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578488341;
        bh=Or18NYoRhno1YFa4xw03vLiWPF2Fxp4A3Mm81c8PIao=;
        h=From:To:Cc:Subject:Date:From;
        b=O7Zn2gxunIhwEkPj6l2e8WCpsjRpf2yT12TNf6gJ6fPgtQdQk2kD6VsrD13KgV8fZ
         j9za9lEZKKs3vYyRHXfwYRl4GdLb/DdOXNEkiZTXKX7gaWtaJUxvuQo/7mWvShBqB0
         knfrENYT8VdGlFcBeCbc3qVseHSjRFaUo+pVEeLc=
From:   Mike Rapoport <rppt@kernel.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Meelis Roos <mroos@linux.ee>, Jeroen Roovers <jer@gentoo.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] parisc: fix map_pages() to actually populate upper directory
Date:   Wed,  8 Jan 2020 14:58:52 +0200
Message-Id: <20200108125852.19823-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The commit d96885e277b5 ("parisc: use pgtable-nopXd instead of
4level-fixup") converted PA-RISC to use folded page tables, but it missed
the conversion of pgd_populate() to pud_populate() in maps_pages()
function. This caused the upper page table directory to remain empty and
the system would crash as a result.

Using pud_populate() that actually populates the page table instead of
dummy pgd_populate() fixes the issue.

Fixes: d96885e277b5 ("parisc: use pgtable-nopXd instead of 4level-fixup")
Reported-by: Meelis Roos <mroos@linux.ee>
Reported-by: Jeroen Roovers <jer@gentoo.org>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Jeroen Roovers <jer@gentoo.org>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/parisc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index ddca8287d43b..354cf060b67f 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -401,7 +401,7 @@ static void __init map_pages(unsigned long start_vaddr,
 			pmd = (pmd_t *) __pa(pmd);
 		}
 
-		pgd_populate(NULL, pg_dir, __va(pmd));
+		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
 #endif
 		pg_dir++;
 
-- 
2.24.0

