Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC92C1744EF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 05:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgB2EvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 23:51:23 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:51652 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2EvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 23:51:22 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7u5x-0006b9-8r; Fri, 28 Feb 2020 21:51:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7u5w-0004GG-0j; Fri, 28 Feb 2020 21:51:21 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
        <202002291137.px8YXKJI%lkp@intel.com>
Date:   Fri, 28 Feb 2020 22:49:15 -0600
In-Reply-To: <202002291137.px8YXKJI%lkp@intel.com> (kbuild test robot's
        message of "Sat, 29 Feb 2020 11:25:27 +0800")
Message-ID: <8736auov5g.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7u5w-0004GG-0j;;;mid=<8736auov5g.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GlRjNNecqUtSYe6LOjHVVynVFGI6exIk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_08,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4131]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;kbuild test robot <lkp@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 662 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.4 (0.5%), b_tie_ro: 2.3 (0.3%), parse: 1.11
        (0.2%), extract_message_metadata: 28 (4.2%), get_uri_detail_list: 4.3
        (0.7%), tests_pri_-1000: 10 (1.5%), tests_pri_-950: 1.42 (0.2%),
        tests_pri_-900: 1.27 (0.2%), tests_pri_-90: 36 (5.5%), check_bayes: 34
        (5.2%), b_tokenize: 13 (2.0%), b_tok_get_all: 11 (1.6%), b_comp_prob:
        3.6 (0.5%), b_tok_touch_all: 4.6 (0.7%), b_finish: 0.64 (0.1%),
        tests_pri_0: 399 (60.3%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 10 (1.6%), poll_dns_idle: 158 (23.8%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 176 (26.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] proc: Remove the now unnecessary internal mount of proc
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> Hi "Eric,
>
> Thank you for the patch! Yet something to improve:

Dear kbuild robot,

Yep. You got it the wrong base.  I will see about using --base
if I repost, or have another patchset that so clearly needs
to be applied on top of a non-default base.

Thank you for writing me how to do that.

Eric


> [auto build test ERROR on uml/linux-next]
> [also build test ERROR on linux/master kees/for-next/pstore linus/master v5.6-rc3 next-20200228]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Eric-W-Biederman/proc-Actually-honor-the-mount-options/20200229-100926
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
> config: x86_64-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    fs/proc/base.c: In function 'proc_flush_task':
>>> fs/proc/base.c:3217:33: error: 'struct pid_namespace' has no member named 'proc_mnt'; did you mean 'proc_self'?
>       proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
>                                     ^~~~~~~~
>                                     proc_self
>
> vim +3217 fs/proc/base.c
>
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  3180  
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3181  /**
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3182   * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3183   * @task: task that should be flushed.
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3184   *
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3185   * When flushing dentries from proc, one needs to flush them from global
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3186   * proc (proc_mnt) and from all the namespaces' procs this task was seen
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3187   * in. This call is supposed to do all of this job.
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3188   *
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3189   * Looks in the dcache for
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3190   * /proc/@pid
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3191   * /proc/@tgid/task/@pid
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3192   * if either directory is present flushes it and all of it'ts children
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3193   * from the dcache.
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3194   *
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3195   * It is safe and reasonable to cache /proc entries for a task until
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3196   * that task exits.  After that they just clog up the dcache with
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3197   * useless entries, possibly causing useful dcache entries to be
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3198   * flushed instead.  This routine is proved to flush those useless
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3199   * dcache entries at process exit time.
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3200   *
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3201   * NOTE: This routine is just an optimization so it does not guarantee
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3202   *       that no dcache entries will exist at process exit time it
> 0895e91d60ef9b Randy Dunlap      2007-10-21  3203   *       just makes it very unlikely that any will persist.
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3204   */
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3205  
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3206  void proc_flush_task(struct task_struct *task)
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3207  {
> 9fcc2d15b14894 Eric W. Biederman 2007-11-14  3208  	int i;
> 9b4d1cbef8f41a Oleg Nesterov     2009-09-22  3209  	struct pid *pid, *tgid;
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3210  	struct upid *upid;
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3211  
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3212  	pid = task_pid(task);
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3213  	tgid = task_tgid(task);
> 9fcc2d15b14894 Eric W. Biederman 2007-11-14  3214  
> 9fcc2d15b14894 Eric W. Biederman 2007-11-14  3215  	for (i = 0; i <= pid->level; i++) {
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3216  		upid = &pid->numbers[i];
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18 @3217  		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
> 9b4d1cbef8f41a Oleg Nesterov     2009-09-22  3218  					tgid->numbers[i].nr);
> 130f77ecb2e7d5 Pavel Emelyanov   2007-10-18  3219  	}
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3220  }
> 60347f6716aa49 Pavel Emelyanov   2007-10-18  3221  
>
> :::::: The code at line 3217 was first introduced by commit
> :::::: 130f77ecb2e7d5ac3e53e620f55e374f4a406b20 pid namespaces: make proc_flush_task() actually from entries from multiple namespaces
>
> :::::: TO: Pavel Emelyanov <xemul@openvz.org>
> :::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
