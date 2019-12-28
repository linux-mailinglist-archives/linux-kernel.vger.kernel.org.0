Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D012BD11
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL1JC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 04:02:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfL1JC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 04:02:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 196805715502D66F680F;
        Sat, 28 Dec 2019 17:02:55 +0800 (CST)
Received: from [127.0.0.1] (10.184.195.37) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Dec 2019
 17:02:45 +0800
Subject: Re: [PATCH] sys_personality: Add a optional arch hook
 arch_check_personality()
To:     <mark.rutland@arm.com>, <hch@infradead.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <guohanjun@huawei.com>, <wcohen@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mtk.manpages@gmail.com>,
        <wezhang@redhat.com>
References: <20191228084359.133745-1-bobo.shaobowang@huawei.com>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <4c0865f6-9502-1750-f437-95405f0f699b@huawei.com>
Date:   Sat, 28 Dec 2019 17:02:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191228084359.133745-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.195.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry for sending a wrong version, the correct version is v2.

�� 2019/12/28 16:43, Wang ShaoBo д��:
> currently arm64 use __arm64_sys_arm64_personality() as its default
> syscall. Now using a normal hook arch_check_personality() can reject
> personality settings for special case of different archs.
>
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>   arch/arm64/kernel/sys.c |  6 +++---
>   kernel/exec_domain.c    | 11 +++++++++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index d5ffaaab31a7..751fbd57eb1e 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>   	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
>   }
>   
> -SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
> +int arch_check_personality(unsigned int personality)
>   {
>   	if (personality(personality) == PER_LINUX32 &&
>   		!system_supports_32bit_el0())
>   		return -EINVAL;
> -	return ksys_personality(personality);
> +
> +	return 0;
>   }
>   
>   asmlinkage long sys_ni_syscall(void);
> @@ -46,7 +47,6 @@ asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused)
>   /*
>    * Wrappers to pass the pt_regs argument.
>    */
> -#define __arm64_sys_personality		__arm64_sys_arm64_personality
>   
>   #undef __SYSCALL
>   #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
> diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
> index f7a0512ddc23..ec6b16e30ed1 100644
> --- a/kernel/exec_domain.c
> +++ b/kernel/exec_domain.c
> @@ -35,7 +35,18 @@ static int __init proc_execdomains_init(void)
>   module_init(proc_execdomains_init);
>   #endif
>   
> +static int __weak arch_check_personality(unsigned int personality)
> +{
> +	return 0;
> +}
> +
>   SYSCALL_DEFINE1(personality, unsigned int, personality)
>   {
> +	int check;
> +
> +	check = arch_check_personality(personality);
> +	if (check)
> +		return check;
> +
>   	return ksys_personality(personality);
>   }

