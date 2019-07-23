Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B01718F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 15:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbfGWNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 09:15:08 -0400
Received: from foss.arm.com ([217.140.110.172]:54634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbfGWNPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD4D728;
        Tue, 23 Jul 2019 06:15:07 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BECF93F71F;
        Tue, 23 Jul 2019 06:15:06 -0700 (PDT)
Subject: Re: [PATCH 3/9] dt-bindings: interrupt-controller: arm, gic-v3:
 Describe ESPI range support
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190723104437.154403-1-maz@kernel.org>
 <20190723104437.154403-4-maz@kernel.org>
 <04e80def-c8e3-a403-036e-2a64db935ed4@ti.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e67ff715-9625-6aec-5e1f-28f7c9df66f6@kernel.org>
Date:   Tue, 23 Jul 2019 14:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <04e80def-c8e3-a403-036e-2a64db935ed4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 13:59, Lokesh Vutla wrote:
> 
> 
> On 23/07/19 4:14 PM, Marc Zyngier wrote:
>> GICv3.1 introduces support for new interrupt ranges, one of them being
>> the Extended SPI range (ESPI). The DT binding is extended to deal with
>> it as a new interrupt class.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>> index c34df35a25fc..98a3ecda8e07 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>> @@ -44,11 +44,12 @@ properties:
>>        be at least 4.
>>  
>>        The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>> -      interrupts. Other values are reserved for future use.
>> +      interrupts, 2 for interrupts in the Extended SPI range. Other values
>> +      are reserved for future use.
> 
> Any reason why hardware did not consider extending SPIs from 1020:2043? This way
> only EPPI would have been introduced. Just a thought.

First, 1020-1023 is the special INTID range. You can't have anything
else there.

Then, making the range contiguous could imply that the range is also
contiguous in the register space, which isn't possible (note that the
EPPI range does it the other way around -- it is discontinuous in the
INTID space, and yet continuous in the register space).

Finally, the decision to push the numbering out towards the LPI range
allows the ESPI space to be grown easily up to 4k.

But frankly, none of that really matters. They are just numbers.

> Either ways, just to be consistent with hardware numbering can ESPI range be 3
> and EPPI range be 2?

Well, the way I see it is that it is more logical for the binding
itself. We already have 0 for SPIs and 1 for PPIs, despite PPIs being
before SPIs in the INTID space.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
