Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5AACF2EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfJHGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 02:39:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729937AbfJHGjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:39:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BA09D3084733FCB0373;
        Tue,  8 Oct 2019 14:39:37 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 14:39:33 +0800
Subject: Re: [PATCH 00/32] Kill pr_warning in the whole linux code
To:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Andy Whitcroft <apw@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        AlexeiStarovoitov <ast@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <f613df39-6903-123b-a0f1-d1b783a755ce@huawei.com>
Date:   Tue, 8 Oct 2019 14:39:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191002085554.ddvx6yx6nx7tdeey@pathway.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 2019/10/2 16:55, Petr Mladek wrote:
> Linus,
> 
> On Fri 2019-09-20 14:25:12, Kefeng Wang wrote:
>> There are pr_warning and pr_warng to show WARNING level message,
>> most of the code using pr_warn, number based on next-20190919,
>>
>> pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)
> 
> The ratio is 10:1 in favor of pr_warn(). It would make sense
> to remove the pr_warning().
> 
> Would you accept pull request with these 32 simple patches
> for rc2, please?
> 
> Alternative is to run a simple sed. But it is not trivial
> to fix indentation of the related lines.

Kindly ping, should I respin patches with comments fixed?
Is the patchset acceptable, hope to be clear that what to do next :)

Thanks

> 
> Best Regards,
> Petr
> 
> .
> 

