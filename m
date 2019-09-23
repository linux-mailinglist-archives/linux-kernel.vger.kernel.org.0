Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB9BB58E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfIWNjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 09:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfIWNjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:39:09 -0400
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F6620665;
        Mon, 23 Sep 2019 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569245949;
        bh=4GEfq3JhuMfGHV5M0hAP5cCNaZf454EFmB/QpMYGM1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ao143w6qjRfY1omRLTI6NrnCGq8uvV9f+H2Lc/SOh6V8qLa1MUwmlx2GwPRehZArv
         RXJeTGqRLSWmxqPf5SzDiTZLlH4k8qDxbsYgY3kwJZxZ+ybt+XJ9dnDQmjEwvWtkBK
         xxgIdkj+5vLOLEUwbn4rYxOM7EzoxG+iZ57eSnLA=
Date:   Mon, 23 Sep 2019 15:39:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 4/6] posix-cpu-timers: Restrict clock_gettime()
 permissions
Message-ID: <20190923133718.GA32669@lenoir>
References: <20190905120339.561100423@linutronix.de>
 <20190905120539.978233418@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120539.978233418@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:43PM +0200, Thomas Gleixner wrote:
> Similar to creating timers on a process there is no restriction at all to
> read the Posix CPU clocks of any process in the system. Per thread CPU
> clock access is limited to threads in the same thread group.
> 
> The per process CPU clocks can be used to observe activity of tasks and
> reading them can affect the execution of the process to which they are
> attached as reading can require to lock sighand lock and sum up the fine
> grained accounting for all threads in the process.
> 
> Restrict it by checking ptrace MODE_READ permissions of the reader on the
> target process.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
