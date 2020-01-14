Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DDA139F21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 02:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgANBhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 20:37:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728946AbgANBhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:37:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BA7115B6EC2D4E62466E;
        Tue, 14 Jan 2020 09:37:51 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 09:37:42 +0800
Subject: Re: [PATCH] x86/ftrace: usr ftrace_write to simplify code
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <bobo.shaobowang@huawei.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>
References: <20200113073347.22748-1-cj.chengjian@huawei.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <8ab66ffb-614b-063d-7362-2f01906aec51@huawei.com>
Date:   Tue, 14 Jan 2020 09:37:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113073347.22748-1-cj.chengjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry.

usr => use in subject.

I will resend this patch.

  --Cheng Jian

On 2020/1/13 15:33, Cheng Jian wrote:
> ftrace_write() can be used directly in ftrace_modify_code_direct(),
> that make the code more brief.
>
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>   arch/x86/kernel/ftrace.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 024c3053dbba..6b36ed2fd04d 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -114,6 +114,16 @@ static const unsigned char *ftrace_nop_replace(void)
>   	return ideal_nops[NOP_ATOMIC5];
>   }
>   
> +static int ftrace_write(unsigned long ip, const char *val, int size)
> +{
> +	ip = text_ip_addr(ip);
> +
> +	if (probe_kernel_write((void *)ip, val, size))
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
>   static int
>   ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
>   		   unsigned const char *new_code)
> @@ -138,10 +148,8 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
>   	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0)
>   		return -EINVAL;
>   
> -	ip = text_ip_addr(ip);
> -
>   	/* replace the text with the new text */
> -	if (probe_kernel_write((void *)ip, new_code, MCOUNT_INSN_SIZE))
> +	if (ftrace_write(ip, new_code, MCOUNT_INSN_SIZE))
>   		return -EPERM;
>   
>   	sync_core();
> @@ -326,16 +334,6 @@ int ftrace_int3_handler(struct pt_regs *regs)
>   }
>   NOKPROBE_SYMBOL(ftrace_int3_handler);
>   
> -static int ftrace_write(unsigned long ip, const char *val, int size)
> -{
> -	ip = text_ip_addr(ip);
> -
> -	if (probe_kernel_write((void *)ip, val, size))
> -		return -EPERM;
> -
> -	return 0;
> -}
> -
>   static int add_break(unsigned long ip, const char *old)
>   {
>   	unsigned char replaced[MCOUNT_INSN_SIZE];

