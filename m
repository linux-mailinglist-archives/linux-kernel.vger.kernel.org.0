Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF81F199976
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgCaPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 11:22:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49284 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgCaPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zW1mJXX01S6hc6lAM0/5NL3R426sp5kOO7vEk1pRlno=; b=nK+odSu435R1sr2b7E+aErSJ4o
        pUuuvHgcHqFF8xMAsWfnuTNznhI1HtGlbyjSm4PJi3Z2+lalRqanhNCs5uGaFTS5u1iEOCaC95oUw
        PAxcOjh4wTKZAs4qKNb2tq+a1MFQly66tCoXwPxJRkOINXwLao+D+xtztsIE3gQU88KHZiySfcapq
        WxCpBueNuDFoH9NA70OCtCEW3LzLIQXpvuRSrDDmW4du6jGFd9zAYuwGR3xEU247iklZSsvoCHJ7N
        uNNCITvmOX9C1DekyDxbPt6vTcLCQFWWbcRi4YeQYi2PAQyVdqBFRduQjHJRm+n8LA/Ksk9uv/Ji4
        02e5CfCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIia-0005Xh-Np; Tue, 31 Mar 2020 15:22:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4574A30015A;
        Tue, 31 Mar 2020 17:22:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2753829D75854; Tue, 31 Mar 2020 17:22:17 +0200 (CEST)
Date:   Tue, 31 Mar 2020 17:22:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 3/3] isolcpus: undeprecate on documentation
Message-ID: <20200331152217.GT20730@hirez.programming.kicks-ass.net>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.271570281@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328152503.271570281@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 12:21:20PM -0300, Marcelo Tosatti wrote:
> isolcpus is used to control steering of interrupts to managed_irqs and
> kernel threads, therefore its incorrect to state that its deprecated.
> 
> Remove deprecation warning.
> 
> Suggested-by: Chris Friesen <chris.friesen@windriver.com>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> @@ -1926,7 +1926,6 @@
>  			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
>  
>  	isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
> -			[Deprecated - use cpusets instead]
>  			Format: [flag-list,]<cpu-list>
>  

It's still an absolute horrible piece of crap though. nozh_full piling
more and more shit on it doesn't make it more shiny.
