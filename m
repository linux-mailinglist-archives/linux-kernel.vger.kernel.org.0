Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD41918B138
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgCSKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:25:27 -0400
Received: from foss.arm.com ([217.140.110.172]:32906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgCSKZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:25:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 278EE1045;
        Thu, 19 Mar 2020 03:25:26 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4B503FAB1;
        Thu, 19 Mar 2020 02:07:32 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 2/9] sched/debug: Make sd->flags sysctl read-only
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
References: <20200311181601.18314-1-valentin.schneider@arm.com>
 <20200311181601.18314-3-valentin.schneider@arm.com>
Message-ID: <4a7fe6ae-3587-4a55-1cf2-c4fe568a5ffa@arm.com>
Date:   Thu, 19 Mar 2020 10:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311181601.18314-3-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 19:15, Valentin Schneider wrote:
> Writing to the sysctl of a sched_domain->flags directly updates the value of
> the field, and goes nowhere near update_top_cache_domain(). This means that
> the cached domain pointers can end up containing stale data (e.g. the
> domain pointed to doesn't have the relevant flag set anymore).
> 
> Explicit domain walks that check for flags will be affected by
> the write, but this won't be in sync with the cached pointers which will
> still point to the domains that were cached at the last sched_domain
> build.
> 
> In other words, writing to this interface is playing a dangerous game. It
> could be made to trigger an update of the cached sched_domain pointers when
> written to, but this does not seem to be worth the trouble. Make it
> read-only.

As long as I don't change SD flags for which cached SD pointers exist
(SD_SHARE_PKG_RESOURCES, SD_NUMA, SD_ASYM_PACKING or
SD_ASYM_CPUCAPACITY) the write-able interface still could make some sense.

E.g. by enabling SD_BALANCE_WAKE on the fly, I can force !want_affine
wakees into slow path.

The question is, do people use the writable flags interface to tweak
select_task_rq_fair() behavior in this regard?
