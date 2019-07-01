Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDBAFA4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfD3N2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 09:28:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfD3N2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0bPBTOFNpBp2MO1fCvxuKfo2LNvgc2kNTbVrh41nb/I=; b=P3r2ENEMQBBV468eKrU5YkCBr1
        kuHidJF1508MoW/ySd8CpyQEMlo7WHC1mrvtiYHJw7SOvrumBDz+tX3jrJ19NliRlMUqTqlJKiZ/j
        TYFRT60gFbWn3avmhd1/RY0xUOpylbCHBNv7Oa6kYvur3xy3mbD/RB9rPDoErFkkYvXVcX90m/q7z
        yd3C6d4uVjIJFok1CSIUm0pcm5k8KDvq9hyXDVE6RtfbmWd15bRvxtZRPxc0a89aVLeZ1AX6zeKqi
        4tVR0Ra+f73OJTL6l2Oc0PDr26TJdnMi2Tyv8DIFdwYaXippoWByBJ/Tjfdc34eceXIriWgBNtLSM
        6OClJymw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLSnu-0004h1-EJ; Tue, 30 Apr 2019 13:28:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0888C236F9E80; Tue, 30 Apr 2019 15:28:12 +0200 (CEST)
Date:   Tue, 30 Apr 2019 15:28:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, jack@suse.com
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190430132811.GB2589@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:51:31PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-04-19 10:56:27 [+0200], Juri Lelli wrote:
> > On 26/03/19 10:34, Juri Lelli wrote:
> > > Hi,
> > > 
> > > Running this reproducer on a 4.19.25-rt16 kernel (with lock debugging
> > > turned on) produces warning below.
> > 
> > And I now think this might lead to an actual crash.
> 
> Peter, could you please take a look at the thread:
>   https://lkml.kernel.org/r/20190419085627.GI4742@localhost.localdomain
> 
> I assumed that returning to userland with acquired locks is something we
> did not want…

Yeah, but AFAIK fs freezing code has a history of doing exactly that..
This is just the latest incarnation here.

So the immediate problem here is that the task doing thaw isn't the same
that did freeze, right? The thing is, I'm not seeing how that isn't a
problem with upstream either.

The freeze code seems to do: percpu_down_write() for the various states,
and then frobs lockdep state.

Thaw then does the reverse, frobs lockdep and then does: percpu_up_write().

percpu_down_write() directly relies on down_write(), and
percpu_up_write() on up_write(). And note how __up_write() has:

	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);

So why isn't this same code coming unstuck in mainline?
