Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDED6AA7AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 17:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfIEPtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 11:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfIEPti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:49:38 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9170B207E0;
        Thu,  5 Sep 2019 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567698579;
        bh=iMrS/nUhZ8F4QRdjjg01pbG5GSUDgmtiTEDKYuGANLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGBC5DFgWQvXqPsXRzKukEJ483yZR7k4SslsvwPLtfgHMVNC+6aS2O7OFrCNJo09a
         GYGaM2+t85RnRB1r2PXcDAF6slIq11ey8LS+axkKwiCYUKucTz/d/v6uhdTiP4UKcr
         M2X4HuSSqKGug5QWWuirPD76jpq75lzocXKxxOjs=
Date:   Thu, 5 Sep 2019 17:49:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        syzbot+55acd54b57bb4b3840a4@syzkaller.appspotmail.com
Subject: Re: [patch 1/6] posix-cpu-timers: Always clear head pointer on
 dequeue
Message-ID: <20190905154934.GD18251@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905120539.707986830@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120539.707986830@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:40PM +0200, Thomas Gleixner wrote:
> The head pointer in struct cpu_timer is checked to be NULL in
> posix_cpu_timer_del() when the delete raced with the exit cleanup. The
> works correctly as long as the timer is actually dequeued via
> posix_cpu_timers_exit*().
> 
> But if the timer was dequeued due to expiry the head pointer is still set
> and triggers the warning.
> 
> In fact keeping the head pointer around after any dequeue is pointless as
> is has no meaning at all after that.
> 
> Clear the head pointer always on dequeue and remove the unused requeue
> function while at it.
> 
> Fixes: 60bda037f1dd ("posix-cpu-timers: Utilize timerqueue for storage")
> Reported-by: syzbot+55acd54b57bb4b3840a4@syzkaller.appspotmail.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
