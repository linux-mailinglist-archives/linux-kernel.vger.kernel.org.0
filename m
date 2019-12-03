Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E3510FC34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 12:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCLJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 06:09:28 -0500
Received: from foss.arm.com ([217.140.110.172]:40460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfLCLJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:09:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B20430E;
        Tue,  3 Dec 2019 03:09:27 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D85FA3F68E;
        Tue,  3 Dec 2019 03:09:26 -0800 (PST)
Subject: Re: Crash in fair scheduler
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1575364273836.74450@mentor.com>
 <564e45cb-8230-9c3d-24a8-b58e6e88349f@arm.com>
 <944927a7-b578-c6f9-a73d-25c5b0a39adb@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e6178a95-c02e-4fe9-49ee-7446e0d73882@arm.com>
Date:   Tue, 3 Dec 2019 11:09:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <944927a7-b578-c6f9-a73d-25c5b0a39adb@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 10:40, Dietmar Eggemann wrote:
> On 03/12/2019 11:30, Valentin Schneider wrote:
>> On 03/12/2019 09:11, Schmid, Carsten wrote:
> 
> [...]
> 
>> That looks a lot like a recent issue we've had, see
>>
>>   https://lore.kernel.org/lkml/20191108131909.428842459@infradead.org/
>>
>> The issue is caused by
>>   
>>   67692435c411 ("sched: Rework pick_next_task() slow-path")
>>
>> which 5.4-rc2 has (without the fix which landed in -rc7) but 4.14 really
>> shouldn't, unless the kernel you're using has had core scheduling somehow
>> backported to it?
>>
>> I've only scraped the surface but I'd like to first ask: can you reproduce
>> the issue on v5.4 final ?
> 
> Can't be. 4.14.86 does not have ("sched: Rework pick_next_task()
> slow-path").
> 

Right, which is why I wondered if the kernel under test had had that 
backported to it for some reason (e.g. core scheduling). Peter pointed out
that this is a slightly different issue (nr_running matches the rbt), so
this is probably unrelated.
