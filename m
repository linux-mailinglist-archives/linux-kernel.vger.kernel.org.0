Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58232AA670
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390059AbfIEOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfIEOse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:48:34 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F46206CD;
        Thu,  5 Sep 2019 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567694914;
        bh=kne+Sj8X9QI9UZunIV3pySjiZcGO8BjWgmU6q2bXzLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8FmjgN2igMx3q114j2trtv8EqXzLDQjAn4GUAGYXMOO03TDLi/FT5HPrrzH85/kp
         zJylTv9kFj28wR7EOMt2fm/Tgvudbtxyjq8h+fXrF1DWBMv++C56su5bQr/y+JGTJ/
         onGyTNBgT7N834BvRNKNMAYvE5HyHGph8dUZZ7Js=
Date:   Thu, 5 Sep 2019 16:48:30 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 0/6] posix-cpu-timers: Fallout fixes and permission
 tightening
Message-ID: <20190905144829.GA18251@lenoir>
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120339.561100423@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:39PM +0200, Thomas Gleixner wrote:
> Sysbot triggered an issue in the posix timer rework which was trivial to
> fix, but after running another test case I discovered that the rework broke
> the permission checks subtly. That's also a straightforward fix.
> 
> Though when staring at it I discovered that the permission checks for
> process clocks and process timers are completely bonkers. The only
> requirement is that the target PID is a group leader. Which means that any
> process can read the clocks and attach timers to any other process without
> priviledge restrictions.
> 
> That's just wrong because the clocks and timers can be used to observe
> behaviour and both reading the clocks and arming timers adds overhead and
> influences runtime performance of the target process.

Yeah I stumbled upon that by the past and found out the explanation behind
in old history: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/kernel/posix-cpu-timers.c?id=a78331f2168ef1e67b53a0f8218c70a19f0b2a4c

"This makes no constraint on who can see whose per-process clocks.  This
information is already available for the VIRT and PROF (i.e.  utime and stime)
information via /proc.  I am open to suggestions on if/how security
constraints on who can see whose clocks should be imposed."

I'm all for mitigating that, let's just hope that won't break some ABIs.
