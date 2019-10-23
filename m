Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0CE2283
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbfJWSbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 14:31:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJWSbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t1mBW2Y77bGoe4WyUZsFuThZaILNwh36eHCTT5RAVak=; b=rsvCoTqTHI+J3MI9MkOQOuOnF
        9s0u54rool374MNQEGYKvm4GADQMerw1aowjTT9z4cJVLlP9M+7ubDgkjOKG3A4f4miNHqEnZR+b5
        w+pQEWhVSDKbGJGys2SQr43YskveRg0rKJ502puTLy6198xk52XF7mGsso6ce6A0pX9zfsScIIjPr
        LZwJdLVabsvUIaFstToI3hMaNptxoNtmGoNwMhhgc7UngsgbGfXYQxTQItoKDFZmcnnlt1tQVuIn+
        VVpbzWMmnt/u9zjiy5p6fGye2pjOr90jN18a90Z7dGRpA9zwO+Xk+ekinkSxUcuGQIWWbqLahGxTr
        nXKNYoLjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNLQ4-0000bL-Bt; Wed, 23 Oct 2019 18:31:40 +0000
Date:   Wed, 23 Oct 2019 11:31:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/dumpstack/64: Don't evaluate exception stacks before
 setup
Message-ID: <20191023183140.GC2963@bombadil.infradead.org>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1910231533180.2308@nanos.tec.linutronix.de>
 <20191023135943.GK12121@uranus.lan>
 <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910231950590.1852@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 08:05:49PM +0200, Thomas Gleixner wrote:
> Prevent this by checking the validity of the cea_exception_stack base
> address and bailing out if it is zero.

Could also initialise cea_exception_stack to -1?  That would lead to it
being caught by ...

>  	end = begin + sizeof(struct cea_exception_stacks);
>  	/* Bail if @stack is outside the exception stack area. */
>  	if (stk < begin || stk >= end)

this existing check.

