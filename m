Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862B0EC784
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 18:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfKAR27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 13:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfKAR27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:28:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539D62085B;
        Fri,  1 Nov 2019 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572629337;
        bh=m02R3EnPw9HBK/yXEyfNbqhE61yOKQTOoNAaAEoR/Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2qDebQSS7mENXOUn9hv2TqOTWqQRgqiHFhwkM+1ALr14M42QYl5GXSdhetj/+RkYb
         T/wGe+xO/pj4RHWtB+LmtZBZ8Spnkggoa83J0JCy1qsgzdw6jJsdnaZKOZuisqMLFH
         MdvA/QV78Sp0FTsyeMo3TE2ejfHYxgR7m8uAMzzk=
Date:   Fri, 1 Nov 2019 17:28:51 +0000
From:   Will Deacon <will@kernel.org>
To:     "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Jon Masters <jcm@jonmasters.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "indou.takao@fujitsu.com" <indou.takao@fujitsu.com>,
        "maeda.naoaki@fujitsu.com" <maeda.naoaki@fujitsu.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "tokamoto@jp.fujitsu.com" <tokamoto@jp.fujitsu.com>
Subject: Re: [PATCH 0/2] arm64: Introduce boot parameter to disable TLB flush
 instruction within the same inner shareable domain
Message-ID: <20191101172851.GC3983@willie-the-truck>
References: <20190617143255.10462-1-indou.takao@jp.fujitsu.com>
 <93009dbd-b31c-7364-86d2-21f0fac36676@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93009dbd-b31c-7364-86d2-21f0fac36676@jp.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[please note that my email address has changed and the old one doesn't work
 any more]

On Fri, Nov 01, 2019 at 09:56:05AM +0000, qi.fuli@fujitsu.com wrote:
> First of all thanks for the comments for the patch.
> 
> I'm still struggling with this problem to find out the solution.
> As a result of an investigation on this problem, after all, I think it 
> is necessary to improve TLB flush mechanism of the kernel to fix this 
> problem completely.
> 
> So, I'd like to restart a discussion. At first, I summarize this problem 
> to recall what was the problem and then I want to discuss how to fix it.
> 
> Summary of the problem:
> A few months ago I proposed patches to solve a performance problem due 
> to TLB flush.[1]
> 
> A problem is that TLB flush on a core affects all other cores even if 
> all other cores do not need actual flush, and it causes performance 
> degradation.
> 
> In this thread, I explained that:
> * I found a performance problem which is caused by TLBI-is instruction.
> * The problem occurs like this:
>   1) On a core, OS tries to flush TLB using TLBI-is instruction
>   2) TLBI-is instruction causes a broadcast to all other cores, and
>   each core received hard-wired signal
>   3) Each core check if there are TLB entries which have the specified 
> ASID/VA

For those following along at home, my understanding is that this "check"
effectively stalls the pipeline as though it is being performed in software.

Some questions:

Does this mean a malicious virtual machine can effectively DoS the system?
What about a malicious application calling mprotect()?

Do all broadcast TLBI instructions cause this expensive check, or are
some significantly slower than others?

>   4) This check causes performance degradation
> * We ran FWQ[2] and detected OS jitter due to this problem, this noise
>   is serious for HPC usage.
> 
> The noise means here a difference between maximum time and minimum time 
> which the same work takes.
> 
> How to fix:
> I think the cause is TLB flush by TLBI-is because the instruction 
> affects cores that are not related to its flush.

Does broadcast I-cache maintenance cause the same problem?

> So the previous patch I posted is
> * Use mm_cpumask in mm_struct to find appropriate CPUs for TLB flush
> * Exec TLBI instead of TLBI-is only to CPUs specified by mm_cpumask
>   (This is the same behavior as arm32 and x86)
> 
> And after the discussion about this patch, I got the following comments.
> 1) This patch switches the behavior (original flush by TLBI-is and new 
> flush by TLBI) by boot parameter, this implementation is not acceptable 
> due to bad maintainability.
> 2) Even if this patch fixes this problem, it may cause another 
> performance problem.
> 
> I'd like to start over the implementation by considering these points.
> For the second comment above, I will run a benchmark test to analyze the 
> impact on performance.
> Please let me know if there are other points I should take into 
> consideration.

I think it's worth bearing in mind that I have little sympathy for the
problem that you are seeing. As far as I can tell, you've done the
following:

  1. You designed a CPU micro-architecture that stalls whenever it receives
     a TLB invalidation request.

  2. You integrated said CPU design into a system where broadcast TLB
     invalidation is not filtered and therefore stalls every CPU every
     time that /any/ TLB invalidation is broadcast.

  3. You deployed a mixture of Linux and jitter-sensitive software on
     this system, and now you're failing to meet your performance
     requirements.

Have I got that right?

If so, given that your CPU design isn't widely available, nobody else
appears to have made this mistake and jitter hasn't been reported as an
issue for any other systems, it's very unlikely that we're going to make
invasive upstream kernel changes to support you. I'm sorry, but all I can
suggest is that you check that your micro-architecture and performance
requirements are aligned with the design of Linux *before* building another
machine like this in future.

I hate to be blunt, but I also don't want to waste your time.

Thanks,

Will
