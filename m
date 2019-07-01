Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A832FBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfD3OpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:45:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3OpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2zy5WWZhUu1HKZQxhEtm3bI8rt8uWeTC5jpNqHHiLhc=; b=BO36wZjt/Xs3KDdltNWtWIRFu
        RWyGaCRcX78PcToiXOHA4rsfeDot/37zU5kXTBPEX7gHyeylUJsA+4A2f4AhlGTZ4CJ0y1OnykDl3
        8+Pqz3vcDvF6A0mgfks9Ck0jdBsdNvSyBIMzBguvgNa3IylP633sYKcpUzxLKiY7NL8vmmMkSK3JF
        7HUVFKN6yPGHP/kALsApiQ8aymr7HIRjbpp5lTX02nNAitp5r7eqXaFnW+yWgOyTd19Oqk+LGmuv3
        q+91sbldcJ1FBqKDQAip9k77LHFVV33QIvhTTzgx2rKdDZrM72X1oA7z6bh4WVqVBS2eFiWc5oqT9
        KWzXYV4RA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLU0B-0001gt-4y; Tue, 30 Apr 2019 14:44:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5887236F9E80; Tue, 30 Apr 2019 16:44:57 +0200 (CEST)
Date:   Tue, 30 Apr 2019 16:44:57 +0200
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
Message-ID: <20190430144457.GJ2589@hirez.programming.kicks-ass.net>
References: <20190326093421.GA29508@localhost.localdomain>
 <20190419085627.GI4742@localhost.localdomain>
 <20190430125130.uw7mhdnsoqr2v3gf@linutronix.de>
 <20190430132811.GB2589@hirez.programming.kicks-ass.net>
 <20190430141500.GE23020@redhat.com>
 <20190430144252.GF23020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430144252.GF23020@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:42:53PM +0200, Oleg Nesterov wrote:
> I have cloned linux-rt-devel.git
> 
> If I understand correctly, in rt rw_semaphore is actually defined in rwsem_rt.h
> so percpu_rwsem_acquire() should probably do
> 
> 	sem->rw_sem.rtmutex.owner = current;

That'll screw the PI chain (if there is one), right?
