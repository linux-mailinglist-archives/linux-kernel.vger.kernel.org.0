Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0897B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfHUNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 09:49:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:49:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Qzi-0005Rm-Av; Wed, 21 Aug 2019 15:49:46 +0200
Date:   Wed, 21 Aug 2019 15:49:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, maz@kernel.org, rostedt@goodmis.org
Subject: Re: [RT PATCH 2/3] hrtimer: Don't grab the expiry lock for non-soft
 hrtimer
Message-ID: <20190821134946.iyzfxv63mvhhqxox@linutronix.de>
References: <20190821092409.13225-1-julien.grall@arm.com>
 <20190821092409.13225-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821092409.13225-3-julien.grall@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-21 10:24:08 [+0100], Julien Grall wrote:
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index b869e816e96a..119414a2f59c 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -934,7 +934,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
>  {
>  	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
>  
> -	if (base && base->cpu_base) {
> +	if (timer->is_soft && base && base->cpu_base) {
>  		spin_lock(&base->cpu_base->softirq_expiry_lock);
>  		spin_unlock(&base->cpu_base->softirq_expiry_lock);
>  	}

right, much simpler.

Sebastian
