Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024EF13A3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 10:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgANJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 04:20:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgANJUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:20:25 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0652962A9F513952354;
        Tue, 14 Jan 2020 17:20:22 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 17:20:15 +0800
Subject: Re: [PATCH] x86/ftrace: use ftrace_write to simplify code
To:     Peter Zijlstra <peterz@infradead.org>, <rostedt@goodmis.org>
CC:     <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
References: <20200114015217.9246-1-cj.chengjian@huawei.com>
 <20200114081636.GH2827@hirez.programming.kicks-ass.net>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <8435b848-f638-978c-bbd5-459657c4b34e@huawei.com>
Date:   Tue, 14 Jan 2020 17:20:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114081636.GH2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/1/14 16:16, Peter Zijlstra wrote:
> On Tue, Jan 14, 2020 at 01:52:17AM +0000, Cheng Jian wrote:
>> ftrace_write() can be used in ftrace_modify_code_direct(),
>> that make the code more brief.
>>
>> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> None of the code you're patching still exists. Please see tip/master.
>
> .


I find these patches in TIP. My patch may not be necessary.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=768ae4406a5cab7e8702550f2446dbeb377b798d

Thank you, Peter.


-- Cheng Jian


