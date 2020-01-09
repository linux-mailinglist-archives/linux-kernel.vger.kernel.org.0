Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F092D1354A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 09:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgAIIph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 03:45:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728465AbgAIIph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:45:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A6659D20FE53C486A031;
        Thu,  9 Jan 2020 16:45:34 +0800 (CST)
Received: from [127.0.0.1] (10.184.195.37) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 16:45:24 +0800
Subject: Re: [PATCH] sys_personality: Add a optional arch hook
 arch_check_personality() for common sys_personality()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
CC:     <mark.rutland@arm.com>, <hch@infradead.org>,
        <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <guohanjun@huawei.com>, <wcohen@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mtk.manpages@gmail.com>,
        <wezhang@redhat.com>
References: <20200109013846.174796-1-bobo.shaobowang@huawei.com>
 <20200109065424.GA84503@light.dominikbrodowski.net>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <dcdf6142-20c3-c064-6edf-8fcc921c4d00@huawei.com>
Date:   Thu, 9 Jan 2020 16:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200109065424.GA84503@light.dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.195.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply, I wiil send it in version 2

Thanks,

             wangshaobo

在 2020/1/9 14:54, Dominik Brodowski 写道:
> On Thu, Jan 09, 2020 at 09:38:46AM +0800, Wang ShaoBo wrote:
>> currently arm64 use __arm64_sys_arm64_personality() as its default
>> syscall. But using a normal hook arch_check_personality() can reject
>> personality settings for special case of different archs.
> Thanks for your patch!
>
>>   SYSCALL_DEFINE1(personality, unsigned int, personality)
>>   {
>> -	unsigned int old = current->personality;
>> +	int check;
>>   
>> -	if (personality != 0xffffffff)
>> -		set_personality(personality);
>> +	check = arch_check_personality(personality);
>> +	if (check)
>> +		return check;
>>   
>> -	return old;
>> +	return ksys_personality(personality);
>>   }
> Please leave the default check and call to set_personality()
> in here and remove the now-unneeded ksys_personality() from
> include/linux/syscalls.h
>
> Thanks,
> 	Dominik
>
> .

