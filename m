Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5EF1716CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgB0MIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:08:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgB0MIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:08:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E151FB;
        Thu, 27 Feb 2020 04:08:50 -0800 (PST)
Received: from [10.37.12.169] (unknown [10.37.12.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 062B73F73B;
        Thu, 27 Feb 2020 04:08:48 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores()
 for !SMT NUMA
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, mgorman@techsingularity.net
References: <20200227110053.2514-1-lukasz.luba@arm.com>
 <d2e0fe2d-5891-a2bf-a4c5-2a1f14754c1d@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <74d75844-e710-6df8-30a9-acd440394c2e@arm.com>
Date:   Thu, 27 Feb 2020 12:08:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d2e0fe2d-5891-a2bf-a4c5-2a1f14754c1d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 2/27/20 11:04 AM, Valentin Schneider wrote:
> Hi Lukasz,
> 
> On 2/27/20 11:00 AM, Lukasz Luba wrote:
>> Fix kernel build warning in kernel/sched/fair.c when CONFIG_SCHED_SMT is
>> not set and CONFIG_NUMA_BALANCING is set.
>>
>> kernel/sched/fair.c:1524:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
>>
> 
> I've sent a similar fix yesterday at:
> 
> https://lore.kernel.org/lkml/20200226121244.7524-1-valentin.schneider@arm.com/
> 

I've missed it. You are referring in the commit message to wrong change
(probably HEAD of that branch), while when you try to bisect, it
will point you to
ff7db0bf24db sched/numa: Prefer using an idle CPU as a migration target 
instead of comparing tasks

I think Mel can simply resend the patches with correct build if Ingo
is OK.

If Mel would decide to go with extended approach of ifdefs, then maybe
it's also good to put in there  numa_idle_core(), which actually uses
these test_idle_cores() and is_core_idle()

Regards,
Lukasz
