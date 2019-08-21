Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8F978DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfHUMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 08:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHUMJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:09:21 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33ED22CE3;
        Wed, 21 Aug 2019 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566389360;
        bh=0VzLeFR/PHh6E07hYxzyNL353yYnSiOtYQCAFycHbos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcQKw+Upz+WhAGg2QhszMT8QfHA0UnF9DTR5wJrUpnQrgV2BPwNGTtVXMhaIk3C8f
         wUaOH+upi7Gh5uZX8l28i7+kG5JGt5bjWfMAK/xp5El2wSdj2BImZJopQGHoMln59O
         xiptaYql5MFQVt3hjT9peYdz6wMxgePdyTy9l3SE=
Date:   Wed, 21 Aug 2019 14:09:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 07/44] posix-cpu-timers: Simplify sighand locking in
 run_posix_cpu_timers()
Message-ID: <20190821120912.GD16213@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143802.038794711@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143802.038794711@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:48PM +0200, Thomas Gleixner wrote:
> run_posix_cpu_timers() is called from the timer interrupt. The posix timer
> expiry always affects the current task which got interrupted.
> 
> sighand locking is only racy when done on a foreign task, which must use
> lock_task_sighand(). But in case of run_posix_cpu_timers() that's
> pointless.
> 
> sighand of a task can only be dropped or changed by the task itself. Drop
> happens in do_exit()

Well, that's only in case of autoreap. Otherwise this is dropped by the reaper.

> changing sighand happens in execve().
