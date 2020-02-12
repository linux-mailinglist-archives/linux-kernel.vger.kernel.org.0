Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476D715A8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBLMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 07:18:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgBLMSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ujAGIKaczDf4GpRvpuhiaw04QsP3EgOUQr2HoMyYUs4=; b=HGIeuuDQ7DAhrkXYZ2yXnwKGyf
        kdmdT4kF1CRPQy3QWtP5FPrZWsr8IpV2gbsh/XZ4oxoHAcOj4fMDjNev7xGuqOOlV/V0xlibqlfw3
        F23PhxPuq3nssSNjQ/Vx1YFZ8c1s2ghAM9h2SAc4BAyGHm2I1ilnfMNgJ58AxJkSLE6lHqeNTnEBt
        4UdkdefPj353RpZYPLaGFxP0UXXczhQX+Gao9kfNj5UgBZN5QKqqvfRgMC+0ea4w3zQ9N+rzga38r
        ToRm+imutApDZzhTlQV4X7VqBPfgnXaCUFg1SHD5gGjoiRMVoR//w1sY+EXn9p+Z8VITGrPv8Adtl
        CBrgv5tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1qyQ-0000Jq-1I; Wed, 12 Feb 2020 12:18:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0E1B305803;
        Wed, 12 Feb 2020 13:16:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C87072B3D2517; Wed, 12 Feb 2020 13:18:30 +0100 (CET)
Date:   Wed, 12 Feb 2020 13:18:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [perf/x86/amd] 471af006a7: will-it-scale.per_process_ops -7.6%
 regression
Message-ID: <20200212121830.GR14897@hirez.programming.kicks-ass.net>
References: <20200212113514.GT12867@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212113514.GT12867@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:35:14PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -7.6% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 471af006a747f1c535c8a8c6c0973c320fe01b22 ("perf/x86/amd: Constrain Large Increment per Cycle events")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory

That commit only changes code relevant to AMD machines; give you have
this result on an Intel machine makes me think the bisect is flawed.
