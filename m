Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72E64688
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 14:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGJMyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 08:54:05 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:49022
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbfGJMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:54:05 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 478B5216E4;
        Wed, 10 Jul 2019 12:54:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jul 2019 14:54:03 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
In-Reply-To: <4b43316c-3e05-0ce9-3ada-db22996205b9@metux.net>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
 <4b43316c-3e05-0ce9-3ada-db22996205b9@metux.net>
Message-ID: <cc5bbcd7148ece53a075948f240bc66b@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-08 21:45, Enrico Weigelt, metux IT consult wrote:
> On 04.07.19 15:39, Andy Shevchenko wrote:
>> On Thu, Jul 4, 2019 at 12:02 PM Florian Eckert <fe@dev.tdt.de> wrote:
>>> 
>>> This patchset adds the following changes to this pcengines-apuv2
>>> platform device.
>>> 
>> 
>> Before doing anything to this driver, what is the plan for previously
>> upstreamed:
>> 
>> drivers/leds/leds-apu.c
> 
> Only supports the three front LEDs, nothing else. (we've got more gpios
> that are not LEDs, eg. the front button, simsw, ...)
> 
>> arch/x86/platform/geode/alix.c
> 
> completely unrelated - very different chipset.
> 
> 
> --mtx

I'm going to sum it all what we have

ALIX family boards (https://www.pcengines.ch/alix.htm):
CPU -> AMD Geode LX CPU
Stays as it is different because it has a different CPU

APU family boards (https://www.pcengines.ch/apu.htm):
CPU -> AMD G series T40E APU
Remove the related APU2 family stuff from the LEDs driver
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-apu.c
this will be handled in the future by the platform device
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/pcengines-apuv2.c
The other GPIOs are not supported by this platform. Only LEDs are 
supported for now.

APU2 family boards (https://www.pcengines.ch/apu2.htm):
CPU -> AMD Embedded G series GX-412TC
Add the additional mpcie reset pins and add additional board 
descriptions to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/pcengines-apuv2.c?h=v5.2#n61
so we can distinguish between the APU2,APU3 and APU4 boards of the APU2 
board family.

My research in the pcengines documentation shows the following GPIO pins 
for the individual boards which we can support.

APU2:
front-led1
front-led2
front-led3
front-button
mpcie2_reset
mpcie3_reset

APU3:
front-led1
front-led2
front-led3
front-button
mpcie2_reset
mpcie3_reset
simswap

APU4:
front-led1
front-led2
front-led3
front-button
mpcie2_reset
mpcie3_reset

Until now we support aAPU2 and APU3 and treat it the same way. But the 
APU2 does not have a simswap.

Kind regards

Florian
