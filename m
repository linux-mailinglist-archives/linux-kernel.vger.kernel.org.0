Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4318F61F98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfGHNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 09:34:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729708AbfGHNeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:34:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4101690DED667519EBA2;
        Mon,  8 Jul 2019 21:34:17 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 8 Jul 2019
 21:34:15 +0800
Subject: Re: [v2] time: Validate the usec before covert to nsec in do_adjtimex
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1562582568-129891-1-git-send-email-zhangxiaoxu5@huawei.com>
 <alpine.DEB.2.21.1907081458400.1926@nanos.tec.linutronix.de>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <5fcccfec-cd51-02d5-d096-5a14675c2132@huawei.com>
Date:   Mon, 8 Jul 2019 21:33:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907081458400.1926@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/7/8 21:04, Thomas Gleixner Ð´µÀ:
> On Mon, 8 Jul 2019, ZhangXiaoxu wrote:
> 
>> When covert the usec to nsec, it will multiple 1000, it maybe
>> overflow and lead an undefined behavior.
>>
>> For example, users may input an negative tv_usec values when
>> call adjtimex syscall, then multiple 1000 maybe overflow it
>> to a positive and legal number.
>>
>> So, we should validate the usec before coverted it to nsec.
> 
> Looking deeper before applying it. That change is wrong for two reasons:
> 
>   1) The value is already validated in timekeeping_validate_timex()
> 
>   2) The tv_usec value can legitimately be >= USEC_PER_SEC if the ADJ_NANO
>      mode bit is set. See timekeeping_validate_timex() and the code you
>      actually modified:
> 
Yes, you are right.
This actually found in an old version, and doesn't check more detail on mainline.
Thank you very much.
>>   	if (txc->modes & ADJ_SETOFFSET) {
>>   		struct timespec64 delta;
>> +
>> +		if (txc->time.tv_usec < 0 || txc->time.tv_usec >= USEC_PER_SEC)
>> +			return -EINVAL;
>>   		delta.tv_sec  = txc->time.tv_sec;
>>   		delta.tv_nsec = txc->time.tv_usec;
>>   		if (!(txc->modes & ADJ_NANO))
> 			delta.tv_nsec *= 1000;
> 
>      	The multiplication is conditional ....
> 
> Thanks,
> 
> 	tglx
> 
> 
> 
> .
> 

