Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38B618B2F0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCSMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 08:05:26 -0400
Received: from foss.arm.com ([217.140.110.172]:34050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSMF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:05:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D99E431B;
        Thu, 19 Mar 2020 05:05:25 -0700 (PDT)
Received: from e113632-lin (unknown [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AA8D3F305;
        Thu, 19 Mar 2020 05:05:24 -0700 (PDT)
References: <20200311181601.18314-1-valentin.schneider@arm.com> <20200311181601.18314-3-valentin.schneider@arm.com> <4a7fe6ae-3587-4a55-1cf2-c4fe568a5ffa@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 2/9] sched/debug: Make sd->flags sysctl read-only
In-reply-to: <4a7fe6ae-3587-4a55-1cf2-c4fe568a5ffa@arm.com>
Date:   Thu, 19 Mar 2020 12:04:56 +0000
Message-ID: <jhjwo7go8if.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 19 2020, Dietmar Eggemann wrote:
> On 11.03.20 19:15, Valentin Schneider wrote:
>> Writing to the sysctl of a sched_domain->flags directly updates the value of
>> the field, and goes nowhere near update_top_cache_domain(). This means that
>> the cached domain pointers can end up containing stale data (e.g. the
>> domain pointed to doesn't have the relevant flag set anymore).
>>
>> Explicit domain walks that check for flags will be affected by
>> the write, but this won't be in sync with the cached pointers which will
>> still point to the domains that were cached at the last sched_domain
>> build.
>>
>> In other words, writing to this interface is playing a dangerous game. It
>> could be made to trigger an update of the cached sched_domain pointers when
>> written to, but this does not seem to be worth the trouble. Make it
>> read-only.
>
> As long as I don't change SD flags for which cached SD pointers exist
> (SD_SHARE_PKG_RESOURCES, SD_NUMA, SD_ASYM_PACKING or
> SD_ASYM_CPUCAPACITY) the write-able interface still could make some sense.
>
> E.g. by enabling SD_BALANCE_WAKE on the fly, I can force !want_affine
> wakees into slow path.
>

True, although since there is no explicit differenciation between the
cached and !cached flags, this is still a landmined interface.

> The question is, do people use the writable flags interface to tweak
> select_task_rq_fair() behavior in this regard?

I did try asking around on IRC (which admittedly is just a small subset
of people) but didn't find anyone.
