Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C467B2DD30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfE2MdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:33:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfE2MdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g4ryd9Nzcm7kUpTsMCBskfr2zjZGmv4ARSA21OChxfQ=; b=D63S5V8OyIbUAB7eEEGPP8Q3/7
        KGfP52FNIMKG5CPK9MAfXkp4KoS8g4/onwWItYKxjbfPLWzUSUcKzA7BrqPkVETgxfsMr0RfB8k/p
        3XwcFORrty85MFGzJBxXdqzssL3NI1/98D/uCGT74WXhlhYUT8BX2kYjOhQUlgUb9WMy0S2XRjeYx
        GZNQqwj3O/Hnp3LvWuYymfThISWuwvFF6PH+/N7ak9RrwEc8pnIlPR6QwK66eU4oXaaXtKh143Lzk
        KbCyxjQZnzp+56OkG7pF1wsXadxWGvLh1QdHKWUsnP9zNdn4olg3gP+PUA55lMPF5QlL7C0Whbbqc
        +3/2qjmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVxlK-0004Xo-1g; Wed, 29 May 2019 12:32:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 508EB201DA64E; Wed, 29 May 2019 14:32:56 +0200 (CEST)
Date:   Wed, 29 May 2019 14:32:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 4/7] arm64: pmu: Add function implementation to update
 event index in userpage.
Message-ID: <20190529123256.GT2623@hirez.programming.kicks-ass.net>
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-5-raphael.gault@arm.com>
 <20190529094659.GK2623@hirez.programming.kicks-ass.net>
 <42a937dd-5cf6-6738-6f69-005fce64138f@arm.com>
 <d6f40c6c-6a73-bd7f-e384-050bd9428631@arm.com>
 <0100f2bd-7940-0b81-4c03-205b295a048f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0100f2bd-7940-0b81-4c03-205b295a048f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:25:46PM +0100, Raphael Gault wrote:
> Hi Robin, Hi Peter,
> 
> On 5/29/19 11:50 AM, Robin Murphy wrote:
> > On 29/05/2019 11:46, Raphael Gault wrote:
> > > Hi Peter,
> > > 
> > > On 5/29/19 10:46 AM, Peter Zijlstra wrote:
> > > > On Tue, May 28, 2019 at 04:03:17PM +0100, Raphael Gault wrote:
> > > > > +static int armv8pmu_access_event_idx(struct perf_event *event)
> > > > > +{
> > > > > +    if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> > > > > +        return 0;
> > > > > +
> > > > > +    /*
> > > > > +     * We remap the cycle counter index to 32 to
> > > > > +     * match the offset applied to the rest of
> > > > > +     * the counter indeces.
> > > > > +     */
> > > > > +    if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
> > > > > +        return 32;
> > > > > +
> > > > > +    return event->hw.idx;
> > > > 
> > > > Is there a guarantee event->hw.idx is never 0? Or should you, just like
> > > > x86, use +1 here?
> > > > 
> > > 
> > > You are right, I should use +1 here. Thanks for pointing that out.
> > 
> > Isn't that already the case though, since we reserve index 0 for the
> > cycle counter? I'm looking at ARMV8_IDX_TO_COUNTER() here...
> > 
> 
> Well the current behaviour is correct and takes care of the zero case with
> the ARMV8_IDX_CYCLE_COUNTER check. But using ARMV8_IDX_TO_COUNTER() and add
> 1 would also work. However this seems indeed redundant with the current
> value held in event->hw.idx.

Note that whatever you pick now will become ABI. Also note that the
comment/pseudo-code in perf_event_mmap_page suggests to use idx-1 for
the actual hardware access.
