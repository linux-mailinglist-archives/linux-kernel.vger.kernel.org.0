Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87B2964C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfHTPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 11:40:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfHTPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gRJOmusDWoXEQYfCQFpFagMRy6iugEndhzclUCUMHWA=; b=ImbRGxqfPuKYOho8dmzojZLzu
        ctVIsg7lB0TBjYVpbs1Acq91W9lt/XV5ZJCnU6hFcS+6LoE+Kc5lTLG2ChSvZ++IeMV2fViGIcwwc
        uXc8s53/NBrglK9Glpz+ZlHKCyok1UomR2of042aABI7zHdek4QN+7fn35XcllyZT+/lGiJ//tFn1
        +bz+UPOtmaBwrzY/isgAcRQijc+qLtzigI5Eyhn4hfY6t+moZgECGcuPyUPfw3fIXEYyY2PkZqFGt
        yYcVner6hgBZfMb18cnE8BhfFyGCPSrmiVmPcpPrhxFnybrjJQ4pm11nk7zF7wqyogmbIWWGXCbfo
        zlPIl9JJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i06F5-0001P6-FF; Tue, 20 Aug 2019 15:40:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A8EA30768C;
        Tue, 20 Aug 2019 17:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C11D520A21FD0; Tue, 20 Aug 2019 17:40:11 +0200 (CEST)
Date:   Tue, 20 Aug 2019 17:40:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190820154011.GY2332@hirez.programming.kicks-ass.net>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 10:22:07PM +0200, Thomas Gleixner wrote:

> We have the following existing _SHORT variants:

> _G
> _GT3E

Those two are special SOCs due to 'extra graphics bits on', and I
suppose we could collate them. That said; I'm not sure NHM_G ever
shipped, I'm looking at a wikipedia page that says both Auburndale and
Havendale got scrapped.

> _EP
> _EX

Both are historical, intel is no longer making that distinction and
current chips will have _X.

> _CORE
> _DESKTOP

These two and no _SHORT should/could be collated, I think.

> _ULT
> _MOBILE

I suspect these two are the same.

> _XEON_D

Bit unfortunate that; we use _XEON_D for big microservers and ATOM_*_X
for small microservers. So there's room for improvement here by unifying
this.

> _MID

That one lived for 4 atom generations, but afaict it's no longer alive.

> _NNPI
> _TABLET

These are so far one offs, not sure about the future.

> _PLUS

Like said in the other email, that one is not actually a _SHORT at all,
but rather the uarch is 'Goldmont Plus'
