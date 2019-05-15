Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB33D1EC65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 06:51:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEOKv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zCCfi2VVHEha3dpNjP34AHH7pIAgmLH8/4Yn0qNp2cA=; b=HtoY5G3/FWVdXgniTqYpme5Ka
        DcSIU+uWGaLpCYVUM7c9mv+Ww1N1vheD0mYXA19Lq6fuTtcxy3CjNlFnWb66dLd8erhV0f4GMQ81C
        24H9VBJC6Rn1pPW59PN0JcJcnjE79H9wW0TFzVJbGTps8twV3/8P2lcMWwoUCeA1QTMgA9WC7sT2B
        6AcV4/lX31mw8rZlvFSuM7zhsmgUQ+Ro0hyUcWmnPE62ChDRO2ulzVAacGe1VnHxBkR2PplrvVbRX
        y6u81NQw7QR0yhwNxAu7zS/0SThlMxBB82B1ZLF/miNpgO+qkxByS1bZwH1Yq8i6wB3wgRMua5rv1
        n3lMlB4/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQrVO-0005HH-A0; Wed, 15 May 2019 10:51:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACBAF2029F888; Wed, 15 May 2019 12:51:24 +0200 (CEST)
Date:   Wed, 15 May 2019 12:51:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Yabin Cui <yabinc@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased
 data_head.
Message-ID: <20190515105124.GE2623@hirez.programming.kicks-ass.net>
References: <20190515003059.23920-1-yabinc@google.com>
 <87ef50xlb8.fsf@ashishki-desk.ger.corp.intel.com>
 <20190515094352.GC2623@hirez.programming.kicks-ass.net>
 <87bm04xcdb.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm04xcdb.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:04:16PM +0300, Alexander Shishkin wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Wed, May 15, 2019 at 09:51:07AM +0300, Alexander Shishkin wrote:
> >> Yabin Cui <yabinc@google.com> writes:
> >> 
> >> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> >> > index 674b35383491..0b9aefe13b04 100644
> >> > --- a/kernel/events/ring_buffer.c
> >> > +++ b/kernel/events/ring_buffer.c
> >> > @@ -54,8 +54,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
> >> >  	 * IRQ/NMI can happen here, which means we can miss a head update.
> >> >  	 */
> >> >  
> >> > -	if (!local_dec_and_test(&rb->nest))
> >> > +	if (local_read(&rb->nest) > 1) {
> >> > +		local_dec(&rb->nest);
> >> 
> >> What stops rb->nest changing between local_read() and local_dec()?
> >
> > Nothing, however it must remain the same :-)
> >
> > That is the cryptic way of saying that since these buffers are strictly
> > per-cpu, the only change can come from interrupts, and they must have a
> > net 0 change. Or rather, an equal amount of decrements to increments.
> >
> > So if it changes, it must also change back to where it was.
> 
> Ah that's true. So the whole ->nest thing can be done with
> READ_ONCE()/WRITE_ONCE() instead?
> Because the use of local_dec_and_test() creates an impression that we
> rely on atomicity of it, which in actuality we don't.

Yes, I think we can get away with that. And that might be a worth-while
optimization for !x86.
