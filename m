Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51642D540F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 05:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfJMDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 23:55:33 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33688 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfJMDzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 23:55:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iJUyZ-0001sG-FD; Sat, 12 Oct 2019 21:55:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iJUyY-00065i-FF; Sat, 12 Oct 2019 21:55:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dave Young <dyoung@redhat.com>
Cc:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
References: <20191012022140.19003-1-lijiang@redhat.com>
        <20191012022140.19003-4-lijiang@redhat.com>
        <87d0f22oi5.fsf@x220.int.ebiederm.org>
        <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
Date:   Sat, 12 Oct 2019 22:54:31 -0500
In-Reply-To: <20191012121625.GA11587@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Sat, 12 Oct 2019 20:16:25 +0800")
Message-ID: <87zhi51ers.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iJUyY-00065i-FF;;;mid=<87zhi51ers.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+s5R6SpUB0IGSO3ZKNcUhuOM1lCEV5wWg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dave Young <dyoung@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 591 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.4 (0.6%), b_tie_ro: 2.2 (0.4%), parse: 1.33
        (0.2%), extract_message_metadata: 6 (0.9%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-1000: 3.9 (0.7%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 30 (5.0%), check_bayes: 28
        (4.7%), b_tokenize: 10 (1.6%), b_tok_get_all: 9 (1.6%), b_comp_prob:
        3.0 (0.5%), b_tok_touch_all: 3.9 (0.7%), b_finish: 0.71 (0.1%),
        tests_pri_0: 523 (88.5%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        3.3 (0.6%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the backup region
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Young <dyoung@redhat.com> writes:

> Hi Eric,
>
> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>> Lianbo Jiang <lijiang@redhat.com> writes:
>> 
>> > When the crashkernel kernel command line option is specified, the
>> > low 1MiB memory will always be reserved, which makes that the memory
>> > allocated later won't fall into the low 1MiB area, thereby, it's not
>> > necessary to create a backup region and also no need to copy the first
>> > 640k content to a backup region.
>> >
>> > Currently, the code related to the backup region can be safely removed,
>> > so lets clean up.
>> >
>> > Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> > ---
>> 
>> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> > index eb651fbde92a..cc5774fc84c0 100644
>> > --- a/arch/x86/kernel/crash.c
>> > +++ b/arch/x86/kernel/crash.c
>> > @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>> >  
>> >  #ifdef CONFIG_KEXEC_FILE
>> >  
>> > -static unsigned long crash_zero_bytes;
>> > -
>> >  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>> >  {
>> >  	unsigned int *nr_ranges = arg;
>> > @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>> >  {
>> >  	struct crash_mem *cmem = arg;
>> >  
>> > -	cmem->ranges[cmem->nr_ranges].start = res->start;
>> > -	cmem->ranges[cmem->nr_ranges].end = res->end;
>> > -	cmem->nr_ranges++;
>> > +	if (res->start >= SZ_1M) {
>> > +		cmem->ranges[cmem->nr_ranges].start = res->start;
>> > +		cmem->ranges[cmem->nr_ranges].end = res->end;
>> > +		cmem->nr_ranges++;
>> > +	} else if (res->end > SZ_1M) {
>> > +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>> > +		cmem->ranges[cmem->nr_ranges].end = res->end;
>> > +		cmem->nr_ranges++;
>> > +	}
>> 
>> What is going on with this chunk?  I can guess but this needs a clear
>> comment.
>
> Indeed it needs some code comment, this is based on some offline
> discussion.  cat /proc/vmcore will give a warning because ioremap is
> mapping the system ram.
>
> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
> kernel can use the low 1M memory because for example the trampoline
> code.
>
>> 
>> >  
>> >  	return 0;
>> >  }
>> 
>> > @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>> >  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>> >  	cmd.params = params;
>> >  
>> > -	/* Add first 640K segment */
>> > -	ei.addr = image->arch.backup_src_start;
>> > -	ei.size = image->arch.backup_src_sz;
>> > +	/*
>> > +	 * Add the low memory range[0x1000, SZ_1M], skip
>> > +	 * the first zero page.
>> > +	 */
>> > +	ei.addr = PAGE_SIZE;
>> > +	ei.size = SZ_1M - PAGE_SIZE;
>> >  	ei.type = E820_TYPE_RAM;
>> >  	add_e820_entry(params, &ei);
>> 
>> Likewise here.  Why do we need a special case?
>> Why the magic with PAGE_SIZE?
>
> Good catch, the zero page part is useless, I think no other special
> reason, just assumed zero page is not usable, but it should be ok to
> remove the special handling, just pass 0 - 1M is good enough.

But if we have stopped special casing the low 1M.  Why do we need a
special case here at all?

If you need the special case it is almost certainly wrong to say you
have ram above 640KiB and below 1MiB.  That is the legacy ROM and video
MMIO area.

There is a reason the original code said 640KiB.

Eric
