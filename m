Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA87232B47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfFCJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 05:01:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfFCJBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:01:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFD1141523E3C9E53C7F;
        Mon,  3 Jun 2019 17:01:22 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 17:01:20 +0800
Subject: Re: [PATCH] sched/core: add __sched tag for io_schedule()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
References: <20190531082912.80724-1-gaoxiang25@huawei.com>
 <20190603085836.GD3436@hirez.programming.kicks-ass.net>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <940b2690-78ce-03b9-8e0d-ce08cdda722f@huawei.com>
Date:   Mon, 3 Jun 2019 17:00:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190603085836.GD3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2019/6/3 16:58, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 04:29:12PM +0800, Gao Xiang wrote:
>> non-inline io_schedule() was introduced in
>> commit 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
>> Keep in line with io_schedule_timeout, Otherwise
>> "/proc/<pid>/wchan" will report io_schedule()
>> rather than its callers when waiting io.
>>
>> Reported-by: Jilong Kou <koujilong@huawei.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> This is lacking a Fixes: tag.
> 

OK, thanks for pointing out. It seems enough to resend this patch.
I will resend this patch with all necessary tags.

Thanks,
Gao Xiang
