Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5685D7453
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfJOLMS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Oct 2019 07:12:18 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42398 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfJOLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:12:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iKKkR-0004nD-5y; Tue, 15 Oct 2019 05:12:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iKKkQ-0005CK-BC; Tue, 15 Oct 2019 05:12:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     lijiang <lijiang@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
References: <20191012022140.19003-1-lijiang@redhat.com>
        <20191012022140.19003-4-lijiang@redhat.com>
        <87d0f22oi5.fsf@x220.int.ebiederm.org>
        <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
        <f3fc12b9-be39-d430-52f5-d1b76b2599a3@redhat.com>
Date:   Tue, 15 Oct 2019 06:11:21 -0500
In-Reply-To: <f3fc12b9-be39-d430-52f5-d1b76b2599a3@redhat.com> (lijiang's
        message of "Mon, 14 Oct 2019 18:02:22 +0800")
Message-ID: <87tv8az2jq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iKKkQ-0005CK-BC;;;mid=<87tv8az2jq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/CQX+QOBFNW++gFp6mHXP7BzIXPyWEAgA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;lijiang <lijiang@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 429 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (0.7%), b_tie_ro: 2.2 (0.5%), parse: 1.15
        (0.3%), extract_message_metadata: 6 (1.3%), get_uri_detail_list: 3.1
        (0.7%), tests_pri_-1000: 2.2 (0.5%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.89 (0.2%), tests_pri_-90: 25 (5.9%), check_bayes: 24
        (5.5%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.8%), b_comp_prob:
        1.93 (0.4%), b_tok_touch_all: 3.2 (0.7%), b_finish: 0.65 (0.2%),
        tests_pri_0: 375 (87.5%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.0 (0.5%), poll_dns_idle: 0.13 (0.0%), tests_pri_10:
        1.71 (0.4%), tests_pri_500: 5 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the backup region
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lijiang <lijiang@redhat.com> writes:

> 在 2019年10月12日 20:16, Dave Young 写道:
>> Hi Eric,
>> 
>> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>>> Lianbo Jiang <lijiang@redhat.com> writes:
>>>
>>>> When the crashkernel kernel command line option is specified, the
>>>> low 1MiB memory will always be reserved, which makes that the memory
>>>> allocated later won't fall into the low 1MiB area, thereby, it's not
>>>> necessary to create a backup region and also no need to copy the first
>>>> 640k content to a backup region.
>>>>
>>>> Currently, the code related to the backup region can be safely removed,
>>>> so lets clean up.
>>>>
>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>> ---
>>>
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index eb651fbde92a..cc5774fc84c0 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>>>  
>>>>  #ifdef CONFIG_KEXEC_FILE
>>>>  
>>>> -static unsigned long crash_zero_bytes;
>>>> -
>>>>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>>>>  {
>>>>  	unsigned int *nr_ranges = arg;
>>>> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>>>  {
>>>>  	struct crash_mem *cmem = arg;
>>>>  
>>>> -	cmem->ranges[cmem->nr_ranges].start = res->start;
>>>> -	cmem->ranges[cmem->nr_ranges].end = res->end;
>>>> -	cmem->nr_ranges++;
>>>> +	if (res->start >= SZ_1M) {
>>>> +		cmem->ranges[cmem->nr_ranges].start = res->start;
>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>> +		cmem->nr_ranges++;
>>>> +	} else if (res->end > SZ_1M) {
>>>> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>> +		cmem->nr_ranges++;
>>>> +	}
>>>
>>> What is going on with this chunk?  I can guess but this needs a clear
>>> comment.
>> 
>> Indeed it needs some code comment, this is based on some offline
>> discussion.  cat /proc/vmcore will give a warning because ioremap is
>> mapping the system ram.
>> 
>> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
>> kernel can use the low 1M memory because for example the trampoline
>> code.
>> 
> Thank you, Eric and Dave. I will add the code comment as below if it would be OK.
>
> @@ -234,9 +232,20 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  {
>         struct crash_mem *cmem = arg;
>  
> -       cmem->ranges[cmem->nr_ranges].start = res->start;
> -       cmem->ranges[cmem->nr_ranges].end = res->end;
> -       cmem->nr_ranges++;
> +       /*
> +        * Currently, pass the low 1MiB range to kdump kernel in e820
> +        * as system ram so that kdump kernel can also use the low 1MiB
> +        * memory due to the real mode trampoline code.
> +        * And later, the low 1MiB range will be exclued from elf header,
> +        * which will avoid remapping the 1MiB system ram when dumping
> +        * vmcore.
> +        */
> +       if (res->start >= SZ_1M) {
> +               cmem->ranges[cmem->nr_ranges].start = res->start;
> +               cmem->ranges[cmem->nr_ranges].end = res->end;
> +               cmem->nr_ranges++;
> +       } else if (res->end > SZ_1M) {
> +               cmem->ranges[cmem->nr_ranges].start = SZ_1M;
> +               cmem->ranges[cmem->nr_ranges].end = res->end;
> +               cmem->nr_ranges++;
> +       }
>  
>         return 0;
>  }

I just read through the appropriate section of crash.c and the way
things are structured doing this work in
prepare_elf64_ram_headers_callback is wrong.

This can be done in a simpler manner in elf_header_exclude_ranges.
Something like:

	/* The low 1MiB is always reserved */
	ret = crash_exclude_mem_range(cmem, 0, 1024*1024);
	if (ret)
		return ret;

Eric
