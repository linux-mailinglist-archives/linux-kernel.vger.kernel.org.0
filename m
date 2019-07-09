Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5397563291
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfGIIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 04:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfGIIDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:03:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2554D214AF;
        Tue,  9 Jul 2019 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562659394;
        bh=4h1slV9pnqJH/rMLYpW8VWFuid3BTsn6hQfIGxSGH7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ast2bcDaol/o2l77DZNWhKqIV8d19g7TV+vXqo6wutx0XSI/WVX5UTBgvPLDPIwa/
         H/J3yQT1yiCZ5nymdU1dL9LOVkMnz9L756SrwIQLn1Jz9XgF+esLaiPzLd2g2Y1qJc
         9SfkI6MvUKAdoDcNd/yS0PDlmCCTbeA79lZH9clc=
Date:   Tue, 9 Jul 2019 09:03:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        Will Deacon <will.deacon@arm.com>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Message-ID: <20190709080308.uueqgxuycfp5y2db@willie-the-truck>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617170328.GJ30800@fuggles.cambridge.arm.com>
 <e8fe8faa-72ef-8185-1a9d-dc1bbe0ae15d@jp.fujitsu.com>
 <20190627102724.vif6zh6zfqktpmjx@willie-the-truck>
 <5999ed84-72d0-9d42-bf7d-b8d56eaa4d4a@jp.fujitsu.com>
 <675313fe-007b-c850-d730-a629b82ccfc8@jonmasters.org>
 <d0879ecc-78c6-b66f-3525-aa1ce175178f@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0879ecc-78c6-b66f-3525-aa1ce175178f@jonmasters.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 08:29:26PM -0400, Jon Masters wrote:
> On 7/8/19 8:25 PM, Jon Masters wrote:
> > On 7/2/19 10:45 PM, qi.fuli@fujitsu.com wrote:
> > 
> >> However, we found that with the increase of that the TLB flash was called,
> >> the noise was also increasing. Here we understood that the cause of this 
> >> issue is the implementation of Linux's TLB flush for arm64, especially use of 
> >> TLBI-is instruction which is a broadcast to all processor core on the system. 
> > 
> > Are you saying that for a microbenchmark in which very large numbers of
> > threads are created and destroyed rapidly there are a large number of
> > associated tlb range flushes which always use broadcast TLBIs?
> > 
> > If that's the case, and the hardware doesn't do any ASID filtering and
> > each TLBI results in a DVM to every PE, would it make sense to look at
> > whether there are ways to improve batching/switch to an IPI approach
> > rather than relying on broadcasts, as a more generic solution?
> 
> What I meant was a heuristic to do this automatically, rather than via a
> command line.

One of my main initial objections to this patch [1] still applies to that
approach, though, which is that I don't want the maintenance headache of
maintaining two very different TLB invalidation schemes in the kernel.
Dynamically switching between them is arguably worse. If "jitter" is such a
big deal, then I don't think changing our TLBI mechanism even helps on a
system that has broadcast cache maintenance (including for the I-side) as
well as shared levels of cache further from the CPUs -- it just happens to
solve the case of a spinning mprotect(), well yeah, maybe don't do that if
your hardware can't handle it gracefully.

What I would be interested in seeing is an evaluation of a real workload
that suffers due to our mmu_gather/tlb_flush implementation on arm64 so that
we can understand where the problem lies and whether or not we can do
something to address it. But "jitter is bad, use IPIs" isn't helpful at all.

Will

[1] https://lkml.kernel.org/r/20190617170328.GJ30800@fuggles.cambridge.arm.com
