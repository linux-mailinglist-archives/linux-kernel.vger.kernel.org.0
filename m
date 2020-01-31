Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05C14ECC5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgAaM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 07:56:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgAaM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y6NQ7WUPygUPeoqsSV5h8nxXiojEVyjEZjXvUDdbeFA=; b=HRWxxGk80Z2wmy/OteRwyZ7vgB
        T/468wg7IU2wQqytZGvUsTgGU7csZ5XY1HwskC1x8YxMdtxIX6NHavMP0Br3/q8hsXogvQ+Bj8MoO
        lh3Bnu1iHcboj5qddz+/AGZUzHduc+IAw3boforzaSL/U8bGO7Nmspo0ShUMbeaydifYxjBUP+lhz
        Nga7vCIAmF2L/YTUGjlDJTxwdyuJRK6W5yNqZpP8KzqQ6f9+OyM9T6kDph6mKDu4IcynW/VQky6Ry
        iJNPPP6crKwf/GlJuecHRwjgpPphl0vzVUCeAwPf9DJag4lbUei86ubscKZPUH2/qaUslsQh+VfhB
        V34ZerXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq7-0003gG-Oo; Fri, 31 Jan 2020 12:56:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3D3EF305D3F;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DDEDC2014711E; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131125403.481739981@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 01/10] m68k,mm: Remove stray nocache in ColdFire pgalloc
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ColdFire V4e is a software TLB-miss architecture, there is no
need for page-tables to be mapped uncached. Remove this stray
nocache_page() dance, which isn't paired with a cache_page() and looks
like a copy/paste/edit fail.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/mcf_pgalloc.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -55,12 +55,8 @@ static inline struct page *pte_alloc_one
 	}
 
 	pte = kmap(page);
-	if (pte) {
+	if (pte)
 		clear_page(pte);
-		__flush_page_to_ram(pte);
-		flush_tlb_kernel_page(pte);
-		nocache_page(pte);
-	}
 	kunmap(page);
 
 	return page;


