Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0946C14F375
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 21:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgAaUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 15:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgAaUxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:53:38 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36830214D8;
        Fri, 31 Jan 2020 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580504018;
        bh=NBP1g8bjhdd63aJ13vl8IHf8v729pDdk7CdirgovPsM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e/fkGi+QU08bmM8sjux3PfJDZRCUIM9g+cKNrclPySmr4CnLvxhhHJtQkafcB+J1e
         GkJtg7WdcB9rvy8XH6jSkUrvSauwpLq/uvX5pmMcLfk/ak6EppaGVT0YPlQsl0oC90
         ZFkZG/M2uvmmLaKlWRXRCmXDm1dIfAWUdyMAQQQw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C9BF03522722; Fri, 31 Jan 2020 12:53:37 -0800 (PST)
Date:   Fri, 31 Jan 2020 12:53:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131205337.GU2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:52:46AM -0800, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> 
> > This is nice, now with have data_race()
> >
> > Remember these patches were sent 2 months ago, at a time we were
> > trying to sort out things.
> >
> > data_race() was merged a few days ago.
> 
> Well, actually data_race() is not there yet anyway.
> 
> Is it really scheduled for 5.7 kernel ?

Right now, yes.  Would it make sense to separate it out and push it
into the current merge window?

							Thanx, Paul
