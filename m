Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52A48821
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfFQP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 11:59:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35148 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=38YySIuBWDGCH+kJBVm7kEsuVhxcLDts6v3f1Sg1uSE=; b=LiH0vbSFLGaZrExrZ6z3On83x
        DSETELwD4Fl/808GzekFxZWg7zoheZNzHN/qy0w/8462gyXQ85IaXnKAfJn5iiHdUpyA+a/BwXnwf
        wJaAGhRIQmD9v3zU6qbQyWrpNuAXZzwD9qX6PztjHO6y79mKvSb/nJdKfSlLi0fQTvq+buSVgkgfU
        9gG+NhMn58Lk/oDwI0Aprm2NKkZ39JfycL9ZkhBRK8Xz7yo/QHOF/NoTfkxpkQPVQH/TsgJCtYDGU
        RYDYOchSP7VNLklSlvbtqMZ2oOcC1I6+WtQh8YPjzuSWZrEdV4Fk/YpzoKitPvoJ9qReZY5YNf0YZ
        U9Ah/YdJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcu2g-0000hZ-Bk; Mon, 17 Jun 2019 15:59:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92229201F4619; Mon, 17 Jun 2019 17:59:31 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:59:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up
 at boot time
Message-ID: <20190617155931.GK3436@hirez.programming.kicks-ass.net>
References: <20190601113919.2678-1-npiggin@gmail.com>
 <1560151344.y4aukciain.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560151344.y4aukciain.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 05:24:32PM +1000, Nicholas Piggin wrote:
> Nicholas Piggin's on June 1, 2019 9:39 pm:
> > With the change to allow the boot CPU0 to be isolated, it is possible
> > to specify command line options that result in no housekeeping CPU
> > online at boot.
> > 
> > An 8 CPU system booted with "nohz_full=0-6 maxcpus=4", for example.
> > 
> > It is not easily possible at housekeeping init time to know all the
> > various SMP options that will result in an invalid configuration, so
> > this patch adds a sanity check after SMP init, to ensure that a
> > housekeeping CPU has been onlined.
> > 
> > The panic is undesirable, but it's better than the alternative of an
> > obscure non deterministic failure. The panic will reliably happen
> > when advanced parameters are used incorrectly.
> 
> Ping on this one? This should resolve Frederic's remaining objection
> to the series (at least until he solves it more generally).
> 
> As the series has already been merged, should we get this upstream
> before release?

I was hoping for feedback from Frederic, lacking that, I've queued it
now.

