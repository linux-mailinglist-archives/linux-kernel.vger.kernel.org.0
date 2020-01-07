Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5B13272D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgAGNJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:09:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgAGNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ldmliGj77Bk3OVBj9ERxJRO2ubWIHjpdcz6AoITqvp0=; b=jj1iEWw24sTXo/D0Mh2CfthJN
        GT12pVWKqZnm/w288YM76uZfrCuqW86k7ylN7c3P1uSVcez0cHu9cBPUejMb8W5/2q5F89ayIsaeG
        CH4TZRUn6b8L8gcVNsnpcfcUb50aHxve+/FnmfE33g8FoYMfGag2tTClFAHEEOIoXBfkPVQ+pDXXt
        nOA9wnLSoCAQwk7+VxpoQXA8rqE1pyd7PB10j1MlFNeOqQzCb7rJLANpxwTck4TQJobHc9Yc6xcar
        aaV7kzztv88ewDtRG2v9tWEDFsvKlNM552GSM/NUhIBUpnr41/Wu2VI+RU8MHdzhYDbHrOajqQPGB
        Cqesm/gvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iooc9-0003DI-4k; Tue, 07 Jan 2020 13:09:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FF74305EDF;
        Tue,  7 Jan 2020 14:08:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2967220D3D423; Tue,  7 Jan 2020 14:09:39 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:09:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] locking/qspinlock: Fix inaccessible URL of MCS lock paper
Message-ID: <20200107130939.GV2871@hirez.programming.kicks-ass.net>
References: <20191223022532.14864-1-longman@redhat.com>
 <20200107125824.GA2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107125824.GA2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 01:58:24PM +0100, Peter Zijlstra wrote:
> On Sun, Dec 22, 2019 at 09:25:32PM -0500, Waiman Long wrote:
> > It turns out that the URL of the MCS lock paper listed in the source
> > code is no longer accessible. I did got question about where the paper
> > was. This patch updates the URL to one that is still accessible.
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  kernel/locking/qspinlock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index 2473f10c6956..1d008d2333c0 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -34,7 +34,7 @@
> >   * MCS lock. The paper below provides a good description for this kind
> >   * of lock.
> >   *
> > - * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
> > + * https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
> 
> Do we want to stick a copy of the paper in our bugzilla and link that
> instead? ISTR we do something similar elsewhere, but I'm having trouble
> finding it.
> 
> Thomas, Konstantin?

Boris provided an example from commit:

  018ebca8bd70 ("x86/cpufeatures: Enable a new AVX512 CPU feature")

That puts a copy of the relevant Intel document here:

  https://bugzilla.kernel.org/show_bug.cgi?id=204215
