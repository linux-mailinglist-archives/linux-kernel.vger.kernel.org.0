Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68BAB17C34D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 17:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 11:53:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hc8EBMbziFCPflui+tXZT2dPAWJHoF3kP2tPXgp7AkU=; b=TK+sI/Ld4B82lkfwn/6fJoY4P+
        gkj8zAwtDF7zS03QcZEyuZaFrQkkqJ8TMExYdioC8sYW7FBqt2Go+0VwlvQagXXs0SPCYIVdBcH1n
        Yy0Mf4ADrOFSbQPFxYmAtS8oULu3+gOG1IqcrLpRwzhePOC2CWGVGkCHJcXNoyWlun5UpH2NOaXW/
        YmYx3SsXWWdkoX4jLsxEYIV5twmHnvFYxG7n8ZX/j6UbX6SwRI74i0m58oiezWmfBUTu2xiXmP4gX
        AHVkS4s8Gq28FyFNtQ9lwpD2pWdu0CdFm1j02F65pvDkjsGCHbG/UiT9Ktekzl1MZAvzqC/QJwLgW
        tW1dsiSw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAGDd-0005Ys-2b; Fri, 06 Mar 2020 16:53:01 +0000
Date:   Fri, 6 Mar 2020 08:53:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Qian Cai <cai@lca.pw>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
Message-ID: <20200306165300.GC25710@bombadil.infradead.org>
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
 <20200304040515.GX2935@paulmck-ThinkPad-P72>
 <20200304043356.GC29971@bombadil.infradead.org>
 <20200304141021.GY2935@paulmck-ThinkPad-P72>
 <20200305151831.GM29971@bombadil.infradead.org>
 <20200305213946.GL2935@paulmck-ThinkPad-P72>
 <CANpmjNOtsdxh3YLcF-pUMua9afWfhg5P_2ziRGSMuT8Gi0c5TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOtsdxh3YLcF-pUMua9afWfhg5P_2ziRGSMuT8Gi0c5TA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:38:39PM +0100, Marco Elver wrote:
> On Thu, 5 Mar 2020 at 22:39, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Thu, Mar 05, 2020 at 07:18:31AM -0800, Matthew Wilcox wrote:
> > > I have found three locations where we use the ->marks array:
> > >
> > > 1.
> > >                         unsigned long data = *addr & (~0UL << offset);
> > >                         if (data)
> > >                                 return __ffs(data);
> > >
> > > 2.
> > >         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> > > 3.
> > >         return test_bit(offset, node_marks(node, mark));
> > >
> > > The modifications -- all done with the spinlock held -- use the non-atomic
> > > bitops:
> > >         return __test_and_set_bit(offset, node_marks(node, mark));
> > >         return __test_and_clear_bit(offset, node_marks(node, mark));
> > >         bitmap_fill(node_marks(node, mark), XA_CHUNK_SIZE);
> > > (that last one doesn't really count -- it's done prior to placing the node
> > > in the tree)
> > >
> > > The first read seems straightforward; I can place a READ_ONCE around
> > > *addr.  The second & third reads are rather less straightforward.
> > > find_next_bit() and test_bit() are common code and use plain loads today.
> >
> > Yes, those last two are a bit annoying, aren't they?  I guess the first
> > thing would be placing READ_ONCE() inside them, and if that results in
> > regressions, have an alternative API for concurrent access?
> 
> FWIW test_bit() is an "atomic" bitop (per atomic_bitops.txt), and
> KCSAN treats it as such. On x86 arch_test_bit() is not instrumented,
> and then in asm-generic/bitops/instrumented-non-atomic.h test_bit() is
> instrumented with instrument_atomic_read(). So on x86, things should
> already be fine for test_bit(). Not sure about other architectures.

Hum.  It may well be documented as atomic, but is it?  Here's the
generic implementation:

static inline int test_bit(int nr, const volatile unsigned long *addr)
{
        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}

arch_test_bit is only used by the instrumented variants:

$ git grep arch_test_bit include
include/asm-generic/bitops/instrumented-non-atomic.h:   return arch_test_bit(nr, addr);

As far as I can tell, the generic version is what's used on x86.  Does
the 'volatile' qualifier save us here?

find_next_bit() doesn't have the 'volatile' qualifier, so may still be
a problem?
