Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4A1C821
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfENMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 08:04:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ANiALWppH8ILUGFxS4Qrkx79rFjQyK8e8zRwG0vYFV8=; b=c/Yu05Reag7wzOJIwT0uOImpO
        EKhRRNkobwhMnBKiBQjvxenWIkAaDDHsLs9tA7Et8kWapmXMYqu6S4cMBKbejEICut8reVwxeb+Oj
        YB394+UFayke869Y1+ppmtJN+TBE2WDtcA8OA2gDWxW8vV227TeHHLFUXWBH/kIvtY1GjNxHHEGEW
        3BKaJxP40zy6VY4aGG/WU6aICA9b9BRTVmIWW6XMqkiIEZuaH6tdY7MAqtIpXdfkb1031bZxYN+YA
        Rh77icdImp+fUfm+xa3QlWfVLYeX3R01lJ/An7pZWBiUzFa2AjFwRoUyc3cN8fzfhn9bpfQ/TJJIp
        GMpWZDwRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQWAA-0007l3-DF; Tue, 14 May 2019 12:04:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 086162029F877; Tue, 14 May 2019 14:04:05 +0200 (CEST)
Date:   Tue, 14 May 2019 14:04:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] locking/lockdep: Add lock type enum to explicitly
 specify read or write locks
Message-ID: <20190514120404.GQ2589@hirez.programming.kicks-ass.net>
References: <20190513091203.7299-1-duyuyang@gmail.com>
 <20190513091203.7299-2-duyuyang@gmail.com>
 <20190513114504.GR2623@hirez.programming.kicks-ass.net>
 <CAHttsrYf_SSEHwPZRqs2KGznPgC9Je3dPOft1bwZ5pYC5R0xUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHttsrYf_SSEHwPZRqs2KGznPgC9Je3dPOft1bwZ5pYC5R0xUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 09:31:48AM +0800, Yuyang Du wrote:
> Thanks for review.
> 
> On Mon, 13 May 2019 at 19:45, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, May 13, 2019 at 05:11:47PM +0800, Yuyang Du wrote:
> > > + * Note that we have an assumption that a lock class cannot ever be both
> > > + * read and recursive-read.
> >
> > We have such locks in the kernel... see:
> >
> >   kernel/qrwlock.c:queued_read_lock_slowpath()
> >
> > And yes, that is somewhat unfortunate, but hard to get rid of due to
> > hysterical raisins.
> 
> That is ok, then LOCK_TYPE_RECURSIVE has to be 3 such that
> LOCK_TYPE_RECURSIVE & LOCK_TYPE_READ != 0. I thought to do this in the
> first place without assuming. Anyway, it is better to know.
> 
> And I guess in a task:
> 
> (1) read(X);
>     recursive_read(x);      /* this is ok ? */

Correct, that is the use-case for that 'funny' construct.

> (2) recursive_read(x);
>     read(x)      /* not ok ? */

Indeed, read can block due to a pending writer, while recurise_read will
not suffer like that.

> Either way, very small change may need to be made.

OK, excellent.
