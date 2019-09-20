Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2500EB8E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 12:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438079AbfITKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 06:22:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64307 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408646AbfITKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:22:20 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x8KAMIXt020858;
        Fri, 20 Sep 2019 19:22:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Fri, 20 Sep 2019 19:22:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x8KAMC9B020534
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 20 Sep 2019 19:22:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in sys_exit_group
To:     Dmitry Vyukov <dvyukov@google.com>, paulmck@kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     syzbot <syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, avagin@gmail.com,
        Christian Brauner <christian@brauner.io>, dbueso@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, prsood@codeaurora.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
References: <000000000000674b3d0592d2015b@google.com>
 <CACT4Y+YX3yNz7Fc8wUKsVR-rzusqmTnzP6ysZx+=3CzhVHk36w@mail.gmail.com>
 <20190919170750.GO30224@paulmck-ThinkPad-P72>
 <CACT4Y+bHcy1ZOstVvSGezs+3Q=jccdWTeikm6mnZiXYCBi+Nyw@mail.gmail.com>
 <20190919201200.GP30224@paulmck-ThinkPad-P72>
 <CACT4Y+YdodVKL2h-Z4Svjyd6kug2ORmfiP4jripSC9PpYw4RiA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <46269171-ff57-8afd-f36b-40e6519b6557@i-love.sakura.ne.jp>
Date:   Fri, 20 Sep 2019 19:22:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YdodVKL2h-Z4Svjyd6kug2ORmfiP4jripSC9PpYw4RiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling printk() people.

On 2019/09/20 16:50, Dmitry Vyukov wrote:
>>>                                   How it runs on top of an interrupt?
>>
>> It is not running on top of an interrupt.  Its stack was dumped
>> separately.
> 
> I see. Usually the first stack is the traceback of the current stack.
> So I was confused.
> 
>>> And why one cpu tracebacks another one?
>>
>> The usual reason is because neither CPU's quiescent state was reported
>> to the RCU core, so the stall-warning code dumped both stacks.
> 
> But should the other CPU traceback _itself_? Rather than being traced
> back by another CPU?
> E.g. see this report:
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L61-L83
> Here the overall problem was detected by C2, but then C1 traces back itself.
> 
> ... however even in that case C0 and C3 are traced by C2:
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L84-L149
> I can't understand this...
> This makes understanding what happened harder because it's not easy to
> exclude things on other CPUs.

I think this should be
https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L84-L172
than #L84-L149 .

Is the reason these lines have "[    C2]" is that these lines were flushed (printk_caller_id()
was called) from log_output() from vprintk_store() from vprintk_emit() from vprintk_deferred()
 from printk_deferred() from printk_safe_flush_line() from __printk_safe_flush() from
printk_safe_flush() from printk_safe_flush_on_panic() from panic() ?

