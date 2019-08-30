Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7745A3E95
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 21:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfH3Tq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 15:46:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55567 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfH3Tq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:46:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i3mqo-0002rY-QA; Fri, 30 Aug 2019 13:46:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i3mqC-0002tz-B5; Fri, 30 Aug 2019 13:46:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, bhelgaas@google.com, tglx@linutronix.de,
        sakari.ailus@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1567171877-101949-1-git-send-email-jingxiangfeng@huawei.com>
        <20190830133522.GZ13294@shell.armlinux.org.uk>
Date:   Fri, 30 Aug 2019 14:45:36 -0500
In-Reply-To: <20190830133522.GZ13294@shell.armlinux.org.uk> (Russell King's
        message of "Fri, 30 Aug 2019 14:35:22 +0100")
Message-ID: <87d0gmwi73.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i3mqC-0002tz-B5;;;mid=<87d0gmwi73.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18NMO9dKN/ZIv2eAbj5eODKvFQtgC+w5Xg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Russell King - ARM Linux admin <linux@armlinux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 28028 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 15020 (53.6%), b_tie_ro: 20027 (71.5%), parse:
        1.04 (0.0%), extract_message_metadata: 15 (0.1%), get_uri_detail_list:
        2.1 (0.0%), tests_pri_-1000: 11 (0.0%), tests_pri_-950: 1.01 (0.0%),
        tests_pri_-900: 0.86 (0.0%), tests_pri_-90: 20 (0.1%), check_bayes: 19
        (0.1%), b_tokenize: 6 (0.0%), b_tok_get_all: 7 (0.0%), b_comp_prob:
        1.57 (0.0%), b_tok_touch_all: 3.0 (0.0%), b_finish: 0.56 (0.0%),
        tests_pri_0: 228 (0.8%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 2.1 (0.0%), poll_dns_idle: 7704 (27.5%),
        tests_pri_10: 1.67 (0.0%), tests_pri_500: 7718 (27.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] arm: fix page faults in do_alignment
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux admin <linux@armlinux.org.uk> writes:

> On Fri, Aug 30, 2019 at 09:31:17PM +0800, Jing Xiangfeng wrote:
>> The function do_alignment can handle misaligned address for user and
>> kernel space. If it is a userspace access, do_alignment may fail on
>> a low-memory situation, because page faults are disabled in
>> probe_kernel_address.
>> 
>> Fix this by using __copy_from_user stead of probe_kernel_address.
>> 
>> Fixes: b255188 ("ARM: fix scheduling while atomic warning in alignment handling code")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>
> NAK.
>
> The "scheduling while atomic warning in alignment handling code" is
> caused by fixing up the page fault while trying to handle the
> mis-alignment fault generated from an instruction in atomic context.
>
> Your patch re-introduces that bug.

And the patch that fixed scheduling while atomic apparently introduced a
regression.  Admittedly a regression that took 6 years to track down but
still.

So it looks like the code needs to do something like:

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 04b36436cbc0..5e2b8623851e 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -784,6 +784,9 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	instrptr = instruction_pointer(regs);
 
+	if (user_mode(regs))
+		goto user;
+
 	if (thumb_mode(regs)) {
 		u16 *ptr = (u16 *)(instrptr & ~1);
 		fault = probe_kernel_address(ptr, tinstr);
@@ -933,6 +936,34 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 
  user:
+	if (thumb_mode(regs)) {
+		u16 *ptr = (u16 *)(instrptr & ~1);
+		fault = get_user(tinstr, ptr);
+		tinstr = __mem_to_opcode_thumb16(tinstr);
+		if (!fault) {
+			if (cpu_architecture() >= CPU_ARCH_ARMv7 &&
+			    IS_T32(tinstr)) {
+				/* Thumb-2 32-bit */
+				u16 tinst2 = 0;
+				fault = get_user(ptr + 1, tinst2);
+				tinst2 = __mem_to_opcode_thumb16(tinst2);
+				instr = __opcode_thumb32_compose(tinstr, tinst2);
+				thumb2_32b = 1;
+			} else {
+				isize = 2;
+				instr = thumb2arm(tinstr);
+			}
+		}
+	} else {
+		fault = get_user(instr, (u32*)instrptr);
+		instr = __mem_to_opcode_arm(instr);
+	}
+
+	if (fault) {
+		type = TYPE_FAULT;
+		goto bad_or_fault;
+	}
+
 	ai_user += 1;
 
 	if (ai_usermode & UM_WARN)

Eric
