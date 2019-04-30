Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45941FB82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfD3O3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:29:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3O3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H4+KAPmjx58DIhwVOO8DsRJgwzL0afbdwEtz43iN/Dw=; b=qeO0cllVcOA1oaf4HAuMfdckj
        RhFwPVYQGDmsZMoFiuGNTaPt8hExZGUfXOVhRnw8/zlURThnFPBTtWt5mOOXPYbSfTLIQJn4aW9Qe
        T0eL5b6B3mFexBBD3j97bCKiumW6TnRblkqCsJPhVr972iJXUUxIArSb7OS8sSpr3Whe4gZyVYDDs
        JRNjh4TAkjvvlg3/FuYPsV8+JSqtyufQCyoMR2gP5h/TBNy/02iyCVOsEYKNDuJpj7iH03oK85KWi
        AFSd4bpfLifmlNvRSG0Z/LxbfrrT8NS3MYhdjKi9AsNGxMKxobuAsT40q1IQ7odBi04Fh2xXXi2/Q
        i5gUL2gLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLTlY-00087M-Cx; Tue, 30 Apr 2019 14:29:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CFBA29D226A0; Tue, 30 Apr 2019 16:29:50 +0200 (CEST)
Date:   Tue, 30 Apr 2019 16:29:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, jack@suse.com
Subject: Re: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=
 current) with fsfreeze (4.19.25-rt16)
Message-ID: <20190430142950.GG2589@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190430141500.GE23020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430141500.GE23020@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:15:01PM +0200, Oleg Nesterov wrote:
> Sorry, I don't understand...

So the problem is that on -RT rwsem uses PI mutexes, and the below just
cannot work.

Also see:

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/include/linux/rwsem_rt.h?h=linux-5.0.y-rt
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/locking/rwsem-rt.c?h=linux-5.0.y-rt

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

Oh ARGGH, I missed that. This is horrible :-(

