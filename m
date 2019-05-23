Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2128BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfEWUyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:54:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55111 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387529AbfEWUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:54:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTujT-0007qS-V1; Thu, 23 May 2019 14:54:35 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTujS-0007N5-Qn; Thu, 23 May 2019 14:54:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1905231352200.1553-100000@iolanthe.rowland.org>
Date:   Thu, 23 May 2019 15:54:26 -0500
In-Reply-To: <Pine.LNX.4.44L0.1905231352200.1553-100000@iolanthe.rowland.org>
        (Alan Stern's message of "Thu, 23 May 2019 14:12:57 -0400 (EDT)")
Message-ID: <87ef4oevst.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTujS-0007N5-Qn;;;mid=<87ef4oevst.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188c5LUosfNPGRQ9/fs837sI2EaULcpvsw=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_12,XMGappySubj_01,XMGappySubj_02,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4787]
        *  1.0 XMGappySubj_02 Gappier still
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alan Stern <stern@rowland.harvard.edu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 706 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.6%), b_tie_ro: 3.0 (0.4%), parse: 0.92
        (0.1%), extract_message_metadata: 11 (1.6%), get_uri_detail_list: 2.6
        (0.4%), tests_pri_-1000: 9 (1.3%), tests_pri_-950: 1.36 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 27 (3.8%), check_bayes: 25
        (3.5%), b_tokenize: 7 (1.0%), b_tok_get_all: 9 (1.2%), b_comp_prob:
        2.5 (0.4%), b_tok_touch_all: 3.4 (0.5%), b_finish: 0.77 (0.1%),
        tests_pri_0: 458 (64.9%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.0 (0.4%), poll_dns_idle: 178 (25.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 188 (26.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 22 May 2019, Eric W. Biederman wrote:
>
>> Perhaps this will work as a diagram.  I don't know if there is a better
>> way to say it in my patch description.  In struct siginfo there are 3
>> fields in fixed positions:
>> 
>>    int si_signo;
>>    int si_errno;
>>    int si_code;
>> 
>> After that there is a union.  The si_signo and si_code fields are
>> examined to see which union member is valid (see siginfo_layout).
>> In every other case a si_code of SI_ASYNCIO corresponds to
>> the the _rt union member which has the fields:
>> 
>>    int si_pid;
>>    int si_uid;
>>    sigval_t si_sigval;
>
> Yuu mean it's actually a union of structures containing these fields,
> not a union of these fields, right?

Correct.

>> However when usb started using SI_ASYNCIO the _sigfault union member
>> that (except for special exceptions) only has the field:
>> 
>>    void __user *si_addr;
>> 
>> Or in short the relevant piece of the union looks like:
>> 
>>          0   1  2   3    4   5   6  7
>>        +---+---+---+---+---+---+---+---+
>>        |    si_pid     |   si_uid      |
>>        +---+---+---+---+---+---+---+---+
>>        |             si_addr           | (64bit)
>>        +---+---+---+---+---+---+---+---+
>>        |     si_addr   | (32bit)
>>        +---+---+---+---+
>> 
>> Which means if siginfo is copied field by field on 32bit everything
>> works because si_pid and si_addr are in the same location.
>
> When you say "copied field by field", you mean that the si_pid, 
> si_uid, and si_sigval values are copied individually?

At least historically.  I have cleaned things up so no on native
we can do a byte by byte copy.  But for the compat case we still
copy field by field so that we have a chance of translating the fields.

>> Similarly if siginfo is copied field by field on 64bit everything
>> works because there is no padding between si_pid and si_uid. So
>> copying both of those fields results in the entire si_addr being
>> copied.
>> 
>> It is the compat case that gets tricky.  Half of the bits are
>> zero.  If those zero bits show up in bytes 4-7 and the data
>> shows up in bytes 0-3 (aka little endian) everything works.
>> If those zero bits show in in bytes 0-3 (aka big endian) userspace sees
>> a NULL pointer instead of the value it passed.
>
> The problem is that the compat translation layer copies si_pid and 
> si_uid from the 64-bit kernel structure to the 32-bit user structure.  
> And since the system is big-endian, the 64-bit si_addr value 
> has zeros in bytes 0-3.  But those zeros are what userspace ends up 
> seeing in its 32-bit version of si_addr.
>
> So the solution is to store the address in the si_sigval part instead.  
> Wouldn't it have been easier to have a compat routine somewhere just 
> do something like:
>
> 	sinfo->si_pid = (u32) sinfo->si_addr;  /* Compensate for USB */
>
> That would work regardless of the endianness, wouldn't it?

That logic will work yes.  That is essentially what I implemented in
proc_submiturb_compat:
	userurb_sigval.sival_int = ptr_to_compat(arg);

The practical problem is that we only know the compat status
of userspace when (a) the usb ioctl is called and when (b) the signal is
delivered to userspace.  We can't fix this a (b) because there is
too little information available due to the fact that glibc also
uses SI_ASYNCIO but with si_uid, si_pid, and si_siginfo. So we can't
just replace si_pid with sinfo->si_addr because si_pid and si_uid are
valid.

So we have to do something at (a) which is complicated by the fact
that we don't have siginfo yet.  So I choose to store a sigval_t
instead to just get the relevant bits.

>> Fixing this while maintaining some modicum of sanity is the tricky bit.
>> The interface is made to kill_pid_usb_asyncio is made a sigval_t so the
>> standard signal compat tricks can be used.  sigval_t is a union of:
>> 
>>         int sival_int;
>>         void __user *sival_ptr;
>> 
>>          0   1  2   3    4   5   6  7
>>        +---+---+---+---+---+---+---+---+
>>        |            sival_ptr          | (64bit)
>>        +---+---+---+---+---+---+---+---+ 
>>        |    sival_ptr  | (32bit)
>>        +---+---+---+---+
>>        |    sival_int  |
>>        +---+---+---+---+
>> 
>> The signal code solves the compat issues for sigval_t by storing the
>> 32bit pointers in sival_int.  So they meaningful bits are guaranteed to
>> be in the low 32bits, just like the 32bit sival_ptr.
>> 
>> After a bunch of build BUG_ONs to verify my reasonable assumptions
>> of but the siginfo layout are actually true, the code that generates
>> the siginfo just copies a sigval_t to si_pid.  And assumes the code
>> in the usb stack placed the pointer in the proper part of the sigval_t
>> when it read the information from userspace.
>> 
>> I don't know if that helps make it easy to understand but I figured I
>> would give it a shot.
>
> I think I understand now.  Thanks.

Welcome.  I am trying to make this stuff comprehensible.

Eric

