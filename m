Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC31534A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 16:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBEPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 10:53:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBEPxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:53:06 -0500
Received: from [212.187.182.165] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1izMz8-0004hJ-2L; Wed, 05 Feb 2020 16:53:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8BAD0100C31; Wed,  5 Feb 2020 15:52:56 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH] genirq: Clarify that irq wake state is orthogonal to enable/disable
In-Reply-To: <20200205153410.GA3898@codeaurora.org>
References: <20200205060953.49167-1-swboyd@chromium.org> <87zhdxrzhh.fsf@nanos.tec.linutronix.de> <20200205153410.GA3898@codeaurora.org>
Date:   Wed, 05 Feb 2020 15:52:56 +0000
Message-ID: <87tv45rpyf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lina Iyer <ilina@codeaurora.org> writes:
> On Wed, Feb 05 2020 at 05:27 -0700, Thomas Gleixner wrote:
>>> @@ -731,6 +731,11 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
>>>   *
>>>   *	Wakeup mode lets this IRQ wake the system from sleep
>>>   *	states like "suspend to RAM".
>>> + *
>>> + *	Note: irq enable/disable state is completely orthogonal
>>> + *	to the enable/disable state of irq wake. An irq can be
>>> + *	disabled with disable_irq() and still wake the system as
>>> + *	long as the irq has wake enabled.
>>
>>It clearly should say that this is really depending on the hardware
>>implementation of the particual interrupt chip whether disabled + wake
>>mode is supported.
>>
> Could an irqchip flag be used to warn users that we may not wakeup from
> suspend/resume if the interrupt if the hardware does not support wakeup
> when disabled ?

There are also magic ways of wakeup for irqchips which do not have wake
setup functions and still wake the system up when the interrupt line is
disabled by the kernel on suspend. :)

Thanks,

        tglx
