Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9C961C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfHTN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 09:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbfHTN7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:59:46 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01C7222CF7;
        Tue, 20 Aug 2019 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566309585;
        bh=bAynDim84lDLAbPR8oVISI3huZG6jDYYkBU1KNFVZmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaYeB/mmrMPLlxJrlPyhWMkJ94J0yILg1L2bQDKoCOwsPnHxdmkOG6VdDWqAqfsQo
         KoIh5LOM9mBxFhQrqylk7lCue6X6IDLFIXqrUn/R9Dtb99PmmAsvm1dh1qViu5eqbj
         y2xYuaiteDzJMw1xptrK+aysF0CCWP7E4UySl7ds=
Date:   Tue, 20 Aug 2019 15:59:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 03/44] posix-timer: Use a callback for cancel
 synchronization
Message-ID: <20190820135942.GF2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.656864506@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.656864506@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:44PM +0200, Thomas Gleixner wrote:
> -static struct k_itimer *timer_wait_running(struct k_itimer *timer,
> -					   unsigned long *flags)
> -{
> -	timer_t timer_id = READ_ONCE(timer->it_id);
> +	if (!WARN_ON_ONCE(kc->timer_wait_running))
> +		kc->timer_wait_running(timer);

With the fix after Christoph pinpoint:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
