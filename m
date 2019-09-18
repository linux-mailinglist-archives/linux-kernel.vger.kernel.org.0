Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D190B5901
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 02:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfIRA3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 20:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfIRA3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:29:02 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74853206C2;
        Wed, 18 Sep 2019 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568766541;
        bh=T1vZ64yFYW2tBPWkjR/Vu9fKABb6k0MlyadDJVmjL0g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xvDvFEJBtBO7rv7BOMIsnIV/Uos60+G3VfPSHNyNJ5yECobY4ZZ8Lp6BkZayj753H
         j4cgFyZpVKZmS9eVsNH4su2U4PJGaTeOj8raHNNcT1HJtYBSVLe4PdZ6AxnBOZbzWu
         AOb9YhxLEi/v7HAUt02Izwug0auJtnFL6ZHaBFCE=
Date:   Tue, 17 Sep 2019 17:28:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: Make print_lock() address visible
Message-ID: <20190918002859.GF30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190917013946.9EC51C60479@www.outflux.net>
 <201909162006.3138C81AE0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909162006.3138C81AE0@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 08:07:55PM -0700, Kees Cook wrote:
> On Mon, Sep 16, 2019 at 06:39:46PM -0700, keescook@chromium.org wrote:
> > commit 519248f36d6f3c80e176f6fa844c10d94f1f5990
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Thu May 30 05:39:25 2019 -0700
> > 
> >     lockdep: Make print_lock() address visible
> >     
> >     Security is a wonderful thing, but so is the ability to debug based on
> >     lockdep warnings.  This commit therefore makes lockdep lock addresses
> >     visible in the clear.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 4861cf8e274b..4aca3f4379d2 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -620,7 +620,7 @@ static void print_lock(struct held_lock *hlock)
> >  		return;
> >  	}
> >  
> > -	printk(KERN_CONT "%p", hlock->instance);
> > +	printk(KERN_CONT "%px", hlock->instance);
> >  	print_lock_name(lock);
> >  	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
> >  }
> 
> Just to clarify: this is only visible under CONFIG_LOCKDEP, yes? That's
> not a state anyone would run a production system under, I'd hope.

Yes, by my reading of kernel/locking/Makefile, the entire
kernel/locking/lockdep.c file is completely ignored unless
CONFIG_LOCKDEP=y.

So yes, it would be silly for this code to be in a production
system.

							Thanx, Paul
