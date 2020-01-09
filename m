Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E95135B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 15:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgAIO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 09:28:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54491 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgAIO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:28:05 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipYn2-000430-W9; Thu, 09 Jan 2020 15:28:01 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A89381060CF; Thu,  9 Jan 2020 15:28:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v2 2/2] clocksource: Add driver for the Ingenic JZ47xx OST
In-Reply-To: <20200107010630.954648-2-paul@crapouillou.net>
References: <20200107010630.954648-1-paul@crapouillou.net> <20200107010630.954648-2-paul@crapouillou.net>
Date:   Thu, 09 Jan 2020 15:28:00 +0100
Message-ID: <87a76wln67.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Cercueil <paul@crapouillou.net> writes:
> +static u64 notrace ingenic_ost_clocksource_read64(struct clocksource *cs)
> +{
> +	u32 val1, val2;
> +	u64 count, recount;
> +	s64 diff;
> +
> +	/*
> +	 * The buffering of the upper 32 bits of the timer prevents wrong
> +	 * results from the bottom 32 bits overflowing due to the timer ticking
> +	 * along. However, it does not prevent wrong results from simultaneous
> +	 * reads of the timer, which could reset the buffer mid-read.
> +	 * Since this kind of wrong read can happen only when the bottom bits
> +	 * overflow, there will be minutes between wrong reads, so if we read
> +	 * twice in succession, at least one of the reads will be correct.
> +	 */
> +
> +	/* Bypass the regmap here as we must return as soon as possible */

I have a hard time to understand this comment. "Bypass the regmap ..."
and then use a regmap function?

> +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val1);
> +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTHBUF, &val2);
> +	count = (u64)val1 | (u64)val2 << 32;
> +
> +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val1);
> +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTHBUF, &val2);
> +	recount = (u64)val1 | (u64)val2 << 32;
> +
> +	/*
> +	 * A wrong read will produce a result that is 1<<32 too high: the bottom
> +	 * part from before overflow and the upper part from after overflow.
> +	 * Therefore, the lower value of the two reads is the correct value.
> +	 */
> +
> +	diff = (s64)(recount - count);
> +	if (unlikely(diff < 0))
> +		count = recount;

Is this really the right approach here? What is the 64bit readout buying
you?

The timekeeping code can handle a 32bit counter perfectly fine and the
only advantage you get is that your maximum possible idle time will be
longer with a 64bit counter.

But is that really worth the overhead of four MMIO reads versus one in a
hotpath?

Thanks,

        tglx
