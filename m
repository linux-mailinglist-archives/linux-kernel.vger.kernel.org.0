Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F0223E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfERPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 11:25:32 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58690 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfERPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:25:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hS1DG-0002hL-Hj; Sat, 18 May 2019 09:25:30 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hS1DF-0003iq-O1; Sat, 18 May 2019 09:25:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1905181116330.7855-100000@netrider.rowland.org>
Date:   Sat, 18 May 2019 10:25:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.1905181116330.7855-100000@netrider.rowland.org>
        (Alan Stern's message of "Sat, 18 May 2019 11:20:47 -0400 (EDT)")
Message-ID: <878sv3ss32.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hS1DF-0003iq-O1;;;mid=<878sv3ss32.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Vd8OIugNR8FtTsnNrJrJM9aHdGWcp/AY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMGappySubj_01,XMGappySubj_02,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4542]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.0 XMGappySubj_02 Gappier still
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alan Stern <stern@rowland.harvard.edu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 304 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.9%), b_tie_ro: 1.84 (0.6%), parse: 0.73
        (0.2%), extract_message_metadata: 11 (3.5%), get_uri_detail_list: 1.25
        (0.4%), tests_pri_-1000: 9 (3.1%), tests_pri_-950: 1.28 (0.4%),
        tests_pri_-900: 1.02 (0.3%), tests_pri_-90: 19 (6.3%), check_bayes: 18
        (5.8%), b_tokenize: 5 (1.8%), b_tok_get_all: 6 (1.9%), b_comp_prob:
        2.2 (0.7%), b_tok_touch_all: 2.5 (0.8%), b_finish: 0.52 (0.2%),
        tests_pri_0: 248 (81.6%), check_dkim_signature: 0.47 (0.2%),
        check_dkim_adsp: 2.0 (0.7%), poll_dns_idle: 0.54 (0.2%), tests_pri_10:
        2.2 (0.7%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [CFT][PATCH] signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 17 May 2019, Eric W. Biederman wrote:
>
>> Wow I got a little distracted but now I am back to this.
>> 
>> Using your test program I was able to test the basics of this.
>> 
>> I found one bug in my patch where I was missing a memset.  So I have
>> corrected that, and reorganized the patch a little bit.
>> 
>> I have not figured out how to trigger a usb disconnect so I have not
>> tested that.
>
> Heh.  Assuming the device file you tell the test program to use 
> corresponds to an actual USB device, you can trigger a disconnect by 
> literally unplugging the USB cable.  (Add a 10-second delay to the 
> program to give yourself enough time.)

I have just been running this in qemu.  But yes.  I suppose the easy
way would be to print a message asking the usb device to be unplugged
and then just wait for the signal.  I might try that.

>> The big thing I have not been able to test is running a 64bit big-endian
>> kernel with a 32bit user space.  My modified version of your test
>> program should report "Bad" without my patch, and should report "Good"
>> with it.
>> 
>> Is there any chance you can test that configuration?  I could not figure
>> out how to get a 64bit big-endian system running in qemu, and I don't
>> have the necessary hardware so I was not able to test that at all.  As
>> that is the actual bug I am still hoping someone can test it.
>
> Unfortunately, I don't have any big-endian systems either.

That probably explains why the breakage in big-endian was never noticed.
I am starting to wonder if anyone is actually doing big-endian for new
systems anymore.

Eric
