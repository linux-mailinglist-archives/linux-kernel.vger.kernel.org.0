Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B3787C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfG2IxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 04:53:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2IxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P08er2k4BOyqJGgXnVu3fzZuyZwmGSPU9ApKU3uDuck=; b=P3ghzHyr6Bayxh+MSd8rfYNDe
        Rv/tfuH0Hzk2GJhyxKlBscOD9CKu+1d1bQtyVCWp9DPoDY3oOGGlasyPe9qLv//vfPFJXX0367z4+
        qb2SkUIDWtaF/xJzAbuvMoy1iysgvLAzmgQyE30NDJf0ryDXS1OgA3IPeIG9ikpFWPzGQix/lJoDj
        +zRDotHYSnS0xY5SENiaqPuVBTLN6BuZ6Awqmx6coHEfcUSvRgzOHDDbCM35mWVSfbntaTejBZoXK
        ylTen1YRJIzYSnTcbLr5iw0uF8jM2hqXCP3Uh39hxhOcbXejJd6IIdk32mCa5gYgUnd2b1/BRytVs
        JrOnPaIbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs1P0-0008QD-4n; Mon, 29 Jul 2019 08:53:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9799F2025E7AD; Mon, 29 Jul 2019 10:53:04 +0200 (CEST)
Date:   Mon, 29 Jul 2019 10:53:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     tglx@linutronix.de, luto@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Remove the unused schedule_user() function
Message-ID: <20190729085304.GU31381@hirez.programming.kicks-ass.net>
References: <20190727165513.25636-1-devel@etsukata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727165513.25636-1-devel@etsukata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 01:55:13AM +0900, Eiichi Tsukata wrote:
> Since commit 02bc7768fe44 ("x86/asm/entry/64: Migrate error and IRQ exit
> work to C and remove old assembly code"), it's no longer used.

Thanks!
