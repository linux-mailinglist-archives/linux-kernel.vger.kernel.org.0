Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52816574D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 07:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgBTGKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 01:10:53 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38347 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:10:53 -0500
Received: from debian.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6C72B240005;
        Thu, 20 Feb 2020 06:10:50 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Use p*d_leaf macros to define p*d_huge
Date:   Thu, 20 Feb 2020 01:10:23 -0500
Message-Id: <20200220061023.958-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced p*d_leaf macros allow to check if an entry of the
page table map to a physical page instead of the next level. To avoid
duplication of code, use those macros to determine if a page table entry
points to a hugepage.

Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/hugetlbpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 0d4747e9d5b5..a6189ed36c5f 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -4,14 +4,12 @@
 
 int pud_huge(pud_t pud)
 {
-	return pud_present(pud) &&
-		(pud_val(pud) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+	return pud_leaf(pud);
 }
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_present(pmd) &&
-		(pmd_val(pmd) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC));
+	return pmd_leaf(pmd);
 }
 
 static __init int setup_hugepagesz(char *opt)
-- 
2.20.1

