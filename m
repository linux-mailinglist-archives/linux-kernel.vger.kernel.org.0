Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1362142E76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFLST1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 14:19:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54425 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFLST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:19:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb7qG-0004DB-Ua; Wed, 12 Jun 2019 12:19:25 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb7qF-0000Qn-JJ; Wed, 12 Jun 2019 12:19:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190612175543.GO32652@zn.tnic> (Borislav Petkov's message of
        "Wed, 12 Jun 2019 19:55:43 +0200")
References: <1559338641-6145-1-git-send-email-cai@lca.pw>
        <20190612175543.GO32652@zn.tnic>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Wed, 12 Jun 2019 13:19:06 -0500
Message-ID: <87a7emy8dh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb7qF-0000Qn-JJ;;;mid=<87a7emy8dh.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7rkvNfWVNsDvrLU2jOC4FkVsErnjkXHU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_Palau_URI autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  5.0 XM_Palau_URI RAW: Palau .pw URI
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Borislav Petkov <bp@alien8.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 808 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.3%), b_tie_ro: 1.81 (0.2%), parse: 0.77
        (0.1%), extract_message_metadata: 17 (2.1%), get_uri_detail_list: 1.80
        (0.2%), tests_pri_-1000: 24 (3.0%), tests_pri_-950: 1.90 (0.2%),
        tests_pri_-900: 1.89 (0.2%), tests_pri_-90: 34 (4.3%), check_bayes: 32
        (4.0%), b_tokenize: 12 (1.4%), b_tok_get_all: 8 (1.0%), b_comp_prob:
        2.8 (0.3%), b_tok_touch_all: 6 (0.7%), b_finish: 2.1 (0.3%),
        tests_pri_0: 406 (50.2%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 299 (37.0%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 314 (38.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] x86/mm: fix an unused variable "tsk" warning
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Fri, May 31, 2019 at 05:37:21PM -0400, Qian Cai wrote:
>> Since the commit "signal: Remove the task parameter from
>> force_sig_fault", "tsk" is only used when MEMORY_FAILURE=y and generates
>> a compilation warning without it.
>> 
>> arch/x86/mm/fault.c: In function 'do_sigbus':
>> arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk'
>> [-Wunused-variable]
>> 
>> Also, change to use IS_ENABLED() instead.
>> 
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>  arch/x86/mm/fault.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 46ac96aa7c81..40d70bd3fa84 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1014,8 +1014,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>  do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>>  	  vm_fault_t fault)
>>  {
>> -	struct task_struct *tsk = current;
>> -
>>  	/* Kernel mode? Handle exceptions or die: */
>>  	if (!(error_code & X86_PF_USER)) {
>>  		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
>> @@ -1028,9 +1026,10 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>  
>>  	set_signal_archinfo(address, error_code);
>>  
>> -#ifdef CONFIG_MEMORY_FAILURE
>> -	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
>> +	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
>> +	    (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))) {
>>  		unsigned lsb = 0;
>> +		struct task_struct *tsk = current;
>>  
>>  		pr_err(
>>  	"MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>> @@ -1042,7 +1041,6 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
>>  		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
>>  		return;
>>  	}
>> -#endif
>>  	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
>>  }
>>  
>> -- 
>
> I was puzzled just like Dave because this code is not in tip.
>
> Turns out there's this in linux-next:
>
> commit 318759b4737c3b3789e2fd64d539f437d52386f5
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Mon Jun 3 10:23:58 2019 -0500
>
>     signal/x86: Move tsk inside of CONFIG_MEMORY_FAILURE in do_sigbus

Since I am removing the tsk parameter from all of the synchrnous signal
sending functions, on all of the architectures it was easier to go
through my own tree than -tip.

The removal of tsk from force_sig_fault is what caused the warning
in do_sigbus.

My apologies I was a little slow in getting that patch added and
generating work for other folks.

Eric
