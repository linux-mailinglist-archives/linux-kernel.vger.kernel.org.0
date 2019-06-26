Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82A056A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfFZNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:13:54 -0400
Received: from verein.lst.de ([213.95.11.211]:43095 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfFZNNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:13:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CC65C68B20; Wed, 26 Jun 2019 15:13:19 +0200 (CEST)
Date:   Wed, 26 Jun 2019 15:13:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, sparclinux@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190626131318.GA5101@lst.de>
References: <20190626225807.205f1382@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626225807.205f1382@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As that function is in code only there to provide compile coverage
something like this should fix the problem:


diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 547ff96fb228..1599de730532 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -861,10 +861,12 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
 #define pgd_page_vaddr(pgd)		\
 	((unsigned long) __va(pgd_val(pgd)))
-#define pgd_page(pgd)			pfn_to_page(pgd_pfn(pgd))
 #define pgd_present(pgd)		(pgd_val(pgd) != 0U)
 #define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
 
+/* only used by the stubbed out hugetlb gup code, should never be called */
+#define pgd_page(pgd)			NULL
+
 static inline unsigned long pud_large(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
