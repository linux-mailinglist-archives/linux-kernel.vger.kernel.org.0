Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D8E48C3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394449AbfJYKnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:43:18 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:35644 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390754AbfJYKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:43:17 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNx3o-00039M-NY; Fri, 25 Oct 2019 12:43:12 +0200
To:     Shannon Zhao <shannon.zhao@linux.alibaba.com>
Subject: Re: [PATCH RFC 0/7] Support KVM being compiled as a kernel module  on arm64
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Oct 2019 11:43:12 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>, <kvmarm@lists.cs.columbia.edu>,
        <suzuki.poulose@arm.com>, <christoffer.dall@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <18653462-38dc-cce1-d0a1-2a7e891163da@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
 <8cbd81d6-4ab8-9d2a-5162-8782201cd13d@arm.com>
 <c17e8b0f32902a0811cc6a4ed71e607e@www.loen.fr>
 <18653462-38dc-cce1-d0a1-2a7e891163da@linux.alibaba.com>
Message-ID: <66e983b383d9f99df0007a717e084fe6@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: shannon.zhao@linux.alibaba.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com, christoffer.dall@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-25 03:48, Shannon Zhao wrote:
> On 2019/10/24 21:41, Marc Zyngier wrote:
>> On 2019-10-24 11:58, James Morse wrote:
>>> Hi Shannon,
>>>
>>> On 24/10/2019 11:27, Shannon Zhao wrote:
>>>> Curently KVM ARM64 doesn't support to compile as a kernel module. 
>>>> It's
>>>> useful to compile KVM as a module.
>>>
>>>> For example, it could reload kvm without rebooting host machine.
>>>
>>> What problem does this solve?
>>>
>>> KVM has some funny requirements that aren't normal for a module. On
>>> v8.0 hardware it must
>>> have an idmap. Modules don't usually expect their code to be
>>> physically contiguous, but
>>> KVM does. KVM influences they way some of the irqchip stuff is set 
>>> up
>>> during early boot
>>> (EOI mode ... not that I understand it).
>> We change the EOImode solely based on how we were booted (EL2 or 
>> not).
>> KVM doesn't directly influences that (it comes in the picture much
>> later).
>>
>>> (I think KVM-as-a-module on x86 is an artifact of how it was 
>>> developed)
>>>
>>>
>>>> This patchset support this feature while there are some 
>>>> limitations
>>>> to be solved. But I just send it out as RFC to get more suggestion 
>>>> and
>>>> comments.
>>>
>>>> Curently it only supports for VHE system due to the hyp code 
>>>> section
>>>> address variables like __hyp_text_start.
>>>
>>> We still need to support !VHE systems, and we need to do it with a
>>> single image.
>>>
>>>
>>>> Also it can't call
>>>> kvm_update_va_mask when loading kvm module and kernel panic with 
>>>> below
>>>> errors. So I make kern_hyp_va into a nop funtion.
>>>
>>> Making this work for the single-Image on v8.0 is going to be a
>>> tremendous amount of work.
>>> What is the payoff?
>> I can only agree. !VHE is something we're going to support for the 
>> foreseeable
>> future (which is roughly equivalent to "forever"), and modules have 
>> properties
>> that are fundamentally incompatible with the way KVM works with 
>> !VHE.
>
> Yes, with this patchset we still support !VHE system with built-in 
> KVM. While for VHE system we could support kernel module and check at 
> module init to avoid wrong usage of kvm module on !VHE systems.

How do you reconcile this with the need to have a single kernel image 
that
is full-featured on all architecture revisions? In your view of the 
world,
it is OK to have a VHE-specific kernel that won't have KVM on a v8.0 
system.
 From my point of view, this simply isn't acceptable.

>> If the only purpose of this work is to be able to swap KVM 
>> implementations
>> in a development environment, then it really isn't worth the effort.
>
> Making KVM as a kernel module has many advantages both for 
> development and real use environment. For example, we can backport and 
> update KVM codes independently and don't need to recompile kernel. Also 
> making KVM as a kernel module is a basic for kvm hot upgrade feature 
> without shutdown VMs and hosts. This is very important for Cloud 
> Service Provider to provides non-stop services for its customers.

The goal is certainly commendable.

But pretending that KVM is fully independent from the rest of the 
kernel is
an intellectual fallacy. Most of the issues that affect KVM at any 
given time
are actually core kernel issues that cannot be solved by just updating 
the
KVM module. You need to update the whole thing, not just the tiny bit 
that
switches between host and guests.

         M.
-- 
Jazz is not dead. It just smells funny...
