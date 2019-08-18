Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52793919F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRWfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 18:35:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39660 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfHRWf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:35:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so5759530pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aoEwN5YCvSYNBJpZR2EckQTs3ZmIOpZAgC3IGRqX8bg=;
        b=MaYJInsP/PMTPaWj1vZ2QIk47Qsm6UpOUGUQPV0exg6tLDgFI32aRaJXGKRVxqk2tN
         A3jwhNK2SX655ihw0ziplM3eDB0G5dWO/x4m7xXHrNmYHRm3ADqdGNZEdor2ieOJfL6y
         MImy42ZCcO4JOp5DP1ldbWzQzHv2x0WTbTGzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aoEwN5YCvSYNBJpZR2EckQTs3ZmIOpZAgC3IGRqX8bg=;
        b=S6MG6Iy+bWVs8PSTb6hs1cjHWGjTbSYwpFJ0H1dTlYqlnLFVoReGHT6k5mEZjy+TVG
         ms8jNabU1P/Zr5Pp+HNfkckIh46o+qSn+luiwpuOcGHQExUYh6AKVgbPsPofKU1qXu0r
         1URGLE7ag7fFf1vzNChCeZgiMjboeJ86fmTSbrO7mq4B8pDuelUV7O06gMWv5/r31gBZ
         fC/cmKSkMYp1SjPQqAfJl5EhIly1L34Ie7ROkwbsH5x8Lf6o1BWJ4f5nbOj+7PFQU30j
         xnXnhJO1Kw49ATQxkvATM4KnBR78egAeffmxWBRFFavdzgorUELgKDpdFNO8rUic3V8q
         sWuw==
X-Gm-Message-State: APjAAAXU+FwM0MsorH/hBx+un0Veq5TaO8yXIiHEE/B2VeA9Z9NAMCY4
        Yug0dpIrqRsh92DieE039EUC/A==
X-Google-Smtp-Source: APXvYqzTJLti63L6/J3jxFQJ0mwzyshYe5nTokmI7xIhgpWFZGifLBAxGooTyQs80jPUrHF7K39+Cw==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr17657063pjq.64.1566167729049;
        Sun, 18 Aug 2019 15:35:29 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id ck8sm11142189pjb.25.2019.08.18.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 15:35:28 -0700 (PDT)
Date:   Sun, 18 Aug 2019 18:35:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190818223511.GB143857@google.com>
References: <20190818214948.GA134430@google.com>
 <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818223230.GA143857@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 06:32:30PM -0400, Joel Fernandes wrote:
> On Sun, Aug 18, 2019 at 03:12:10PM -0700, Paul E. McKenney wrote:
> > On Sun, Aug 18, 2019 at 05:49:48PM -0400, Joel Fernandes (Google) wrote:
> > > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > > threads when the !use_softirq parameter is passed.  This is safe
> > > to do so because:
> > > 
> > > 1. We avoid the scheduler deadlock issues thanks to the deferred_qs bit
> > > introduced in commit 23634ebc1d94 ("rcu: Check for wakeup-safe
> > > conditions in rcu_read_unlock_special()") by checking for the same in
> > > this patch.
> > > 
> > > 2. in_irq() implies in_interrupt() which implies raising softirq will
> > > not do any wake ups.
> > > 
> > > The rcuc thread which is awakened will run when the interrupt returns.
> > > 
> > > We also honor 25102de ("rcu: Only do rcu_read_unlock_special() wakeups
> > > if expedited") thus doing the rcuc awakening only when none of the
> > > following are true:
> > >   1. Critical section is blocking an expedited GP.
> > >   2. A nohz_full CPU.
> > > If neither of these cases are true (exp == false), then the "else" block
> > > will run to do the irq_work stuff.
> > > 
> > > This commit is based on a partial revert of d143b3d1cd89 ("rcu: Simplify
> > > rcu_read_unlock_special() deferred wakeups") with an additional in_irq()
> > > check added.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > OK, I will bite...  If it is safe to wake up an rcuc kthread, why
> > is it not safe to do raise_softirq()?
> 
> Because raise_softirq should not be done and/or doesn't do anything
> if use_softirq == false. In fact, RCU_SOFTIRQ doesn't even existing if
> use_softirq == false. The "else if" condition of this patch uses for
> use_softirq.
> 
> Or, did I miss your point?
> 
> > And from the nit department, looks like some whitespace damage on the
> > comments.
> 
> I will fix all of these in the change log, it was just a quick RFC I sent
> with the idea, tagged as RFC and not yet for merging. I should also remove
> the comment about " in_irq() implies in_interrupt() which implies raising
> softirq" from the changelog since this patch is only concerned with the rcuc
> kthread.

Ah, I see you mean the comments on the code. Perhaps something went wrong
when I did 'git revert' on the original patch, or some such. Anyway, please
consider this as RFC-grade only. And hopefully I have been writing better
change logs (really trying!!).

thanks,

 - Joel

