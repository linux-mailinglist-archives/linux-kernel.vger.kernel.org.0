Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F711530A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgBEM1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 07:27:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgBEM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:27:15 -0500
Received: from [212.187.182.163] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1izJlv-0000rV-UT; Wed, 05 Feb 2020 13:27:12 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 52BC0100C31; Wed,  5 Feb 2020 12:27:06 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH] genirq: Clarify that irq wake state is orthogonal to enable/disable
In-Reply-To: <20200205060953.49167-1-swboyd@chromium.org>
References: <20200205060953.49167-1-swboyd@chromium.org>
Date:   Wed, 05 Feb 2020 12:27:06 +0000
Message-ID: <87zhdxrzhh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <swboyd@chromium.org> writes:
> There's some confusion around if an irq that's disabled with
> disable_irq() can still wake the system from sleep states such as
> "suspend to RAM". Let's clarify this in the kernel documentation for
> irq_set_irq_wake() so that it's clear that an irq can be disabled and
> still wake the system if it has been marked for wakeup.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/irq/manage.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 818b2802d3e7..fa8db98c8699 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -731,6 +731,11 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
>   *
>   *	Wakeup mode lets this IRQ wake the system from sleep
>   *	states like "suspend to RAM".
> + *
> + *	Note: irq enable/disable state is completely orthogonal
> + *	to the enable/disable state of irq wake. An irq can be
> + *	disabled with disable_irq() and still wake the system as
> + *	long as the irq has wake enabled.

It clearly should say that this is really depending on the hardware
implementation of the particual interrupt chip whether disabled + wake
mode is supported.

Thanks,

        tglx
