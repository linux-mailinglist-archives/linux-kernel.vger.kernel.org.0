Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 076ACAB669
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbfIFKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 06:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbfIFKxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:53:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA37A2070C;
        Fri,  6 Sep 2019 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567767234;
        bh=H+yTWQX57cegf2t72h7LJ305mRugKGEYc05Jr3cLZl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X34lVF1/1G4jA3xOv7encmcLEKgk6EnvfH47jJK/im4kRjv2V70PBlcg4SG3UEw8P
         VXV4kn/prPJPDQ0mvUVnK9YWs2xTRyqTwh+MEo3YvXamvvAht+6tt8L3mZQEMuvq99
         BqTWRvdDx3LNTkLZ3D/CoiT09yEmkIdXHjg1jAE0=
Date:   Fri, 6 Sep 2019 12:53:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Austin Kim <austindh.kim@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dvhart@infradead.org, andy@infradead.org, hpa@zytor.com,
        allison@lohutok.net, armijn@tjaldur.nl, kjlu@umn.edu,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: move kmalloc() NULL check routine
Message-ID: <20190906105352.GA8656@kroah.com>
References: <20190905232951.GA28779@LGEARND20B15>
 <20190906093252.GB16843@kroah.com>
 <20190906104341.GW2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906104341.GW2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 12:43:41PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 06, 2019 at 11:32:52AM +0200, Greg KH wrote:
> > On Fri, Sep 06, 2019 at 08:29:51AM +0900, Austin Kim wrote:
> > > The result of kmalloc should have been checked ahead of below statement:
> > > 	pqp = (struct bau_pq_entry *)vp;
> > > 
> > > Move BUG_ON(!vp) before above statement.
> > > 
> > > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> > > ---
> > >  arch/x86/platform/uv/tlb_uv.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> > > index 20c389a..5f0a96bf 100644
> > > --- a/arch/x86/platform/uv/tlb_uv.c
> > > +++ b/arch/x86/platform/uv/tlb_uv.c
> > > @@ -1804,9 +1804,9 @@ static void pq_init(int node, int pnode)
> > >  
> > >  	plsize = (DEST_Q_SIZE + 1) * sizeof(struct bau_pq_entry);
> > >  	vp = kmalloc_node(plsize, GFP_KERNEL, node);
> > > -	pqp = (struct bau_pq_entry *)vp;
> > > -	BUG_ON(!pqp);
> > > +	BUG_ON(!vp);
> > 
> > Ick!  Don't crash the whole machine if you are out of memory, that's a
> > totally lazy and broken driver.  Fix this up properly please.
> 
> This is boot time init; if memory allocation fails, we're in trouble, no
> way forward no way back.
> 
> It is not uncommon to have BUG_ON() for alloc failing during boot.

Hey, how come you get to get away with this here, and in the tty layer I
had to do all sorts of foolish things just for the same "impossible"
thing because syzbot found a way to emulate such lunacy?

Just you wait until the fuzzers get ahold of this code...  :)

greg k-h
