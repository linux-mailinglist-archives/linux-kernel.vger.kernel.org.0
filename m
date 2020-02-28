Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4C173DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgB1RKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:10:08 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53766 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:10:08 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7j9K-0000yP-Ju; Fri, 28 Feb 2020 10:10:06 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7j9J-0008Tb-VJ; Fri, 28 Feb 2020 10:10:06 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 28 Feb 2020 11:07:56 -0600
Message-ID: <87k146vdw3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7j9J-0008Tb-VJ;;;mid=<87k146vdw3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Qc3ezt+ctVoDu7uln0ac4YwphkGWSGmk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 251 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 3.5 (1.4%), b_tie_ro: 2.4 (1.0%), parse: 1.03
        (0.4%), extract_message_metadata: 3.5 (1.4%), get_uri_detail_list:
        1.10 (0.4%), tests_pri_-1000: 4.2 (1.7%), tests_pri_-950: 1.40 (0.6%),
        tests_pri_-900: 1.08 (0.4%), tests_pri_-90: 21 (8.2%), check_bayes: 19
        (7.6%), b_tokenize: 6 (2.2%), b_tok_get_all: 6 (2.3%), b_comp_prob:
        2.6 (1.0%), b_tok_touch_all: 2.6 (1.0%), b_finish: 0.73 (0.3%),
        tests_pri_0: 191 (76.0%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 2.8 (1.1%), poll_dns_idle: 1.06 (0.4%), tests_pri_10:
        4.2 (1.7%), tests_pri_500: 11 (4.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/5] posix-cpu-timers: Graceful handling of reaped processes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg, Thomas,

The posic cpu timer code does not handle processes that is is using as a
clock source exiting and being reaped at all well.  In most cases the
code pins the entire task struct for no good reason.  In the
multi-threaded exec case where the thread group leader exits but the
thread group remains the posix cpu timers just stop working when it
should not.

To solve that problems requires checking if the target processes is
still alive before proceeding.  Replacing cpu.task with a struct pid
pointer is the easiest way I can see to add that extra checking and
extra indirection needed.

So here is my fix.  Oleg, Thomas and if you guys could take a look and
see I made any mistakes I would appreciate it.

Thomas if you want these changes you can have them otherwise I will take
them through my tree.  

Eric W. Biederman (5):
      posix-cpu-timers: cpu_clock_sample_group no longer needs siglock
      posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group
      posix-cpu-timers: Pass the task into arm_timer
      posix-cpu-timers: Store a reference to a pid not a task
      posix-cpu-timers: Stop disabling timers on mt-exec

 include/linux/posix-timers.h   |   2 +-
 kernel/exit.c                  |  11 +---
 kernel/time/posix-cpu-timers.c | 137 +++++++++++++++++++----------------------
 3 files changed, 67 insertions(+), 83 deletions(-)

Eric
