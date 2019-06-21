Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F97F4E904
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 15:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFUN0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 09:26:15 -0400
Received: from foss.arm.com ([217.140.110.172]:60542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUN0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:26:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0AA344;
        Fri, 21 Jun 2019 06:26:14 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC2A3F246;
        Fri, 21 Jun 2019 06:26:12 -0700 (PDT)
Subject: Re: [PATCH 0/5] BT scheduling class
To:     Peter Zijlstra <peterz@infradead.org>, xiaoggchen@tencent.com
Cc:     jasperwang@tencent.com, heddchen@tencent.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        viresh.kumar@linaro.org
References: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
 <20190621130316.GK3436@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6a81a564-9d89-f01d-15b8-e07f092cc5f1@arm.com>
Date:   Fri, 21 Jun 2019 14:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621130316.GK3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2019 14:03, Peter Zijlstra wrote:
> On Fri, Jun 21, 2019 at 03:45:52PM +0800, xiaoggchen@tencent.com wrote:
> 
>> First only server application exists in the system and the success
>> rate is 99.998% and the average cpu use is only 25%.
> 
> Have you guys looked at this series:
> 
>   https://lkml.kernel.org/r/cover.1556182964.git.viresh.kumar@linaro.org
> 
> 

Sort of a shot in the dark here, but I wonder if task stealing [1] could
help as well? IIRC Steve had some pretty good CPU utilization improvements
with his series.

FWIW I have a somewhat recent rebase of CFS stealing laying around at [2].

[1]: https://lore.kernel.org/lkml/1544131696-2888-1-git-send-email-steven.sistare@oracle.com/
[2]: http://www.linux-arm.org/git?p=linux-vs.git;a=shortlog;h=refs/heads/mainline/cfs-stealing/v4-rebase
