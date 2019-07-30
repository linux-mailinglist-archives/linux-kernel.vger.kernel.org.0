Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9043A7A6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfG3LNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 07:13:25 -0400
Received: from foss.arm.com ([217.140.110.172]:59424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfG3LNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:13:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30C42344;
        Tue, 30 Jul 2019 04:13:24 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4D813F575;
        Tue, 30 Jul 2019 04:13:23 -0700 (PDT)
Subject: Re: [PATCH 05/12] genirq/debugfs: Replace strncmp with str_has_prefix
To:     Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190729151435.9498-1-hslester96@gmail.com>
 <alpine.DEB.2.21.1907301113580.1738@nanos.tec.linutronix.de>
 <CANhBUQ2L71Q2j_iOUaHW7qk0BS6wwMBwmtd8N4S5mNLYHr4Dhw@mail.gmail.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <708d8d79-6464-fbd3-6a62-853c29b32cc3@kernel.org>
Date:   Tue, 30 Jul 2019 12:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANhBUQ2L71Q2j_iOUaHW7qk0BS6wwMBwmtd8N4S5mNLYHr4Dhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 11:58, Chuhong Yuan wrote:
> Thomas Gleixner <tglx@linutronix.de> 于2019年7月30日周二 下午5:17写道：
>>
>> On Mon, 29 Jul 2019, Chuhong Yuan wrote:
>>
>>> strncmp(str, const, len) is error-prone.
>>> We had better use newly introduced
>>> str_has_prefix() instead of it.
>>
>> Can you please provide a proper explanation why the below strncmp() is
>> error prone?
>>
> 
> If the size is less than 7, for example, 2, then even if buf is "tr", the
> result will still be true. This is an error.
> strncmp(str, const, len) is error-prone mainly because the len is easy
> to be wrong.
> 
>> Just running a script and copying some boiler plate changelog saying
>> 'strncmp() is error prone' does not cut it.
>>
>>> -     if (!strncmp(buf, "trigger", size)) {
>>> +     if (str_has_prefix(buf, "trigger")) {
>>
>> Especially when the resulting code is not equivalent.
>>
> 
> I think here the semantic is the comparison should only return true
> when buf is "trigger".

Not quite. It will satisfy the condition for 't', 'tr', 'trig',
'trigger', and of course 'triggerthissillyinterruptwhichImdebugging'.

I agree that the semantic is a bit bizarre and maybe not quite expected,
but still... You seem to be changing the semantic without any
justification other than "this is safer".

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
