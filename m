Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28897B3C93
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbfIPObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 10:31:48 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44705 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388666AbfIPObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:31:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9s2a-0007wn-L6; Mon, 16 Sep 2019 08:31:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i9s2W-0008LR-Nc; Mon, 16 Sep 2019 08:31:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     kstewart@linuxfoundation.org, gustavo@embeddedor.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jing Xiangfeng <jingxiangfeng@huawei.com>, linux-mm@kvack.org,
        sakari.ailus@linux.intel.com, bhelgaas@google.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
        <20190830133522.GZ13294@shell.armlinux.org.uk>
        <87d0gmwi73.fsf@x220.int.ebiederm.org>
        <20190830203052.GG13294@shell.armlinux.org.uk>
        <87y2zav01z.fsf@x220.int.ebiederm.org>
        <20190830222906.GH13294@shell.armlinux.org.uk>
        <87mufmioqv.fsf@x220.int.ebiederm.org>
        <20190906151759.GM13294@shell.armlinux.org.uk>
        <20190915183416.GF25745@shell.armlinux.org.uk>
Date:   Mon, 16 Sep 2019 09:31:20 -0500
In-Reply-To: <20190915183416.GF25745@shell.armlinux.org.uk> (Russell King's
        message of "Sun, 15 Sep 2019 19:34:17 +0100")
Message-ID: <87pnk09utj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i9s2W-0008LR-Nc;;;mid=<87pnk09utj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/1FBeXbdxe/EgVxqKW7BQr0CbwMPFJQgQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_14 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Russell King - ARM Linux admin <linux@armlinux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3533 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 4.2 (0.1%), b_tie_ro: 2.6 (0.1%), parse: 2.9
        (0.1%), extract_message_metadata: 37 (1.1%), get_uri_detail_list: 9
        (0.3%), tests_pri_-1000: 7 (0.2%), tests_pri_-950: 1.75 (0.0%),
        tests_pri_-900: 1.57 (0.0%), tests_pri_-90: 77 (2.2%), check_bayes: 75
        (2.1%), b_tokenize: 34 (1.0%), b_tok_get_all: 18 (0.5%), b_comp_prob:
        9 (0.3%), b_tok_touch_all: 5.0 (0.1%), b_finish: 0.78 (0.0%),
        tests_pri_0: 813 (23.0%), check_dkim_signature: 0.87 (0.0%),
        check_dkim_adsp: 4.3 (0.1%), poll_dns_idle: 2556 (72.4%),
        tests_pri_10: 2.1 (0.1%), tests_pri_500: 2580 (73.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] arm: fix page faults in do_alignment
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Fri, Sep 06, 2019 at 04:17:59PM +0100, Russell King - ARM Linux admin wrote:
>> On Mon, Sep 02, 2019 at 12:36:56PM -0500, Eric W. Biederman wrote:
>> > Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
>> > 
>> > > On Fri, Aug 30, 2019 at 04:02:48PM -0500, Eric W. Biederman wrote:
>> > >> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
>> > >> 
>> > >> > On Fri, Aug 30, 2019 at 02:45:36PM -0500, Eric W. Biederman wrote:
>> > >> >> Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:
>> > >> >> 
>> > >> >> > On Fri, Aug 30, 2019 at 09:31:17PM +0800, Jing Xiangfeng wrote:
>> > >> >> >> The function do_alignment can handle misaligned address for user and
>> > >> >> >> kernel space. If it is a userspace access, do_alignment may fail on
>> > >> >> >> a low-memory situation, because page faults are disabled in
>> > >> >> >> probe_kernel_address.
>> > >> >> >> 
>> > >> >> >> Fix this by using __copy_from_user stead of probe_kernel_address.
>> > >> >> >> 
>> > >> >> >> Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
>> > >> >> >> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> > >> >> >
>> > >> >> > NAK.
>> > >> >> >
>> > >> >> > The "scheduling while atomic warning in alignment handling code" is
>> > >> >> > caused by fixing up the page fault while trying to handle the
>> > >> >> > mis-alignment fault generated from an instruction in atomic context.
>> > >> >> >
>> > >> >> > Your patch re-introduces that bug.
>> > >> >> 
>> > >> >> And the patch that fixed scheduling while atomic apparently introduced a
>> > >> >> regression.  Admittedly a regression that took 6 years to track down but
>> > >> >> still.
>> > >> >
>> > >> > Right, and given the number of years, we are trading one regression for
>> > >> > a different regression.  If we revert to the original code where we
>> > >> > fix up, we will end up with people complaining about a "new" regression
>> > >> > caused by reverting the previous fix.  Follow this policy and we just
>> > >> > end up constantly reverting the previous revert.
>> > >> >
>> > >> > The window is very small - the page in question will have had to have
>> > >> > instructions read from it immediately prior to the handler being entered,
>> > >> > and would have had to be made "old" before subsequently being unmapped.
>> > >> 
>> > >> > Rather than excessively complicating the code and making it even more
>> > >> > inefficient (as in your patch), we could instead retry executing the
>> > >> > instruction when we discover that the page is unavailable, which should
>> > >> > cause the page to be paged back in.
>> > >> 
>> > >> My patch does not introduce any inefficiencies.  It onlys moves the
>> > >> check for user_mode up a bit.  My patch did duplicate the code.
>> > >> 
>> > >> > If the page really is unavailable, the prefetch abort should cause a
>> > >> > SEGV to be raised, otherwise the re-execution should replace the page.
>> > >> >
>> > >> > The danger to that approach is we page it back in, and it gets paged
>> > >> > back out before we're able to read the instruction indefinitely.
>> > >> 
>> > >> I would think either a little code duplication or a function that looks
>> > >> at user_mode(regs) and picks the appropriate kind of copy to do would be
>> > >> the best way to go.  Because what needs to happen in the two cases for
>> > >> reading the instruction are almost completely different.
>> > >
>> > > That is what I mean.  I'd prefer to avoid that with the large chunk of
>> > > code.  How about instead adding a local replacement for
>> > > probe_kernel_address() that just sorts out the reading, rather than
>> > > duplicating all the code to deal with thumb fixup.
>> > 
>> > So something like this should be fine?
>> > 
>> > Jing Xiangfeng can you test this please?  I think this fixes your issue
>> > but I don't currently have an arm development box where I could test this.
>> 
>> Sorry, only just got around to this again.  What I came up with is this:
>
> I've heard nothing, so I've done nothing...

Sorry it wasn't clear you were looking for feedback.

This looks functionally equivalent to the last test version I posted and
that Jing Xiangfeng confirms solves his issue.

So I say please merge whichever version you like.

Eric

>> 8<===
>> From: Russell King <rmk+kernel@armlinux.org.uk>
>> Subject: [PATCH] ARM: mm: fix alignment
>> 
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> ---
>>  arch/arm/mm/alignment.c | 44 ++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 36 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
>> index 6067fa4de22b..529f54d94709 100644
>> --- a/arch/arm/mm/alignment.c
>> +++ b/arch/arm/mm/alignment.c
>> @@ -765,6 +765,36 @@ do_alignment_t32_to_handler(unsigned long *pinstr, struct pt_regs *regs,
>>  	return NULL;
>>  }
>>  
>> +static int alignment_get_arm(struct pt_regs *regs, u32 *ip, unsigned long *inst)
>> +{
>> +	u32 instr = 0;
>> +	int fault;
>> +
>> +	if (user_mode(regs))
>> +		fault = get_user(instr, ip);
>> +	else
>> +		fault = probe_kernel_address(ip, instr);
>> +
>> +	*inst = __mem_to_opcode_arm(instr);
>> +
>> +	return fault;
>> +}
>> +
>> +static int alignment_get_thumb(struct pt_regs *regs, u16 *ip, u16 *inst)
>> +{
>> +	u16 instr = 0;
>> +	int fault;
>> +
>> +	if (user_mode(regs))
>> +		fault = get_user(instr, ip);
>> +	else
>> +		fault = probe_kernel_address(ip, instr);
>> +
>> +	*inst = __mem_to_opcode_thumb16(instr);
>> +
>> +	return fault;
>> +}
>> +
>>  static int
>>  do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  {
>> @@ -772,10 +802,10 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  	unsigned long instr = 0, instrptr;
>>  	int (*handler)(unsigned long addr, unsigned long instr, struct pt_regs *regs);
>>  	unsigned int type;
>> -	unsigned int fault;
>>  	u16 tinstr = 0;
>>  	int isize = 4;
>>  	int thumb2_32b = 0;
>> +	int fault;
>>  
>>  	if (interrupts_enabled(regs))
>>  		local_irq_enable();
>> @@ -784,15 +814,14 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  
>>  	if (thumb_mode(regs)) {
>>  		u16 *ptr = (u16 *)(instrptr & ~1);
>> -		fault = probe_kernel_address(ptr, tinstr);
>> -		tinstr = __mem_to_opcode_thumb16(tinstr);
>> +
>> +		fault = alignment_get_thumb(regs, ptr, &tinstr);
>>  		if (!fault) {
>>  			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
>>  			    IS_T32(tinstr)) {
>>  				/* Thumb-2 32-bit */
>> -				u16 tinst2 = 0;
>> -				fault = probe_kernel_address(ptr + 1, tinst2);
>> -				tinst2 = __mem_to_opcode_thumb16(tinst2);
>> +				u16 tinst2;
>> +				fault = alignment_get_thumb(regs, ptr + 1, &tinst2);
>>  				instr = __opcode_thumb32_compose(tinstr, tinst2);
>>  				thumb2_32b = 1;
>>  			} else {
>> @@ -801,8 +830,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>>  			}
>>  		}
>>  	} else {
>> -		fault = probe_kernel_address((void *)instrptr, instr);
>> -		instr = __mem_to_opcode_arm(instr);
>> +		fault = alignment_get_arm(regs, (void *)instrptr, &instr);
>>  	}
>>  
>>  	if (fault) {
>> -- 
>> 2.7.4
>> 
>> -- 
>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
>> According to speedtest.net: 11.9Mbps down 500kbps up
>> 
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> 
