Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF12FAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfE3Lek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 07:34:40 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43520 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE3Lek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:34:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWJKQ-0000Em-VG; Thu, 30 May 2019 05:34:39 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWJKO-0006Qe-QZ; Thu, 30 May 2019 05:34:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190530153316.60907d8f@canb.auug.org.au>
Date:   Thu, 30 May 2019 06:34:31 -0500
In-Reply-To: <20190530153316.60907d8f@canb.auug.org.au> (Stephen Rothwell's
        message of "Thu, 30 May 2019 15:33:16 +1000")
Message-ID: <87lfyoxjjs.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hWJKO-0006Qe-QZ;;;mid=<87lfyoxjjs.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hppo6812nckxwl1zXuK7D0VioxNqVA10=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4855]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1755 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.2%), b_tie_ro: 1.95 (0.1%), parse: 1.03
        (0.1%), extract_message_metadata: 12 (0.7%), get_uri_detail_list: 0.93
        (0.1%), tests_pri_-1000: 4.2 (0.2%), tests_pri_-950: 1.36 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 16 (0.9%), check_bayes: 14
        (0.8%), b_tokenize: 4.2 (0.2%), b_tok_get_all: 4.0 (0.2%),
        b_comp_prob: 1.57 (0.1%), b_tok_touch_all: 2.4 (0.1%), b_finish: 0.64
        (0.0%), tests_pri_0: 165 (9.4%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 1531 (87.2%),
        tests_pri_10: 2.1 (0.1%), tests_pri_500: 1546 (88.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: linux-next: build warning after merge of the userns tree
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Eric,
>
> After merging the userns tree, today's linux-next build (i386 defconfig)
> produced this warning:
>
> arch/x86/mm/fault.c: In function 'do_sigbus':
> arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk' [-Wunused-variable]
>   struct task_struct *tsk = current;
>                       ^~~
>
> Introduced by commit
>
>   351b6825b3a9 ("signal: Explicitly call force_sig_fault on current")
>
> The remaining used of "tsk" are protected by CONFIG_MEMORY_FAILURE.

Yes.  Thank you.  I will add a commit to move tsk inside
CONFIG_MEMORY_FAILURE.

Eric

