Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7281A5BED1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfGAO4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 10:56:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35992 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGAO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hH6jNFENnD1LOcCIYolxBITdKkbyMQAr2N8/Y9mEPXs=; b=wpyU7ZyFih+mQv/d+Qx2SpXjY
        dNVs++V4S62hX2lmLCbekaCwfbjACDQp3THiVEkH5/R0PCtaNU0mAuLKQ7/M9ir0XfLqz/OsKedft
        8SlNJY/K1YPzDJXYnA7fJWDjJCs+0pszYeMW3mRa8rrzSTaloiQqFda7ivtla9PFov3LkB3dENRP4
        OWrPNRlbxB9GbafIwVqJ1kP0i5mrU//La0Ll98cVE87b9i+KynIouUYf96eRRiSHnDcT5gOmxp70e
        nwrVIyfMyjocB/ylnIg1kC2ZJTcyF33yOmiXlIgigIoWrGHNU8CeKim/sklHpeX0RnJ5E4qw0I7BG
        olU09cWpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhxjJ-0000ET-Tu; Mon, 01 Jul 2019 14:56:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 984F0209C957E; Mon,  1 Jul 2019 16:56:28 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:56:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robert Hodaszi <Robert.Hodaszi@digi.com>
Subject: Re: [patch V2 3/6] genirq: Add optional hardware synchronization for
 shutdown
Message-ID: <20190701145628.GC3402@hirez.programming.kicks-ass.net>
References: <20190628111148.828731433@linutronix.de>
 <20190628111440.279463375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628111440.279463375@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 01:11:51PM +0200, Thomas Gleixner wrote:
> But that does not catch the case where the interrupt is on flight at the
> hardware level but not yet serviced by the target CPU. That creates an
> interesing race condition:

> + *	It does not check whether there is an interrupt on flight at the
> + *	hardware level, but not serviced yet, as this might deadlock when
> + *	called with interrupts disabled and the target CPU of the interrupt
> + *	is the current CPU.

> +	/*
> +	 * Make sure it's not being used on another CPU and if the chip
> +	 * supports it also make sure that there is no (not yet serviced)
> +	 * interrupt on flight at the hardware level.
> +	 */
> +	__synchronize_hardirq(desc, true);

s/on flight/in flight/ ?
