Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB31194385
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCZPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:49:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgCZPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YZmeEJKYPJHbkY/cCOL/leC8xH9eLBm5KwsIRYUM2do=; b=quurA32SBaxbly1UiK0hnUGDYU
        UZgBxWnROQ1hJKNggIG7SCUMsIf5BBMaN/fPLWzUmeyg2PD5hslAppnwA+ygftyZacPmaOcAvFsoI
        xc+LmAuhrlqMhCQ7f5qGRN+XxkGb7Euk1iSQaBDV6kEbKtQDhQpwTg2fbwBpFkrsWD+bsZPDeIy7I
        CjM1JyatGzBqnPOsQMebOpoXOWrKPR0/cyIMxqtYZuDY0QOMYRknZokvjRyqbl/SGXRM/seEHPxwd
        U4DvFDQ9/YYZkKhC3Klws6/BxquFhMh5b3uNbL5atR5HQ8dhPIMz3W5ucNBAj6J+7DCn9xLmiSTu7
        u13vphDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHUlI-000721-B9; Thu, 26 Mar 2020 15:49:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45BED3010C1;
        Thu, 26 Mar 2020 16:49:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C9EC205866AC; Thu, 26 Mar 2020 16:49:38 +0100 (CET)
Date:   Thu, 26 Mar 2020 16:49:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326154938.GO20713@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326135620.tlmof5fa7p5wct62@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:56:20AM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 26, 2020 at 12:30:49PM +0100, Peter Zijlstra wrote:
> > This isn't ideal either; stuffing code with NOPs just to make
> > annotations work is certainly sub-optimal, but given that sync_core()
> > is stupid expensive in any case, one extra nop isn't going to be a
> > problem here.
> 
> /me puts his hardened objtool maintainer's glasses on...
> 
> The problem is, when you do this kind of change to somebody else's code
> -- like adding a NOP to driver code -- there's a 90% chance they'll NACK
> it and tell you to fix your shit.  Because they'll be happy to tell you
> the code itself should never be changed just to "make objtool happy".

So the only objtool annotation drivers tend to run into is that uaccess
crud. Drivers really had better not need the CFI annotations, otherwise
they doing massively dodgy things.

And the nice thing with the uaccess crud is that they're anchored to
actual instructions, as opposed to this.

> And honestly, they'd be right, and there's not much you can say in
> reply.  And then we end up having to fix it in objtool again anyway.

Well, I agree. I just haven't managed to come up with anything sensible.

> The 'insn == first' check isn't ideal, but at least it works (I think?).

It works, yes, for exactly this one case.


