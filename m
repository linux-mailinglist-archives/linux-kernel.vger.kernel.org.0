Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE69393E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfFGSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:03:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfFGSDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:03:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZJCg-0000wP-E8; Fri, 07 Jun 2019 12:03:02 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZJCf-0000GN-HK; Fri, 07 Jun 2019 12:03:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@aculab.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Eric Wong <e@80x24.org>, linux-aio@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190607103122.GA22167@redhat.com>
        <20190607103154.GA22159@redhat.com>
        <CAHk-=wjzU4MmVomodhTVSWnKUxKOBpvhdXgf1_riBtSwZuwMSg@mail.gmail.com>
        <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com>
Date:   Fri, 07 Jun 2019 13:02:50 -0500
In-Reply-To: <CAHk-=wif34nPB2uzU2YBXXYe5cFZhoLmU_zOtExd74X1WcYXJg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 7 Jun 2019 10:37:27 -0700")
Message-ID: <87imthclyt.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZJCf-0000GN-HK;;;mid=<87imthclyt.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LaBG0WsnybgxQHMjPvl4DUw1XVaU+Nt0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMGappySubj_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4993]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 430 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.74 (0.4%), parse: 1.30
        (0.3%), extract_message_metadata: 15 (3.6%), get_uri_detail_list: 1.06
        (0.2%), tests_pri_-1000: 19 (4.3%), tests_pri_-950: 1.78 (0.4%),
        tests_pri_-900: 1.43 (0.3%), tests_pri_-90: 22 (5.2%), check_bayes: 20
        (4.7%), b_tokenize: 8 (1.9%), b_tok_get_all: 5 (1.2%), b_comp_prob:
        2.5 (0.6%), b_tok_touch_all: 2.0 (0.5%), b_finish: 0.72 (0.2%),
        tests_pri_0: 279 (64.9%), check_dkim_signature: 0.70 (0.2%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        4.8 (1.1%), tests_pri_500: 79 (18.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] aio: simplify the usage of restore_saved_sigmask_unless()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 7, 2019 at 10:33 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Are they actually nonrestartable? I think the current EINTR is just a mistake.
>
> Oh, I guess they are, because of the relative timeout thing that
> shouldn't reset to the original value.
>
> And I don't think this is worth a ERESTAR_RESTARTTBLOCK.

Unless I am misreading things io_pgetevents isn't restartable
either and ERESTARTNOHAND is a bug in that case.

Is the bug going the other way?

Eric
