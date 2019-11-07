Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A777F34E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfKGQp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:45:29 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46490 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfKGQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:45:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iSkuV-0002be-08; Thu, 07 Nov 2019 09:45:27 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iSkuT-0000Il-F4; Thu, 07 Nov 2019 09:45:26 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Willy Tarreau <w@1wt.eu>
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191106193459.581614484@linutronix.de>
        <20191106202806.241007755@linutronix.de>
        <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
        <20191107082541.GF30739@gmail.com> <20191107091704.GA15536@1wt.eu>
        <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
        <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com>
        <20191107102756.GD15536@1wt.eu>
        <5AAEF116-EC9D-4C58-878F-9D27189E123A@zytor.com>
        <20191107125638.GB15642@1wt.eu>
Date:   Thu, 07 Nov 2019 10:45:09 -0600
In-Reply-To: <20191107125638.GB15642@1wt.eu> (Willy Tarreau's message of "Thu,
        7 Nov 2019 13:56:38 +0100")
Message-ID: <87h83fd4a2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iSkuT-0000Il-F4;;;mid=<87h83fd4a2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xgL3tAqiNSAGXW1BXqYlMObhsRFFKuX8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_SpammyTLD autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2860]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XM_B_SpammyTLD Contains uncommon/spammy TLD
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Willy Tarreau <w@1wt.eu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 986 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.3%), b_tie_ro: 1.78 (0.2%), parse: 0.61
        (0.1%), extract_message_metadata: 11 (1.1%), get_uri_detail_list: 0.94
        (0.1%), tests_pri_-1000: 9 (0.9%), tests_pri_-950: 1.12 (0.1%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 18 (1.8%), check_bayes: 17
        (1.7%), b_tokenize: 4.8 (0.5%), b_tok_get_all: 6 (0.6%), b_comp_prob:
        1.56 (0.2%), b_tok_touch_all: 2.5 (0.3%), b_finish: 0.59 (0.1%),
        tests_pri_0: 222 (22.5%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 707 (71.6%), tests_pri_10:
        1.63 (0.2%), tests_pri_500: 718 (72.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Thu, Nov 07, 2019 at 02:50:20AM -0800, hpa@zytor.com wrote:
>> You get access to the ports you are assigned, just like pages you are
>> assigned... the rest is kernel policy, or, for that matter, privileged
>> userspace (get permissions to the necessary ports, then drop privilege... the
>> usual stuff.)
>
> I agree, my point is that there's already no policy checking at the
> moment ports are assigned, hence a process having the permissions to
> request just port 0x70-0x71 to read the hwclock will also have permission
> to request access to the sensor chip a 0x2E and trigger a watchdog
> reset or stop the CPU fan. Thus any policy enforcement is solely done
> by the requesting process itself, assuming it doesn't simply use iopl()
> already, which grants everything.
>
> This is why I'm really wondering if the real use cases that need all
> this stuff still exist at all in practice.

My memory is that the applications that didn't need fine grain access to
ports would just use iopl.

Further a quick look shows that dosemu uses ioperm in a fine grained
manner.  From memory it would allow a handful of ports to allow directly
accessing a device and depended on the rest of the port accesses to be
disallowed so it could trap and emulate them.

So yes I do believe making ioperm ioperm(all) will break userspace.

Eric

