Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2F7A2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 10:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfG3IIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 04:08:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbfG3IIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y3iFGUlRLtMdNYNKd2rPyoY/5unGucudlv15bLsbMXQ=; b=epaSeSql5Ltv22UQ0FpT70mNB
        txTtD475/TBnKgqzZqFZNu9hwPS5tMfzbOtHpJUQngl6rt/7v6kvfj3+rYw3jsSTcOoI2mKrHtcDK
        AtrKAHVjM0WCx7GKyJRaolGHRFiDda8K2vFnSwWzvY9M18XGN2BmWxGBorYdrrcieQtg2/yGC8wC/
        LRomltpyYrbTzBTqW5wA7k1NZJy/7XCV34DzizooFC+f+WX+nkRouPkkwmqWITg6wK4OZwQjw1tFM
        IdSVow4M0IleXzUzGO0RRsLxMZ84RVeQ1gHklKHrjbG5wBG2OFGYkcd/UcQVX7cwFDVLLVOpHjE8B
        9fvvM2kzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNBc-0005JA-Fx; Tue, 30 Jul 2019 08:08:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42CE320AFFE9F; Tue, 30 Jul 2019 10:08:43 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:08:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: drop REG_OUT macro from hweight functions
Message-ID: <20190730080843.GG31381@hirez.programming.kicks-ass.net>
References: <20190728115140.GA32463@avx2>
 <20190729094329.GW31381@hirez.programming.kicks-ass.net>
 <20190729100447.GD31425@hirez.programming.kicks-ass.net>
 <20190729204417.GA2146@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729204417.GA2146@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:44:17PM +0300, Alexey Dobriyan wrote:
> On Mon, Jul 29, 2019 at 12:04:47PM +0200, Peter Zijlstra wrote:
> > +#define _ASM_ARG1B	__ASM_FORM_RAW(dil)
> > +#define _ASM_ARG2B	__ASM_FORM_RAW(sil)
> > +#define _ASM_ARG3B	__ASM_FORM_RAW(dl)
> > +#define _ASM_ARG4B	__ASM_FORM_RAW(cl)
> > +#define _ASM_ARG5B	__ASM_FORM_RAW(r8b)
> > +#define _ASM_ARG6B	__ASM_FORM_RAW(r9b)
> 
> I preprocessed percpu code once to see what precisely it does because
> it was easier than wading through forest of macroes.

Per cpu is easy, try reading the tracepoint code ;-)

