Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC93B1100DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfLCPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 10:08:38 -0500
Received: from foss.arm.com ([217.140.110.172]:44090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfLCPIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:08:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FC031B;
        Tue,  3 Dec 2019 07:08:37 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B6683F52E;
        Tue,  3 Dec 2019 07:08:36 -0800 (PST)
Subject: Re: Crash in fair scheduler
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1575364273836.74450@mentor.com>
 <564e45cb-8230-9c3d-24a8-b58e6e88349f@arm.com>
 <944927a7-b578-c6f9-a73d-25c5b0a39adb@arm.com>
 <e6178a95-c02e-4fe9-49ee-7446e0d73882@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f4e810c0-c99a-e78f-a249-9d7efcb37806@arm.com>
Date:   Tue, 3 Dec 2019 16:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <e6178a95-c02e-4fe9-49ee-7446e0d73882@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 12:09, Valentin Schneider wrote:
> On 03/12/2019 10:40, Dietmar Eggemann wrote:
>> On 03/12/2019 11:30, Valentin Schneider wrote:
>>> On 03/12/2019 09:11, Schmid, Carsten wrote:
>>
>> [...]
>>
>>> That looks a lot like a recent issue we've had, see
>>>
>>>   https://lore.kernel.org/lkml/20191108131909.428842459@infradead.org/
>>>
>>> The issue is caused by
>>>   
>>>   67692435c411 ("sched: Rework pick_next_task() slow-path")
>>>
>>> which 5.4-rc2 has (without the fix which landed in -rc7) but 4.14 really
>>> shouldn't, unless the kernel you're using has had core scheduling somehow
>>> backported to it?
>>>
>>> I've only scraped the surface but I'd like to first ask: can you reproduce
>>> the issue on v5.4 final ?
>>
>> Can't be. 4.14.86 does not have ("sched: Rework pick_next_task()
>> slow-path").
>>
> 
> Right, which is why I wondered if the kernel under test had had that 
> backported to it for some reason (e.g. core scheduling). Peter pointed out
> that this is a slightly different issue (nr_running matches the rbt), so
> this is probably unrelated.

I can't reproduce it on Arm64 Juno running 4.14.86. I suppose that there
is no extra reproducer testcase since the issue happened with
prev->sched_class eq. &idle_sched_class [prev eq. swapper/X 0] in the
simple path of pick_next_task_fair().

I'm running with CONFIG_SCHED_AUTOGROUP=y and CONFIG_FAIR_GROUP_SCHED=y
some taskgroup related tests for hours now. So the sched_entity (se) can
be a task, an autogroup or a taskgroup in the simple path. pref is
either swapper/X or migration/X.
