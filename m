Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51FBAD30D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 08:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfIIGWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 02:22:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:32804 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbfIIGWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:22:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i7D3C-0006NS-Ao; Mon, 09 Sep 2019 16:21:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Sep 2019 16:21:11 +1000
Date:   Mon, 9 Sep 2019 16:21:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, joel@joelfernandes.org,
        stern@rowland.harvard.edu, rostedt@goodmis.org,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, boqun.feng@gmail.com, will.deacon@arm.com,
        dhowells@redhat.com
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190909062111.GA14572@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820135612.GS2332@hirez.programming.kicks-ass.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:
>
> Paulmck actually has an example of that somewhere; ISTR that particular
> case actually got fixed by GCC, but I'd really _love_ for some compiler
> people (both GCC and LLVM) to state that their respective compilers will
> not do load/store tearing for machine word sized load/stores.
> 
> Without this written guarantee (which supposedly was in older GCC
> manuals but has since gone missing), I'm loathe to rely on it.

IIRC in that case gcc actually broke atomic writes even with a
volatile keyword.  So even WRITE_ONCE wouldn't have saved us.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
