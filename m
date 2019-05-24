Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 593D5297E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391497AbfEXMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 08:17:37 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:49762 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391465AbfEXMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:17:37 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 08:17:35 EDT
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 40252B014C0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 14:09:16 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1558699755; x=1559563756; bh=8zfBt/DHoA9altCnYmg1awpFAXKb2Mxggpk
        GeiE/K20=; b=jxTV+ZGurVcKwV0GxpY+YOkA+euNmp+XEVSHnXIWYPv53JEPzsi
        2b3C5WDOvlUm8s84GTK4Z5IcucxdSpKNLzynSX08Ufbonpye3zlUFdYRxIqMMg9Y
        hnxYAeGt3X+CnhneRyu1Qb47Ds+PyxaIShfJvcQNl/mQUcvLfphgS45g=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P7ak0tdWEcQq for <linux-kernel@vger.kernel.org>;
        Fri, 24 May 2019 14:09:15 +0200 (CEST)
Received: from [192.168.2.18] (88-149-228-83.v4.ngi.it [88.149.228.83])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id D1A24B0008B;
        Fri, 24 May 2019 14:09:14 +0200 (CEST)
Subject: Re: [PATCH 1/2 v2] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
To:     Stefan Roese <sr@denx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190524094825.16151-1-sr@denx.de>
 <20190524102002.GT2781@lahna.fi.intel.com>
 <CAHp75VcMVrYv1MXmmqE9fDXShS=Y8pPdWZ4f1neo=ne88TLZDg@mail.gmail.com>
 <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <2036b776-8b8e-d1fd-00b4-c3b046f25a2f@micronovasrl.com>
Date:   Fri, 24 May 2019 14:09:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <287cdcc8-9a8f-4583-8be9-bd1f95936733@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stefan,

Il 24/05/2019 13:29, Stefan Roese ha scritto:
> On 24.05.19 13:11, Andy Shevchenko wrote:
>> On Fri, May 24, 2019 at 1:21 PM Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>>>
>>> On Fri, May 24, 2019 at 11:48:24AM +0200, Stefan Roese wrote:
>>>> This patch adds a check for the GPIOs property existence, before the
>>>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
>>>> support is added (2nd patch in this patch series) on x86 platforms using
>>>> ACPI.
>>>>
>>>> Here Mika's comments from 2016-08-09:
>>>>
>>>> "
>>>> I noticed that with v4.8-rc1 serial console of some of our Broxton
>>>> systems does not work properly anymore. I'm able to see output but input
>>>> does not work.
>>>>
>>>> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
>>>> ("tty/serial/8250: use mctrl_gpio helpers").
>>>>
>>>> The reason why it fails is that in ACPI we do not have names for GPIOs
>>>> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
>>>> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
>>>> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
>>>> UART device in Broxton has following (simplified) ACPI description:
>>>>
>>>>       Device (URT4)
>>>>       {
>>>>           ...
>>>>           Name (_CRS, ResourceTemplate () {
>>>>               GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>>                       "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>>               {
>>>>                   0x003A
>>>>               }
>>>>               GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>>>>                       "\\_SB.GPO0", 0x00, ResourceConsumer)
>>>>               {
>>>>                   0x003D
>>>>               }
>>>>           })
>>>>
>>>> In this case it finds the first GPIO (0x003A which happens to be RX pin
>>>> for that UART), turns it into GPIO which then breaks input for the UART
>>>> device. This also breaks systems with bluetooth connected to UART (those
>>>> typically have some GPIOs in their _CRS).
>>>>
>>>> Any ideas how to fix this?
>>>>
>>>> We cannot just drop the _CRS index lookup fallback because that would
>>>> break many existing machines out there so maybe we can limit this to
>>>> only DT enabled machines. Or alternatively probe if the property first
>>>> exists before trying to acquire the GPIOs (using
>>>> device_property_present()).
>>>> "
>>>>
>>>> This patch implements the fix suggested by Mika in his statement above.
>>>>
>>
>> We have a board where ASL provides _DSD for CTS and RxD pins.
>> I'm afraid this won't work on it.
> 
> With "won't work" you mean, that the GPIO can't be used for modem
> control in this case in the current implementation (with this
> patchset)? Or do you mean, that the breakage (input does not work
> on Broxton systems) will not be solved by this patch?
> 
> If its the former, then I think that solving this issue is something
> for a new patch, to support modem-control on such platforms as well
> (if needed).
> 
> Please note that this patch is not trying to get modem-control working
> on such ACPI based systems. Its targeted for device-tree enabled
> platforms, using the 8250 serial driver, here specifically a MIPS
> MT7688 based board. And just wants to fix the latter issue mentioned
> above so that the 8250 modem-control support can be accepted in
> mainline.

Take a look here:
https://lkml.org/lkml/2018/6/5/253

It's about waking up 8250 UART.
As I remember that is the problem.
I wanted to try to fix it but had no time.

What it broken as I remember is the capability to wake up linux on uart 
RX. Hope I've understood right at that time.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

>> Basically we need to understand the use of the GPIOs in UART. In our
>> case it's an out-of-band wake up source for UART.
>> Simply requiring GPIOs to be present is not enough.
>>
>> Perhaps property like 'modem-control-gpio-in-use' (this seems a bad
>> name, given for sake of example).
> 
> Thanks,
> Stefan
> 

