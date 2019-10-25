Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A30E41D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 04:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391052AbfJYCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 22:49:01 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:32450 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390968AbfJYCs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:48:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tg7T0fg_1571971726;
Received: from 30.43.121.138(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0Tg7T0fg_1571971726)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 10:48:46 +0800
Subject: Re: [PATCH RFC 0/7] Support KVM being compiled as a kernel module on
 arm64
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
 <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
 <c17e8b0f32902a0811cc6a4ed71e607e@www.loen.fr>
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
Message-ID: <18653462-38dc-cce1-d0a1-2a7e891163da@linux.alibaba.com>
Date:   Fri, 25 Oct 2019 10:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c17e8b0f32902a0811cc6a4ed71e607e@www.loen.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/24 21:41, Marc Zyngier wrote:
> On 2019-10-24 11:58, James Morse wrote:
>> Hi Shannon,
>>
>> On 24/10/2019 11:27, Shannon Zhao wrote:
>>> Curently KVM ARM64 doesn't support to compile as a kernel module. It's
>>> useful to compile KVM as a module.
>>
>>> For example, it could reload kvm without rebooting host machine.
>>
>> What problem does this solve?
>>
>> KVM has some funny requirements that aren't normal for a module. On
>> v8.0 hardware it must
>> have an idmap. Modules don't usually expect their code to be
>> physically contiguous, but
>> KVM does. KVM influences they way some of the irqchip stuff is set up
>> during early boot
>> (EOI mode ... not that I understand it).
> 
> We change the EOImode solely based on how we were booted (EL2 or not).
> KVM doesn't directly influences that (it comes in the picture much
> later).
> 
>> (I think KVM-as-a-module on x86 is an artifact of how it was developed)
>>
>>
>>> This patchset support this feature while there are some limitations
>>> to be solved. But I just send it out as RFC to get more suggestion and
>>> comments.
>>
>>> Curently it only supports for VHE system due to the hyp code section
>>> address variables like __hyp_text_start.
>>
>> We still need to support !VHE systems, and we need to do it with a
>> single image.
>>
>>
>>> Also it can't call
>>> kvm_update_va_mask when loading kvm module and kernel panic with below
>>> errors. So I make kern_hyp_va into a nop funtion.
>>
>> Making this work for the single-Image on v8.0 is going to be a
>> tremendous amount of work.
>> What is the payoff?
> 
> I can only agree. !VHE is something we're going to support for the 
> foreseeable
> future (which is roughly equivalent to "forever"), and modules have 
> properties
> that are fundamentally incompatible with the way KVM works with !VHE.
> 
Yes, with this patchset we still support !VHE system with built-in KVM. 
While for VHE system we could support kernel module and check at module 
init to avoid wrong usage of kvm module on !VHE systems.

> If the only purpose of this work is to be able to swap KVM implementations
> in a development environment, then it really isn't worth the effort.
> 
Making KVM as a kernel module has many advantages both for development 
and real use environment. For example, we can backport and update KVM 
codes independently and don't need to recompile kernel. Also making KVM 
as a kernel module is a basic for kvm hot upgrade feature without 
shutdown VMs and hosts. This is very important for Cloud Service 
Provider to provides non-stop services for its customers.

Thanks,
Shannon
