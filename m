Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D455C232F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfETLn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 07:43:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfETLn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IAsS+ge4xF9NsjigSlUWvtRwDOMNtAXXWGXbe9rZsXc=; b=brO4dH1ooQLImPEWeoy1PZsO4
        kLUKz7vtSS/uhxkQkqAUkooG9gOhdBFTIQNobLOTyLSUOBpiFGG5+uTMBCpmclIVKwJg+4fMX8QtG
        yRfWM7zqqsrstCEJra0tLrEjLSzMiV4PGvajeoXrS0nmAchtZKRP28OX2CZF5MPc2ysrM+B4vL7Zx
        q4E/KMXmOQw1IWtVfuoADZ1kRhVxIiFpx/jjdtzUX8r65dgY4ILut+JYFmP2j0HD8xkFj0YfvOUeQ
        J9hT4VLzlAKHTRcoRf5zSLwRrmzddoTwqFpmum5RxwANo2LTSFi6ZcdSZAHVTgKgdZYw2HsAp3uAs
        4AvNtBx4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSght-000776-05; Mon, 20 May 2019 11:43:53 +0000
Date:   Mon, 20 May 2019 04:43:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/2] RISC-V: Setup initial page tables in two stages
Message-ID: <20190520114352.GA5372@infradead.org>
References: <20190502050206.23373-1-anup.patel@wdc.com>
 <20190502050206.23373-3-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502050206.23373-3-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  void __init parse_dtb(unsigned int hartid, void *dtb)
>  {
> -	if (early_init_dt_scan(__va(dtb)))
> +	dtb = (void *)fix_to_virt(FIX_FDT) + ((uintptr_t)dtb & ~PAGE_MASK);
> +	if (early_init_dt_scan(dtb))

FYI, parse_dtb in mainline now lost the hartid argument and takes a
phys_addr_t for the dtb address.

That being said I find the above way to magic.  So we take the fixmap
address and then only the offset from something passed as a pointer?
This just looks very weird.  The way FIX_FDT is defined to add to my
confusion, which might partially be due to not understanding fixmaps
very well.  But it seems like at very least we should set up an
actual kernel pointer for the dtb in setup_vm based on what that
gets passed and stop passing any arguments to parse_dtb to keep
that magic in one place.  And possibly add some comment.

> +#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE

It seems MAX_EARLY_MAPPING_SIZE is defined to a fix constant,
why do we need these conditionals?
