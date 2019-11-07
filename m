Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0938BF3482
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbfKGQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:17:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40682 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfKGQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:17:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id z16so2475270qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 08:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dYr8Ef7OO1iYcDeJZqmz3VmJ1srDKDk+GdYU413QJIM=;
        b=LAZfAqjyttXKDwvNjlLDkyz5fKssu6YWtD4+TSlMKp5YrXocv8Ji5kwH8zsD/oWmaX
         473AujMn+heQeEseTj9E/ZqSheKbh4HXjudOaXP40dxUvxsj9OJH/MKaGts8KbZ8MNoj
         u0Ez15D5dFA4kcJN/7Jnhv3TLfER/qBDsVFHgJ8l5ORvgp657Dn8z0DpS6tYTX4Y1T4M
         Pbt/F39lC5OoW+CvVpT+9eEEwjm3vyvLbyIH5NShrSKj/AnqYVBC696IdHLrz1DyWz8x
         KAjxKpqIclHjsww2JZQFyzv5FQDVYQRn8urIbc8mHs9lIBuLmYE801Moc5FpiA7bRtfo
         kn0A==
X-Gm-Message-State: APjAAAW1n2p4yqYIsxEiBb4sYXvgs2FZrz2/K6GnXZwWAivIj0w3dGfM
        4oHs/l8COBxraiXtPMuXsps=
X-Google-Smtp-Source: APXvYqx1F/o7sNloPWfDkD0XSyduNgGg7EOKBPlZhFqT8m3ZXetXdTmgbx0U6dTrcVt62WgKSoM7Og==
X-Received: by 2002:a37:9bc2:: with SMTP id d185mr3432827qke.299.1573143472238;
        Thu, 07 Nov 2019 08:17:52 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::3:db5f])
        by smtp.gmail.com with ESMTPSA id j71sm1576484qke.90.2019.11.07.08.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:17:51 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:17:49 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191107161749.GA93945@dennisz-mbp>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107091319.6zf5tmdi54amtann@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:13:19AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-10-02 13:22:53 [+0200], To linux-kernel@vger.kernel.org wrote:
> > This is a revert of commit
> >    a4244454df129 ("percpu-refcount: use RCU-sched insted of normal RCU")
> > 
> > which claims the only reason for using RCU-sched is
> >    "rcu_read_[un]lock() … are slightly more expensive than preempt_disable/enable()"
> > 
> > and
> >     "As the RCU critical sections are extremely short, using sched-RCU
> >     shouldn't have any latency implications."
> > 
> > The problem with using RCU-sched here is that it disables preemption and
> > the callback must not acquire any sleeping locks like spinlock_t on
> > PREEMPT_RT which is the case with some of the users.
> > 
> > Using rcu_read_lock() on PREEMPTION=n kernels is not any different
> > compared to rcu_read_lock_sched(). On PREEMPTION=y kernels there are
> > already performance issues due to additional preemption points.
> > Looking at the code, the rcu_read_lock() is just an increment and unlock
> > is almost just a decrement unless there is something special to do. Both
> > are functions while disabling preemption is inlined.
> > Doing a small benchmark, the minimal amount of time required was mostly
> > the same. The average time required was higher due to the higher MAX
> > value (which could be preemption). With DEBUG_PREEMPT=y it is
> > rcu_read_lock_sched() that takes a little longer due to the additional
> > debug code.
> > 
> > Convert back to normal RCU.
> 
> a gentle ping.
> 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > 
> > Benchmark https://breakpoint.cc/percpu_test.patch
> 
> 
> Sebastian

Hello,

I just want to clarify a little bit. Is this patch aimed at fixing an
issue with RT kernels specifically? It'd also be nice to have the
numbers as well as if the kernel was RT or non-RT.

Thanks,
Dennis
