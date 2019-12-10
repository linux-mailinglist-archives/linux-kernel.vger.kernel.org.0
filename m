Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFF118EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLJRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 12:18:01 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727494AbfLJRSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:18:00 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 21CB27D2E1888597DC07;
        Tue, 10 Dec 2019 17:17:58 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Dec 2019 17:17:57 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 17:17:57 +0000
Subject: Re: perf top for arm64?
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
Date:   Tue, 10 Dec 2019 17:17:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191210170841.GA23357@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 17:08, Jiri Olsa wrote:
> On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
>> On 10/12/2019 16:36, Jiri Olsa wrote:
>>> On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
>>>> Hi all,
>>>>
>>>> I find to my surprise that "perf top" does not work for arm64:
>>>>
>>>> root@ubuntu:/home/john/linux# tools/perf/perf top
>>>> Couldn't read the cpuid for this machine: No such file or directory
>>>
>>
>> Hi Jirka,
>>
>>> there was recent change that check on cpuid and quits:
>>>     608127f73779 perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
>>>
>>
>> ok, this is new code. I obviously didn't check the git history...
>>
>> But, apart from this, there are many other places where get_cpuid() is
>> called. I wonder what else we're missing out on, and whether we should still
>> add it.
> 
> right, I was just wondering how come vendor events are working for you,
> but realized we have get_cpuid_str being called in there ;-)
> 
> I think we should add it as you have it prepared already,
> could you post it with bigger changelog that would explain
> where it's being used for arm?

ok, I can look to do that.

But, as you know, we still need to fix perf top for other architectures 
affected.

Thanks,
John
