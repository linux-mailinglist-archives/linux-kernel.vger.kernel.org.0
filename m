Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE542632A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfGIIH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 04:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfGIIH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:07:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112E2216C4;
        Tue,  9 Jul 2019 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562659676;
        bh=DNUvEwIMLQXTZD5Y7EQdCgb2qw8MYQFBfgOVVb6NjT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmtOfnghaj1Mzr2LXNuXxUfNoz7LaSROB2zmH2/0rPSZJ+qpyVmBml/XTgtME+Be4
         GdxemR2q0+/UmrpTxDujV99zKURn6bqU4KtxogUGYqiTZSWeQqUBo4eZ/lsTgEqeeA
         xOFDCGIQhnPJ6T8PyjOShW6TYGHDLJIZtMOWS720=
Date:   Tue, 9 Jul 2019 09:07:52 +0100
From:   Will Deacon <will@kernel.org>
To:     "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20190709080751.3nm2llg64g44hmwn@willie-the-truck>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <20190617170328.GJ30800@fuggles.cambridge.arm.com>
 <e8fe8faa-72ef-8185-1a9d-dc1bbe0ae15d@jp.fujitsu.com>
 <20190627102724.vif6zh6zfqktpmjx@willie-the-truck>
 <5999ed84-72d0-9d42-bf7d-b8d56eaa4d4a@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5999ed84-72d0-9d42-bf7d-b8d56eaa4d4a@jp.fujitsu.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 02:45:43AM +0000, qi.fuli@fujitsu.com wrote:
> We used FWQ [1] to do an experiment on 1 node of our HPC environment,
> we expected it would be tens of microseconds of maximum OS jitter, but 
> it was
> hundreds of microseconds, which didn't meet our requirement. We tried to 
> find
> out the cause by using ftrace, but we cannot find any processes which would
> cause noise and only knew the extension of processing time. Then we 
> confirmed
> the CPU instruction count through CPU PMU, we also didn't find any changes.
> However, we found that with the increase of that the TLB flash was called,
> the noise was also increasing. Here we understood that the cause of this 
> issue
> is the implementation of Linux's TLB flush for arm64, especially use of 
> TLBI-is
> instruction which is a broadcast to all processor core on the system. 
> Therefore,
> we made this patch set to fix this issue. After testing for several 
> times, the
> noise was reduced and our original goal was achieved, so we do think 
> this patch
> makes sense.
> 
> As I mentioned, the OS jitter is a vital issue for large-scale HPC 
> environment.
> We tried a lot of things to reduce the OS jitter. One of them is task 
> separation
> between the CPUs which are used for computing and the CPUs which are 
> used for
> maintenance. All of the daemon processes and I/O interrupts are bounden 
> to the
> maintenance CPUs. Further more, we used nohz_full to avoid the noise 
> caused by
> computing CPU interruption, but all of the CPUs were affected by TLBI-is
> instruction, the task separation of CPUs didn't work. Therefore, we 
> would like
> to implement that TLB flush is done on minimal CPUs to reducing the OS 
> jitter
> by using this patch set.

So have you confirmed that this is due to TLBI traffic and not, for example,
stores sitting in remote store buffers that get flushed by the IPI or
something else like that? It feels like you're inferring things about the
underlying behaviour, whereas you should be in a position to simulate this
if nothing else.

If it *is* because of TLBI, then where are they coming from? Is FWQ calling
munmap/mprotect all the time? Why?

Will
