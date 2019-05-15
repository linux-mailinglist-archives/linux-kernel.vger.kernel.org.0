Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F381EB25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 11:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfEOJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 05:44:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44268 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfEOJoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V2wVwDQOL0Svl7KQuc1Uf4o85j+qBPx3DtN/eiZjqFI=; b=k3aakGxIzb8731hrRMBLogFPp
        3G09S3UiShFk17a8ssdtpxZbIW94zqka5s+9EgOQvjRYAIhOuvHlEBACTv2qzvs/qbkWzNr2thOMW
        1FZ/WFlrv8RBpx4na/z5GPai1dVyNctJYRT8rzuQiAdtLBfLncxigo0lNDinW/knOV13aUoeTHwew
        ZwHjmE4H1+7wnL/yDmZ5YsSrLRTzlAtL0IizdJs1zW/EIJ49KbrfEI1IQVgSoPyR1xKipR9UfA5/q
        hAfwbyYuQvC5FK8qyLc6eCL8JX+hPL/ITu1xC2SGqZwn9fMEEUwF3oPDex24+szUYw6sxvFZc6aXN
        5sScCGb4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQqS2-0006rx-Ii; Wed, 15 May 2019 09:43:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B0BE2029F888; Wed, 15 May 2019 11:43:52 +0200 (CEST)
Date:   Wed, 15 May 2019 11:43:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Yabin Cui <yabinc@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased
 data_head.
Message-ID: <20190515094352.GC2623@hirez.programming.kicks-ass.net>
References: <20190515003059.23920-1-yabinc@google.com>
 <87ef50xlb8.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef50xlb8.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 09:51:07AM +0300, Alexander Shishkin wrote:
> Yabin Cui <yabinc@google.com> writes:
> 
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 674b35383491..0b9aefe13b04 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -54,8 +54,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
> >  	 * IRQ/NMI can happen here, which means we can miss a head update.
> >  	 */
> >  
> > -	if (!local_dec_and_test(&rb->nest))
> > +	if (local_read(&rb->nest) > 1) {
> > +		local_dec(&rb->nest);
> 
> What stops rb->nest changing between local_read() and local_dec()?

Nothing, however it must remain the same :-)

That is the cryptic way of saying that since these buffers are strictly
per-cpu, the only change can come from interrupts, and they must have a
net 0 change. Or rather, an equal amount of decrements to increments.

So if it changes, it must also change back to where it was.
