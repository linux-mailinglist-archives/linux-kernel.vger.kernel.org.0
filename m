Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75251E2542
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 23:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392408AbfJWV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 17:27:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbfJWV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:27:35 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNOAG-00012f-6l; Wed, 23 Oct 2019 23:27:32 +0200
Date:   Wed, 23 Oct 2019 23:27:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/dumpstack/64: Don't evaluate exception stacks before
 setup
In-Reply-To: <20191023183140.GC2963@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1910232326490.1852@nanos.tec.linutronix.de>
References: <20191019114421.GK9698@uranus.lan> <20191022142325.GD12121@uranus.lan> <20191022145619.GE12121@uranus.lan> <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de> <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
 <20191023135943.GK12121@uranus.lan> <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de> <20191023183140.GC2963@bombadil.infradead.org>
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

On Wed, 23 Oct 2019, Matthew Wilcox wrote:

> On Wed, Oct 23, 2019 at 08:05:49PM +0200, Thomas Gleixner wrote:
> > Prevent this by checking the validity of the cea_exception_stack base
> > address and bailing out if it is zero.
> 
> Could also initialise cea_exception_stack to -1?  That would lead to it
> being caught by ...
> 
> >  	end = begin + sizeof(struct cea_exception_stacks);
> >  	/* Bail if @stack is outside the exception stack area. */
> >  	if (stk < begin || stk >= end)
> 
> this existing check.

Yes thought about that, but then decided to do it in a readable way :)
