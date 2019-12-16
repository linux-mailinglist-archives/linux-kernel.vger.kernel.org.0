Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3243A11F1A2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 12:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLNLxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 06:53:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40780 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfLNLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:53:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3AA43289F5A
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Use
 platform_get_irq_optional() for optional IRQs
To:     Guenter Roeck <groeck@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
References: <20191129102254.7910-1-enric.balletbo@collabora.com>
 <CABXOdTd8b+Lshh_Kf2fjeErrAyQcgZVgLNx3_cpW42Dh8YCN=Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f2139eca-6561-a353-576f-cf6c53e5441f@collabora.com>
Date:   Sat, 14 Dec 2019 12:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABXOdTd8b+Lshh_Kf2fjeErrAyQcgZVgLNx3_cpW42Dh8YCN=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/11/19 16:56, Guenter Roeck wrote:
> On Fri, Nov 29, 2019 at 2:23 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> As platform_get_irq() now prints an error when the interrupt does not
>> exist, use platform_get_irq_optional() to get the IRQ which is optional
>> to avoid below error message during probe:
>>
>>   [    5.113502] cros_ec_lpcs GOOG0004:00: IRQ index 0 not found
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 

Queued for 5.6.

>> ---
>>
>>  drivers/platform/chrome/cros_ec_lpc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
>> index dccf479c6625..ffdea7c347f2 100644
>> --- a/drivers/platform/chrome/cros_ec_lpc.c
>> +++ b/drivers/platform/chrome/cros_ec_lpc.c
>> @@ -396,7 +396,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>>          * Some boards do not have an IRQ allotted for cros_ec_lpc,
>>          * which makes ENXIO an expected (and safe) scenario.
>>          */
>> -       irq = platform_get_irq(pdev, 0);
>> +       irq = platform_get_irq_optional(pdev, 0);
>>         if (irq > 0)
>>                 ec_dev->irq = irq;
>>         else if (irq != -ENXIO) {
>> --
>> 2.20.1
>>
> 
