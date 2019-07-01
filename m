Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816111316A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfECPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 11:47:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38672 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfECPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RyX1DY6Uvv7le7+gvCHN3nc8u0KoqGUCRhrraaCxYak=; b=bHTGox7THPQe5esr1UhA68WT6
        9smmfVhjMKUmiRzGDzceaytcSzkToYw72JIf+AjqMRLPVjra74kSDwnRrvticdF+brmMcs5/1fwRQ
        smuV30Gc/H+L++vRUUEnqKMdu3dzaonh2S+5LbCE96kdKcqxEfSn2daQAoC/VTmpgfLl/1NSQZO2r
        KRtU3b92XxlIODnh6a9xlUdXdYS5w/cNIhSrdaB9NaTJFmb+A6jw3aQOXdZyxObC+KH2qmbbczmMB
        VQ8gpkhZuzNULWV7AKd9c2DCdUEq9dbarYy7uWB8S5colf8Wvrza5s3PfIRbnGSmXO7G8V1EbLPrm
        WJh7S4xrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMaOm-0000c5-5B; Fri, 03 May 2019 15:46:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED55F29ABBCF2; Fri,  3 May 2019 17:46:54 +0200 (CEST)
Date:   Fri, 3 May 2019 17:46:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, jack@suse.com,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190503154654.GE2606@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190501170953.GB2650@hirez.programming.kicks-ass.net>
 <20190502100932.GA7323@redhat.com>
 <20190503141633.GB2606@hirez.programming.kicks-ass.net>
 <20190503153747.GC20802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503153747.GC20802@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 05:37:48PM +0200, Oleg Nesterov wrote:
> (And if we change this code to use wait_event(xchg(readers_block) == 0) we
>  can remove rw_sem altogether).

That patch you just saw and didn't look at did just that.

> The main problem is that this is sub-optimal. We can have a lot of readers
> sleeping in __down_read() when percpu_down_write() succeeds, then after
> percpu_down_write_non_owner() does up_write() they all will be woken just
> to hang in readers_block(). Plus the new readers will need to pass the
> lock-check-unlock-schedule path.

Yes, that's gone. Still, write side locking on percpu-rwsem _should_ be
relatively rare and is certainly not a fast path.

> Peter, just in case... I see another patch from you but I need to run away
> till Monday.

n/p, enjoy the weekend!
