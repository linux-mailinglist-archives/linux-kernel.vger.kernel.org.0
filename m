Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFEF8C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKLJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 04:51:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfKLJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:51:39 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUSph-0007Kr-8r; Tue, 12 Nov 2019 10:51:33 +0100
Date:   Tue, 12 Nov 2019 10:51:31 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
In-Reply-To: <20191112091521.GX4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911121051110.1833@nanos.tec.linutronix.de>
References: <20191111220314.519933535@linutronix.de> <20191111223052.603030685@linutronix.de> <20191112091521.GX4131@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019, Peter Zijlstra wrote:
> On Mon, Nov 11, 2019 at 11:03:25PM +0100, Thomas Gleixner wrote:
> > @@ -59,8 +71,26 @@ long ksys_ioperm(unsigned long from, uns
> >  			return -ENOMEM;
> >  
> >  		memset(iobm->bits, 0xff, sizeof(iobm->bits));
> > +		refcount_set(&iobm->refcnt, 1);
> > +	}
> > +
> > +	/*
> > +	 * If the bitmap is not shared, then nothing can take a refcount as
> > +	 * current can obviously not fork at the same time. If it's shared
> > +	 * duplicate it and drop the refcount on the original one.
> > +	 */
> > +	if (refcount_read(&iobm->refcnt) > 1) {
> > +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> > +		if (!iobm)
> > +			return -ENOMEM;
> > +		io_bitmap_exit();
> 		refcount_set(&iobm->refcnd, 1);

Indeed.
