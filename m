Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9219416B37E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 23:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgBXWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 17:01:55 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57726 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:01:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LnU-0002wT-Gz; Mon, 24 Feb 2020 15:01:52 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LnT-0001Jy-Q0; Mon, 24 Feb 2020 15:01:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Feng Tang <feng.tang@intel.com>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang\, Ying" <ying.huang@intel.com>
References: <20200205123216.GO12867@shao2-debian>
        <20200205125804.GM14879@hirez.programming.kicks-ass.net>
        <20200221080325.GA67807@shbuild999.sh.intel.com>
        <20200221132048.GE652992@krava>
        <20200223141147.GA53531@shbuild999.sh.intel.com>
        <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
        <20200224003301.GA5061@shbuild999.sh.intel.com>
        <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
        <20200224021915.GC5061@shbuild999.sh.intel.com>
        <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
        <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
        <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
        <87a757znqd.fsf@x220.int.ebiederm.org>
        <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
Date:   Mon, 24 Feb 2020 15:59:49 -0600
In-Reply-To: <CAHk-=wh0z0LErNzwe-AqrEkv3BNzJep58Qmi2dM775UPtmq0og@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 24 Feb 2020 13:43:02 -0800")
Message-ID: <8736azzlwq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6LnT-0001Jy-Q0;;;mid=<8736azzlwq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/MXa+JssMEncMrZMpgoryMCXD2Md2TvzQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 326 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.8%), b_tie_ro: 1.87 (0.6%), parse: 1.30
        (0.4%), extract_message_metadata: 15 (4.5%), get_uri_detail_list: 1.40
        (0.4%), tests_pri_-1000: 24 (7.4%), tests_pri_-950: 1.22 (0.4%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 27 (8.2%), check_bayes: 25
        (7.8%), b_tokenize: 9 (2.6%), b_tok_get_all: 9 (2.7%), b_comp_prob:
        2.7 (0.8%), b_tok_touch_all: 3.0 (0.9%), b_finish: 0.65 (0.2%),
        tests_pri_0: 240 (73.6%), check_dkim_signature: 0.51 (0.2%),
        check_dkim_adsp: 2.1 (0.6%), poll_dns_idle: 0.55 (0.2%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 9 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops -5.5% regression
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Feb 24, 2020 at 1:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I keep looking at your patch and wondering if there isn't a way
>> to remove the uid refcount entirely on this path.
>
> I agree. I tried to come up with something, but couldn't.
>
>> Linus I might be wrong but I have this sense that your change will only
>> help when signal delivery is backed up.  I expect in the common case
>> there won't be any pending signals outstanding for the user.
>
> Again, 100% agreed.
>
> HOWEVER.
>
> The normal case where there's one only signal pending is also the case
> where we don't care about the extra atomic RMW access. By definition
> that's not going to ever going to show up as a performance issue or
> for cacheline contention.
>
> So the only case that matters from a performance standpoint is the
> "lots of signals" case, in which case you'll see that sigqueue become
> backed up.
>
> But as I said in the original thread (before you got added to the list):
>
>  "I don't know. This does not seem to be a particularly serious load."
>
> I'm not convinced this will show up outside of this kind of
> signal-sending microbenchmark.
>
> That said, I don't really see any downside to the patch either, so...

Other than scratching my head about why are we optimizing neither do I.

It would help to have a comment somewhere in the code or the commit
message that says the issue is contetion under load.  So the next time
someone goes through the code and goes why aren't we doing the stupid
and simple thing it will be clear.

Eric
