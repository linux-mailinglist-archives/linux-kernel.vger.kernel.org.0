Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF973CDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfFKODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:03:03 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:18060 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbfFKODC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:03:02 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 77BF551380;
        Tue, 11 Jun 2019 16:03:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id paOZoJQ0fFI0; Tue, 11 Jun 2019 16:02:56 +0200 (CEST)
Subject: Re: [PATCH 2/2 v5] tty/serial/8250: use mctrl_gpio helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190611105603.4435-1-sr@denx.de>
 <20190611105603.4435-2-sr@denx.de> <20190611124415.GT9224@smile.fi.intel.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <85f0d39c-e5d8-320b-e611-d956630a629f@denx.de>
Date:   Tue, 11 Jun 2019 16:02:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190611124415.GT9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.19 14:44, Andy Shevchenko wrote:
> On Tue, Jun 11, 2019 at 12:56:03PM +0200, Stefan Roese wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This patch permits the usage for GPIOs to control
>> the CTS/RTS/DTR/DSR/DCD/RI signals.
> 
>>   static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
>>   {
>>   	serial_out(up, UART_MCR, value);
>> +
>> +	if (up->gpios) {
>> +		int mctrl_gpio = 0;
>> +
>> +		if (value & UART_MCR_RTS)
>> +			mctrl_gpio |= TIOCM_RTS;
>> +		if (value & UART_MCR_DTR)
>> +			mctrl_gpio |= TIOCM_DTR;
>> +
>> +		mctrl_gpio_set(up->gpios, mctrl_gpio);
>> +	}
>>   }
>>   
>>   static inline int serial8250_in_MCR(struct uart_8250_port *up)
>>   {
>> -	return serial_in(up, UART_MCR);
>> +	int mctrl;
>> +
>> +	mctrl = serial_in(up, UART_MCR);
>> +
>> +	if (up->gpios) {
>> +		int mctrl_gpio = 0;
>> +
>> +		/* save current MCR values */
>> +		if (mctrl & UART_MCR_RTS)
>> +			mctrl_gpio |= TIOCM_RTS;
>> +		if (mctrl & UART_MCR_DTR)
>> +			mctrl_gpio |= TIOCM_DTR;
>> +
>> +		mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
>> +		if (mctrl_gpio & TIOCM_RTS)
>> +			mctrl |= UART_MCR_RTS;
>> +		else
>> +			mctrl &= ~UART_MCR_RTS;
>> +
>> +		if (mctrl_gpio & TIOCM_DTR)
>> +			mctrl |= UART_MCR_DTR;
>> +		else
>> +			mctrl &= ~UART_MCR_DTR;
>> +	}
>> +
>> +	return mctrl;
>>   }
> 
> These are using OR logic with potentially volatile data. Shouldn't we mask
> unused bits in UART_MCR in case of up->gpios != NULL?

Sorry, I don't see, which bits you are referring to? Could you please be
a bit more specific with the variable / macro meant (example)?
  
>> +	if (up->gpios == 0)
> 
> This is type inconsistency with this check as far as I understand.
> I guess you have to do either (up->gpios == NULL), or (!up->gpios).

Ah, right. Thanks for spotting.

Thanks,
Stefan
