Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5272155546
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgBGKFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 05:05:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgBGKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DpJx2T35TLBltfQwDw/CMJMotScVo3os7osEESBHF6Y=; b=LI20WLXI2tTFKZ/xP2Rf3UEO0r
        ZNr7hjhwGqGEaeJH7UjmTdYvQBACERjCz1Q+SsRQluv9WrznmFaWLTI83rMSgqKt7JGzqUe7ZBCI9
        xhNd4asfHsUHQL3t8HTkbV40IFDTcxm+AL+KcEt2bVvrrhDYlp/kkiaExKnYWVD8zNK7rSzXuH/65
        dwHGmkY6/gwbLXIPshDkLDtmak8NTk2eHTvQmjZYpjg+1uS8o/3osySqMFDthtgnQj4eazpJBtFTK
        X0LsGQVDFN8FLE+RyNx/uQrdcqv9EO51R44B/02U3Xmw5E/5FcFc+G2bgjSzUW5alislIL5FDP/9m
        79ymyDxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j00Ce-000174-2m; Fri, 07 Feb 2020 09:45:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E72E30066E;
        Fri,  7 Feb 2020 10:43:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46F992B834461; Fri,  7 Feb 2020 10:45:34 +0100 (CET)
Date:   Fri, 7 Feb 2020 10:45:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH V2] perf/x86: Add Intel Tiger Lake uncore support
Message-ID: <20200207094534.GD14914@hirez.programming.kicks-ass.net>
References: <20200206161527.3529-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206161527.3529-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:15:27AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> For MSR type of uncore units, there is no difference between Ice Lake
> and Tiger Lake. Share the same code with Ice Lake.
> 
> Tiger Lake has two MCs. Both of them are located at 0:0:0. The BAR
> offset is still 0x48. The offset of the two MCs is 0x10000.
> Each MC has three counters to count every read/write/total issued by the
> Memory Controller to DRAM. The counters can be accessed by MMIO.
> They are free-running counters.
> 
> The offset of counters are different for TIGERLAKE_L and TIGERLAKE.
> Add separated mmio_init() functions.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
