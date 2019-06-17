Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1448D71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfFQTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFQTF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:05:56 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE28D208C0;
        Mon, 17 Jun 2019 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560798356;
        bh=gwzKMKnkmpb67LuXLZlwngatPFxjDRv5Gfxfrd5eRt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JN8AQdeqXwbZLY0TGP1Dn54Mw3jGKe3Db5jPGYTh1Ui3UoHhoNMeybWRQnEqir62z
         GZspIYxrYFO6ED600iqleEgHADxoH12TxLn+uksww4mdqXBj4er0ZCRIPW+gShMHBQ
         8tPEGvva7imgFptxqpivsZJiaYS413/0gqWYXUtg=
Date:   Mon, 17 Jun 2019 21:05:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/isolation: Asset that a housekeeping CPU comes up
 at boot time
Message-ID: <20190617190552.GA10264@lerouge>
References: <20190601113919.2678-1-npiggin@gmail.com>
 <1560151344.y4aukciain.astroid@bobo.none>
 <20190617155931.GK3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617155931.GK3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:59:31PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 10, 2019 at 05:24:32PM +1000, Nicholas Piggin wrote:
> > Nicholas Piggin's on June 1, 2019 9:39 pm:
> > > With the change to allow the boot CPU0 to be isolated, it is possible
> > > to specify command line options that result in no housekeeping CPU
> > > online at boot.
> > > 
> > > An 8 CPU system booted with "nohz_full=0-6 maxcpus=4", for example.
> > > 
> > > It is not easily possible at housekeeping init time to know all the
> > > various SMP options that will result in an invalid configuration, so
> > > this patch adds a sanity check after SMP init, to ensure that a
> > > housekeeping CPU has been onlined.
> > > 
> > > The panic is undesirable, but it's better than the alternative of an
> > > obscure non deterministic failure. The panic will reliably happen
> > > when advanced parameters are used incorrectly.
> > 
> > Ping on this one? This should resolve Frederic's remaining objection
> > to the series (at least until he solves it more generally).
> > 
> > As the series has already been merged, should we get this upstream
> > before release?
> 
> I was hoping for feedback from Frederic, lacking that, I've queued it
> now.
> 

Sorry I just came back from vacation. Any chance we can use a WARN() instead?
I prefer to use panic() only when data is really threatened or such.

Thanks.
