Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93112EA53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 03:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfE3BmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 21:42:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59238 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfE3BmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:42:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWA4v-0007nJ-B8; Wed, 29 May 2019 19:42:01 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hWA4u-0002xz-TG; Wed, 29 May 2019 19:42:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20190529113157.227380-1-jannh@google.com>
        <20190529162120.GB27659@redhat.com>
        <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
Date:   Wed, 29 May 2019 20:41:55 -0500
In-Reply-To: <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
        (Jann Horn's message of "Wed, 29 May 2019 19:38:46 +0200")
Message-ID: <87ef4gzpjw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hWA4u-0002xz-TG;;;mid=<87ef4gzpjw.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18wE3UcoodFH/eDBPD7tiynOAUoebLOnZ4=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3336]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 152 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.3 (1.5%), b_tie_ro: 1.62 (1.1%), parse: 0.57
        (0.4%), extract_message_metadata: 1.84 (1.2%), get_uri_detail_list:
        0.55 (0.4%), tests_pri_-1000: 2.9 (1.9%), tests_pri_-950: 1.07 (0.7%),
        tests_pri_-900: 0.89 (0.6%), tests_pri_-90: 14 (9.1%), check_bayes: 13
        (8.3%), b_tokenize: 3.4 (2.3%), b_tok_get_all: 4.3 (2.8%),
        b_comp_prob: 1.12 (0.7%), b_tok_touch_all: 2.2 (1.4%), b_finish: 0.51
        (0.3%), tests_pri_0: 116 (76.5%), check_dkim_signature: 0.34 (0.2%),
        check_dkim_adsp: 2.1 (1.4%), poll_dns_idle: 0.84 (0.6%), tests_pri_10:
        1.76 (1.2%), tests_pri_500: 4.9 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> I'm actually trying to get rid of the ->mm access in
> __ptrace_may_access() entirely by moving the dumpability and the
> user_ns into the signal_struct, but I don't have patches for that
> ready (yet).

Do you have a plan for dealing with old linux-threads style threads
where you have two processes that share the same mm, but have different
signal_structs.

I don't think it is required to share any other structures except
mm_struct when you share mm_struct.  Maybe sighand_struct.

Not to derail your idea.  Only needing to look at signal_struct sounds
very nice.  I just know we have some other somewhat bizarre cases the
kernel still supports.

Eric



