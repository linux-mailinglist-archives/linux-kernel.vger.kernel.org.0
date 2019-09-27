Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCF2C07E1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfI0OrO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Sep 2019 10:47:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40749 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0OrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:47:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDrWa-0002P9-9j; Fri, 27 Sep 2019 08:47:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iDrWY-0006x5-OG; Fri, 27 Sep 2019 08:47:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alun Evans <alun@badgerous.net>
Cc:     linux-kernel@vger.kernel.org
References: <m2o8z7t2w5.fsf@badgerous.net>
Date:   Fri, 27 Sep 2019 09:46:39 -0500
In-Reply-To: <m2o8z7t2w5.fsf@badgerous.net> (Alun Evans's message of "Thu, 26
        Sep 2019 09:53:46 -0700")
Message-ID: <871rw1yey8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iDrWY-0006x5-OG;;;mid=<871rw1yey8.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//5kEoUXOwG2hnZpNCU7HJLd/Oz0FPs+w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4189]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alun Evans <alun@badgerous.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 513 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 6 (1.2%), b_tie_ro: 5 (1.0%), parse: 0.82 (0.2%),
        extract_message_metadata: 21 (4.1%), get_uri_detail_list: 2.5 (0.5%),
        tests_pri_-1000: 16 (3.1%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 33 (6.5%), check_bayes: 32
        (6.2%), b_tokenize: 7 (1.4%), b_tok_get_all: 10 (2.0%), b_comp_prob:
        4.1 (0.8%), b_tok_touch_all: 7 (1.4%), b_finish: 0.79 (0.2%),
        tests_pri_0: 421 (82.0%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.62 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 05/27] containers: Open a socket inside a container
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alun Evans <alun@badgerous.net> writes:

> Hi Eric,
>
>
> On Tue, 19 Feb 2019, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> David Howells <dhowells@redhat.com> writes:
>>
>> > Provide a system call to open a socket inside of a container, using that
>> > container's network namespace.  This allows netlink to be used to manage
>> > the container.
>> >
>> > 	fd = container_socket(int container_fd,
>> > 			      int domain, int type, int protocol);
>> >
>>
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> Use a namespace file descriptor if you need this.  So far we have not
>> added this system call as it is just a performance optimization.  And it
>> has been too niche to matter.
>>
>> If this that has changed we can add this separately from everything else
>> you are doing here.
>
> I think I've found the niche.
>
>
> I'm trying to use network namespaces from Go.

Yes. Go sucks for this.

> Since setns is thread
> specific, I'm forced to use this pattern:
>
>     runtime.LockOSThread()
>     defer runtime.UnlockOSThread()
>     …
>     err = netns.Set(newns)
>
>
> This is only safe recently:
> https://github.com/vishvananda/netns/issues/17#issuecomment-367325770
>
> - but is still less than ideal performance wise, as it locks out other
>   socket operations.
>
> The socketat() / socketns() would be ideal:
>
>   https://lwn.net/Articles/406684/
>   https://lwn.net/Articles/407495/
>   https://lkml.org/lkml/2011/10/3/220
>
>
> One thing that is interesting, the LockOSThread works pretty well for
> receiving, since I can wrap it around the socket()/bind()/listen() at
> startup. Then accept() can run outside of the lock.
>
> It's creating new outbound tcp connections via socket()/connect() pairs
> that is the issue.

As I understand it you should be able to write socketat in go something like:

	runtime.LockOSThread()
        err = netns.Set(newns);
        fd = socket(...);
        err = netns.Set(defaultns);
	runtime.UnlockOSThread()

I have no real objections to a kernel system call doing that.  It has
just never risen to the level where it was necessary to optimize
userspace yet.

Eric



