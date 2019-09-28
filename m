Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528BBC0F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 04:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfI1Ccy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 22:32:54 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53821 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfI1Ccy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 22:32:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iE2XR-0002Vh-Og; Fri, 27 Sep 2019 20:32:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iE2XR-00059p-0e; Fri, 27 Sep 2019 20:32:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>
References: <20190920035326.27212-1-lijiang@redhat.com>
        <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
        <87r241piqg.fsf@x220.int.ebiederm.org>
        <20190928000505.GJ31919@MiWiFi-R3L-srv>
Date:   Fri, 27 Sep 2019 21:32:16 -0500
In-Reply-To: <20190928000505.GJ31919@MiWiFi-R3L-srv> (Baoquan He's message of
        "Sat, 28 Sep 2019 08:05:05 +0800")
Message-ID: <875zldp2vj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iE2XR-00059p-0e;;;mid=<875zldp2vj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18cKlj+RxELBQM4X5UB6lrbfTM/kZbSpoA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_09,XMSubLong,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_09 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 326 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.5 (1.1%), b_tie_ro: 2.4 (0.7%), parse: 0.65
        (0.2%), extract_message_metadata: 3.0 (0.9%), get_uri_detail_list:
        1.43 (0.4%), tests_pri_-1000: 3.4 (1.0%), tests_pri_-950: 1.41 (0.4%),
        tests_pri_-900: 1.21 (0.4%), tests_pri_-90: 25 (7.8%), check_bayes: 24
        (7.3%), b_tokenize: 7 (2.0%), b_tok_get_all: 9 (2.7%), b_comp_prob:
        2.4 (0.7%), b_tok_touch_all: 3.3 (1.0%), b_finish: 0.71 (0.2%),
        tests_pri_0: 273 (83.7%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.3 (0.7%), poll_dns_idle: 0.67 (0.2%), tests_pri_10:
        2.2 (0.7%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer when SME was active
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 09/27/19 at 03:49pm, Eric W. Biederman wrote:
>> Dave Young <dyoung@redhat.com> writes:
>> >> In order to avoid such problem, lets occupy the first 640k region when
>> >> SME is active, which will ensure that the allocated memory does not fall
>> >> into the first 640k area. So, no need to worry about whether kernel can
>> >> correctly copy the contents of the first 640K area to a backup region in
>> >> purgatory().
>> 
>> We must occupy part of the first 640k so that we can start up secondary
>> cpus unless someone has added another way to do that in recent years on
>> SME capable cpus.
>> 
>> Further there is Fimware/BIOS interaction that happens within those
>> first 640K.
>> 
>> Furthermore the kdump kernel needs to be able to read all of the memory
>> that the previous kernel could read.  Otherwise we can't get a crash
>> dump.
>> 
>> So I do not think ignoring the first 640K is the correct resolution
>> here.
>> 
>> > The log is too simple,  I know you did some other tries to fix this, but
>> > the patch log does not show why you can not correctly copy the 640k in
>> > current kdump code, in purgatory here.
>> >
>> > Also this patch seems works in your test, but still to see if other
>> > people can comment and see if it is safe or not, if any other risks
>> > other than waste the small chunk of memory.  If it is safe then kdump
>> > can just drop the backup logic and use this in common code instead of
>> > only do it for SME.
>> 
>> Exactly.
>> 
>> I think at best this avoids the symptoms, but does not give a reliable
>> crash dump.
>
> Sorry, didn't notice this comment at bottom.
>
> From code, currently the first 640K area is needed in two places.
> One is for 5-level trampoline during boot compressing stage, in
> find_trampoline_placement(). 
>
> The other is in reserve_real_mode(), as you mentioned, for application
> CPU booting.
>
> Only allow these two put data inside first 640K, then lock it done. It
> should not impact crash dump and parsing. And these two's content
> doesn't matter.

Apologies.  Do I understand correctly that the idea is that the kernel
that may crash will never touch these pages?  And that the reservation
is not in the kernel that recovers from the crash?  That definitely
needs a little better description.  I know it is not a lot on modern
systems but reserving an extra 1M of memory to avoid having to special
case it later seems in need of calling out.

I have an old system around that I think that 640K is about 25% of
memory.

How we interact with BIOS tables in the first 640k needs some
explanation.  Both in the first kernel and in the crash kernel.

Eric
