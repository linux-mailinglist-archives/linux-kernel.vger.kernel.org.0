Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850219AB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 11:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfHWJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 05:43:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbfHWJm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:42:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C19337;
        Fri, 23 Aug 2019 02:42:58 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C62C63F246;
        Fri, 23 Aug 2019 02:42:56 -0700 (PDT)
Subject: Re: [PATCH v2 00/20] Initial support for Marvell MMP3 SoC
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20190822092643.593488-1-lkundrak@v3.sk>
 <244fdc87-0fe5-be79-d9cd-2395d0ac3f57@kernel.org>
 <424d2881edcaf7cedbfa5cbbf2e73aaff5355df3.camel@v3.sk>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <08a0e65e-4a80-f611-e36e-8e3f70fa8113@kernel.org>
Date:   Fri, 23 Aug 2019 10:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <424d2881edcaf7cedbfa5cbbf2e73aaff5355df3.camel@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 08:21, Lubomir Rintel wrote:
> On Thu, 2019-08-22 at 11:31 +0100, Marc Zyngier wrote:
>> On 22/08/2019 10:26, Lubomir Rintel wrote:
>>> Hi, 
>>>
>>> this is a second spin of a patch set that adds support for the Marvell
>>> MMP3 processor. MMP3 is used in OLPC XO-4 laptops, Panasonic Toughpad
>>> FZ-A1 tablet and Dell Wyse 3020 Tx0D thin clients. 
>>>
>>> Compared to v1, there's a handful of fixes in response to reviews. Patch
>>> 02/20 is new. Details in individual patches.
>>>  
>>> Apart from the adjustments in mach-mmp/, the patch makes necessary 
>>> changes to the irqchip driver and adds an USB2 PHY driver. The latter 
>>> has a dependency on the mach-mmp/ changes, so it can't be submitted 
>>> separately.
>>>  
>>> The patch set has been tested to work on Wyse Tx0D and not ruin MMP2 
>>> support on XO-1.75. 
>>
>> How do you want this series to be merged? I'm happy to take the irqchip
>> related patches as well as the corresponding DT change (once reviewed)
>> through my tree.
> 
> I was hoping for the Arm SoC tree, because there are some dependencies
> (MMP3 USB PHY depends on MMP3 SoC).
> 
> That said, the irqchip patches are rather independent and the only
> downside of them going in via a different tree will be that the other
> tree that will lack them won't boot on MMP3 (things will compile
> though). I don't know if that's okay. What's typically done in cases
> like these?

I usually take the irqchip patches that can be built standalone (without
dependency on header files, for example). If you want them to go via
another tree, stick my

	Acked-by: Marc Zyngier <maz@kernel.org>

on patches #6 through #9.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
