Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82901FBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfD3OnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:43:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfD3OnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:43:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B217C05E770;
        Tue, 30 Apr 2019 14:43:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id ACEA17B9D7;
        Tue, 30 Apr 2019 14:42:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Apr 2019 16:42:59 +0200 (CEST)
Date:   Tue, 30 Apr 2019 16:42:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, jack@suse.com
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190430144252.GF23020@redhat.com>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190430141500.GE23020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430141500.GE23020@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 30 Apr 2019 14:43:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have cloned linux-rt-devel.git

If I understand correctly, in rt rw_semaphore is actually defined in rwsem_rt.h
so percpu_rwsem_acquire() should probably do

	sem->rw_sem.rtmutex.owner = current;

?


On 04/30, Oleg Nesterov wrote:
>
> Sorry, I don't understand...
> 
> On 04/30, Peter Zijlstra wrote:
> >
> > Thaw then does the reverse, frobs lockdep
> 
> Yes, in particular it does
> 
> 	lockdep_sb_freeze_acquire()
> 		percpu_rwsem_acquire()
> 			sem->rw_sem.owner = current;
> 
> 	
> > and then does: percpu_up_write().
> >
> > percpu_up_write() on up_write(). And note how __up_write() has:
> >
> > 	DEBUG_RWSEMS_WARN_ON(sem->owner != current, sem);
> 
> and everything looks correct, sem->owner == current by the time
> thaw_super_locked() does percpu_up_write/up_write.
> 
> Oleg.

