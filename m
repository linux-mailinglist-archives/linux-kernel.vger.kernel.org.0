Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABF191C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgCXWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 18:06:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgCXWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qa/64KC9FoG06GanY9r9veuwmG5ZdB3u7u9hXmcD61s=; b=H0gvRBucrQCJMnVsZnNMUNsXvt
        4Y6sW5QDVV1bNwVPEqfobzaR6YtGOfvzG+gU8m2vO9x1Gdc5NzH6o21vLnmHwkHoZGdaQis66B5io
        ccaeaanV2QRPGLYuUkzhM0rfvpYfFef/1UquqsZ+7/R+9QB1VOPfdPdwkBGhbiIW0FjLqkZCjdBv4
        yE5f5lNK+iEw9EpLhMKVrdrME5kXa6WS8Os3qu56lOQ9He0CO3FqSgSQT+r97OKLJ6Q0Kehf2kcvN
        /bNE2Bi5pOxEGxcvnjGe5UAb+XZnIHzs42XmB32529BcDRFtLvKcmBnmOhBi8HSd5aT0jb16KT5mu
        IFbi9ixw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGrgR-0006Ox-1z; Tue, 24 Mar 2020 22:06:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D486E983502; Tue, 24 Mar 2020 23:05:59 +0100 (CET)
Date:   Tue, 24 Mar 2020 23:05:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 23/26] kbuild/objtool: Add objtool-vmlinux.o pass
Message-ID: <20200324220559.GS2452@worktop.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.288855432@infradead.org>
 <20200324220321.ivoh47j4tkbcwotr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324220321.ivoh47j4tkbcwotr@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:03:21PM -0500, Josh Poimboeuf wrote:

> > +config VMLINUX_VALIDATION
> > +	bool
> > +	depends on STACK_VALIDATION && DEBUG_ENTRY && !PARAVIRT
> > +	default y
> > +
> 
> So I'm assuming this is incompatible with PARAVIRT because of all the
> indirect pvops calls?

Yep.

> I'm thinking it should be easy to detect those and whitelist them
> because they always have a pv_ops relocation associated with the call
> instruction.

I did consider that, but have been too lazy to actually make that work.
Also, the series is large enough as it is.. :-)
