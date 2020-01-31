Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9375614EBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 12:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgAaLbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 06:31:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgAaLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KaRO3eBKc7wPtdVbBvuSCUvQxXSj5ql+XaahWnA3gzo=; b=qqlgqm81+2ljXypV4gygK9XSt
        lzMGytgW6z9Nw25aMB+6Ykzru03UBI14L7otvyJr8lk/rWte1zhkmlaFQqqJQEo47ynod90QWCjre
        2BRn+PVmDLp9vXB27Obgz0Hspk/CLS1uO052EfYusT3pWJuUv5tJ374s90ziWzcQZvG8lU8FZw6h1
        U/vKuPsm0QdVYWDWDxWvbRlcEt4D/I0t35t4RzuA8CJIZPvyhE4PPoydBDApmxzEI8CMqsqihHHGM
        8WTFo2qaXOlRn5h6ldW05kaONzXwXaEaXXPSA4D6r8CTe0P98WljDkABY9sHbgWnvMm/vcSuWwYpZ
        96TM659mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixUWU-0003g6-Mh; Fri, 31 Jan 2020 11:31:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 693B73007F2;
        Fri, 31 Jan 2020 12:29:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7253C203A5C79; Fri, 31 Jan 2020 12:31:39 +0100 (CET)
Date:   Fri, 31 Jan 2020 12:31:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200131113139.GC14914@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
 <20200131093813.GA3938@willie-the-truck>
 <20200131102239.GB14914@hirez.programming.kicks-ass.net>
 <20200131111459.GO14946@hirez.programming.kicks-ass.net>
 <20200131111824.GA4298@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131111824.GA4298@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 11:18:24AM +0000, Will Deacon wrote:
> > > > +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> > > >  {
> > > >  	struct page *page = alloc_pages(GFP_DMA, 0);
> > > >  	pte_t *pte;

> Does that mean we can drop the GFP_DMA too? If so, this all ends up
> looking very similar to the sun3 code wrt alloc/free and they could
> probably use the same implementation (since the generic code doesn't
> like out pgtable_t definition).

Many software TLB archs have limits on what memory the TLB miss handler
itself can access (chicken-egg issues), it might be this is where the
GFP_DMA comes from.

I can't quickly find this in the CFV4e docs, but I'm not really reading
it carefully either.
