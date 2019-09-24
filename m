Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA25BCB63
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbfIXP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 11:29:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52912 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfIXP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:29:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCmkc-00068z-BI; Tue, 24 Sep 2019 09:29:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCmkb-0003bd-K5; Tue, 24 Sep 2019 09:29:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20190922115247.GA2679387@kroah.com>
        <20190923200818.GA116090@gmail.com> <20190924113135.GA82089@gmail.com>
Date:   Tue, 24 Sep 2019 10:28:45 -0500
In-Reply-To: <20190924113135.GA82089@gmail.com> (Ingo Molnar's message of
        "Tue, 24 Sep 2019 13:31:35 +0200")
Message-ID: <874l11u30y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iCmkb-0003bd-K5;;;mid=<874l11u30y.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mve6moSKjF+aBwF5knbG1Diii4/8YKDM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 295 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 5 (1.8%), b_tie_ro: 3.8 (1.3%), parse: 1.08
        (0.4%), extract_message_metadata: 3.8 (1.3%), get_uri_detail_list:
        1.09 (0.4%), tests_pri_-1000: 4.0 (1.4%), tests_pri_-950: 1.64 (0.6%),
        tests_pri_-900: 1.45 (0.5%), tests_pri_-90: 21 (7.0%), check_bayes: 19
        (6.4%), b_tokenize: 4.1 (1.4%), b_tok_get_all: 6 (2.1%), b_comp_prob:
        2.0 (0.7%), b_tok_touch_all: 3.4 (1.1%), b_finish: 0.85 (0.3%),
        tests_pri_0: 240 (81.5%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.5 (0.9%), poll_dns_idle: 0.95 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 6 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [Tree, v2] De-clutter the top level directory, move ipc/ => kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

>  - Split it into finer grained steps (3 instead of 2 patches per 
>    movement), for easier review and bisection testing:
>
>      toplevel: Move ipc/ to kernel/ipc/: move the files
>      toplevel: Move ipc/ to kernel/ipc/: adjust the build system
>      toplevel: Move ipc/ to kernel/ipc/: adjust comments and documentation

Can we not mess with ipc/ please.

I know that will mess with my muscle memory and I don't see the point.
Especially as long as it is named ipc and not sysvipc.

A half cleanup really looks worse than a real cleanup.

SysV IPC really is a side car on the kernel and on unix in general
and having the directory structure reflect that seems completely sensible.

Eric
