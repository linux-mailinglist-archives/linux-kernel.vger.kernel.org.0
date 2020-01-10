Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB3137275
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgAJQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 11:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgAJQHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:07:39 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE3352087F;
        Fri, 10 Jan 2020 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672459;
        bh=NT+C3rfa0dgCpqIe7AgVcCYVZuZOmuBB7mp9Rl6qMH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dahUTwJ30pZ1S5w3UEki1z3pxuLb35tZGM1zPZZIkphU2wXhzS6Lsbs09//bQTeRj
         CHwPppKCvWhmzZtu+qLyMu33nUYWb8/QHMewGS+Lq9Pfb0Kwpax18TcdbH8KUgrKEX
         6OhasiYhZDvWbZVokhuaha18qHthxUyEWnavFXrQ=
Date:   Fri, 10 Jan 2020 16:07:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Qian Cai <cai@lca.pw>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next] arm64/mm/dump: fix a compilation error
Message-ID: <20200110160734.GA25891@willie-the-truck>
References: <20200110145112.7959-1-cai@lca.pw>
 <20200110153447.GA30104@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110153447.GA30104@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:34:48PM +0000, Steven Price wrote:
> On Fri, Jan 10, 2020 at 02:51:12PM +0000, Qian Cai wrote:
> > The linux-next commit "x86: mm: avoid allocating struct mm_struct on the
> > stack" [1] introduced a compilation error with "arm64: mm: convert
> > mm/dump.c to use walk_page_range()" [2]. Fixed it by using the new API.
> > 
> > arch/arm64/mm/dump.c:326:38: error: too few arguments to function call,
> > expected 3, have 2
> >         ptdump_walk_pgd(&st.ptdump, info->mm);
> >         ~~~~~~~~~~~~~~~                     ^
> > ./include/linux/ptdump.h:20:1: note: 'ptdump_walk_pgd' declared here
> > void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm,
> > pgd_t *pgd);
> > ^
> > arch/arm64/mm/dump.c:364:38: error: too few arguments to function call,
> > expected 3, have 2
> >         ptdump_walk_pgd(&st.ptdump, &init_mm);
> >         ~~~~~~~~~~~~~~~                     ^
> > ./include/linux/ptdump.h:20:1: note: 'ptdump_walk_pgd' declared here
> > void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm,
> > pgd_t *pgd);
> > ^
> > 2 errors generated.
> > 
> > [1] http://lkml.kernel.org/r/20200108145710.34314-1-steven.price@arm.com
> 
> Actually this was in the patch I originally posted - somehow it got
> lost when Andrew picked it up.
> 
> > [2] http://lkml.kernel.org/r/20191218162402.45610-22-steven.price@arm.com
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Since this matches what I originally wrote... ;)
> 
> Reviewed-by: Steven Price <steven.price@arm.com>

Acked-by: Will Deacon <will@kernel.org>

I'm assuming Andrew will queue this alongside the others.

Thanks,

Will
