Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D550615172D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 09:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgBDIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 03:50:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgBDIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 03:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G7VctEgtjynjEUnuDLfpYDGr0Hv8ZLxsIqD15TpfUCo=; b=Zq5jWAfcP8iBdhRld+v/tyUOK5
        U7WBl522Eps+E5fGRH+nmrfr1QPOAFcvCZuAPXDrxKromnCjIBAfQPyK/Np+VeNTli4nNnz+daXpn
        XZaPim5dM22gZkUwDQ1UUut9/lD4vvMv71hLnDZhu50osU+urNKvSl7ZlB9awR6Vqcvr9LzbBehmZ
        jXOeqogfDKDlcAxqNFdIPdgUsL3yFrQvKioCqYLwi3AseOnTJ4mZ7c+qptkgrE7tWJ4vMtBvbtg61
        QJ1asyRpWiFynrCq44kDEJsSh7G0iPIK9Y9DkbJQpGEh6qrjQJyXywFfN76b2wE5iqJvM2+ooTaXM
        er8OD8LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iytv1-0003oE-TA; Tue, 04 Feb 2020 08:50:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D39A830257C;
        Tue,  4 Feb 2020 09:49:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FF222024714B; Tue,  4 Feb 2020 09:50:49 +0100 (CET)
Date:   Tue, 4 Feb 2020 09:50:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, dave@stgolabs.net,
        jack@suse.com
Subject: Re: [PATCH -v2 5/7] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20200204085049.GN14914@hirez.programming.kicks-ass.net>
References: <20200131150703.194229898@infradead.org>
 <20200131151540.155211856@infradead.org>
 <20200203142050.GA28595@infradead.org>
 <20200203150933.GJ14914@hirez.programming.kicks-ass.net>
 <20200203174831.GA9834@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203174831.GA9834@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 09:48:31AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 04:09:33PM +0100, Peter Zijlstra wrote:
> > > Can you split the removal of the non-owned resem support into a separate
> > > patch?  I still think keeping this one and moving aio to that scheme is
> > > a better idea than the current ad-hoc locking scheme that has all kinds
> > > of issues.
> > 
> > That's basically 2 lines of code and a comment, surely we can ressurect
> > that if/when it's needed again?
> 
> Sure, I could.  But then you'd still need to update your commit log for
> this patch explaining why it includes unrelated changes to a different
> subsystem.  By splitting it you also document your changes much better.

I really don't see the argument; the diffstat is:

include/linux/percpu-rwsem.h  |   19 +----
include/linux/rwsem.h         |    6 -
include/linux/wait.h          |    1
kernel/locking/percpu-rwsem.c |  153 ++++++++++++++++++++++++++++++------------
kernel/locking/rwsem.c        |   11 +--
kernel/locking/rwsem.h        |   12 ---

There is no unrelated subsystem, it's all locking (well, strictly
speaking wait.h is sched, bit that one flag is actually mentioned in the
Changelog).

Also, cleaning up unused bits is quite common without mention.

Anyway, I'll go split, since you seem to care so deeply.
