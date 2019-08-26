Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318459D29F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbfHZPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 11:25:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40486 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfHZPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:25:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2Grz-0007W4-Hf; Mon, 26 Aug 2019 17:25:23 +0200
Date:   Mon, 26 Aug 2019 17:25:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190824031014.GB2731@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-23 23:10:14 [-0400], Joel Fernandes wrote:
> On Fri, Aug 23, 2019 at 02:28:46PM -0500, Scott Wood wrote:
> > On Fri, 2019-08-23 at 18:20 +0200, Sebastian Andrzej Siewior wrote:
> > > 
> > > this looks like an ugly hack. This sleeping_lock_inc() is used where we
> > > actually hold a sleeping lock and schedule() which is okay. But this
> > > would mean we hold a RCU lock and schedule() anyway. Is that okay?
> > 
> > Perhaps the name should be changed, but the concept is the same -- RT-
> > specific sleeping which should be considered involuntary for the purpose of
> > debug checks.  Voluntary sleeping is not allowed in an RCU critical section
> > because it will break the critical section on certain flavors of RCU, but
> > that doesn't apply to the flavor used on RT.  Sleeping for a long time in an
> > RCU critical section would also be a bad thing, but that also doesn't apply
> > here.
> 
> I think the name should definitely be changed. At best, it is super confusing to
> call it "sleeping_lock" for this scenario. In fact here, you are not even
> blocking on a lock.
> 
> Maybe "sleeping_allowed" or some such.

The mechanism that is used here may change in future. I just wanted to
make sure that from RCU's side it is okay to schedule here.

> thanks,
> 
>  - Joel

Sebastian
