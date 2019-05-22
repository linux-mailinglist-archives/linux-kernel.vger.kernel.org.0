Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7309A263A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfEVMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 08:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbfEVMSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:18:45 -0400
Received: from localhost (nat-wifi.sssup.it [193.205.81.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4884720675;
        Wed, 22 May 2019 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558527524;
        bh=g0eOSIXfr8IqQPHDtIRp5YL6vsV04XFKB2hhTN7Xi+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGAMOLic2odT6wT3WuzxKj2B929gvYWY1lK0XSCS/v4LdhDNgC6wCog7z1V54GOuF
         eqttToPTDxuhuLQiAg1ba28FAOWsshzugxvsr9Skc6TORfeSUuHwGoNdUfBNpJ8BzX
         Z69HTkUZCmgSmMIeJyEk7yVxoONqBshhK/imaiss=
Date:   Wed, 22 May 2019 14:18:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tick/sched: Drop duplicated tick_sched.inidle
Message-ID: <20190522121837.GA11692@lerouge>
References: <20190522032906.11963-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522032906.11963-1-peterx@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:29:06AM +0800, Peter Xu wrote:
> It is set before entering idle and cleared when quitting idle, though
> it seems to be a complete duplicate of tick_sched.idle_active.  We
> should probably be able to use any one of them to replace the other.

Not exactly.

@inidle is set on idle entry and cleared on idle exit.
@idle_active is the same but it's cleared during idle interrupts
so that idle_sleeptime only account real idle time.

And note below:

> @@ -1017,7 +1015,7 @@ void tick_nohz_irq_exit(void)
>  {
>  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>  
> -	if (ts->inidle)
> +	if (ts->idle_active)
>  		tick_nohz_start_idle(ts);

idle_active will always be cleared here from tick_nohz_irq_enter().
We actually want to conditionally set it again depending on the inidle value.

Thanks.
