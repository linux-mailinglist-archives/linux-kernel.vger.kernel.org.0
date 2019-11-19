Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5E1022BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfKSLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 06:15:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:55640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727699AbfKSLPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:15:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E48BBA0D;
        Tue, 19 Nov 2019 11:15:30 +0000 (UTC)
Subject: Re: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-6-afaerber@suse.de>
 <a43d184d74c34e269714858b2635c35e@realtek.com>
 <960a80b9-b1bf-3709-bbb7-fc2a3c3ae1da@suse.de>
 <753c18eee3fb4e9ea25d42798542b3dd@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <ed66e712-4ceb-374c-dd36-476d79706251@suse.de>
Date:   Tue, 19 Nov 2019 12:15:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <753c18eee3fb4e9ea25d42798542b3dd@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 18.11.19 um 07:53 schrieb James Tai:
>> So another question, applicable to all SoCs: This reserved Boot ROM area at
>> the start of the address space, here of size 0xa800, is that copied into RAM, or
>> is that the actual ROM overlapping RAM? If the latter, we should exclude it
>> from /memory@0's reg (making it /memory@a800), and add it to soc's ranges
>> here for correctness.
>>
> Yes, we should exclude it from /memory@0's reg.

OK, will look into it.

> 
>> With the follow-up question: Is it correct that, given the size 0xa800, I have a
>> gap between /memreserve/s from 0xa800 to 0xc000, or should we reserve that
>> gap by extending the next /memreserve/ or inserting one?
> 
> We should reserve memory address from 0x0000 to 0xa800 for the internal ROM.

Please see [1] - I had already updated the second reservation to start
at 0xa800 and extended it to 0x100000 before your response here.

The previous "bootcode" size of 0xc000 can be found here:
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm/mach-rtd119x/include/mach/memory.h
https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm/boot/dts/realtek/rtd119x/rtd-119x-horseradish.dts

As you can see the 0xc000 and 0xf4000 were hardcoded and did not depend
on SYS_BOOTCODE_MEMSIZE...
For later SoCs I saw some FIXME(?) comment that area up to 0x100000 was
reserved due to some Jira ticket and should get fixed? Any insights on
what is in that memory range causing problems?

Regards,
Andreas

[1] https://patchwork.kernel.org/patch/11248033/

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
