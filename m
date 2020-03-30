Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E36197B63
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgC3L6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:58:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50986 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgC3L6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:58:06 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02UBw4tU096873;
        Mon, 30 Mar 2020 20:58:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Mon, 30 Mar 2020 20:58:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02UBvw1n096795
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 30 Mar 2020 20:58:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Guilherme Piccoli <gpiccoli@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>, kernelci@groups.io,
        CKI Project <cki-project@redhat.com>,
        kbuild test robot <lkp@intel.com>, workflows@vger.kernel.org
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <7fe65aef-94e1-b51a-0434-b1fe9d402d7b@i-love.sakura.ne.jp>
 <CAHD1Q_zx29ZP37WcUr34ZEyqWkA9J23RmLa8jFyuLDrS_yC50A@mail.gmail.com>
 <CACT4Y+bjsEFsP1ELGuTXbZV5m3gWys444p5cq=375KPkpFk0Gg@mail.gmail.com>
 <CACT4Y+YE-j5ncjTGN6UhngfCNRgVo-QDZ3VCBGACdbs9-v+axQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e9106a87-b748-a60b-494d-99fd7225c236@i-love.sakura.ne.jp>
Date:   Mon, 30 Mar 2020 20:57:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YE-j5ncjTGN6UhngfCNRgVo-QDZ3VCBGACdbs9-v+axQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/30 18:01, Dmitry Vyukov wrote:
> On Mon, Mar 30, 2020 at 10:49 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Mon, Mar 30, 2020 at 2:43 AM Guilherme Piccoli
>> <gpiccoli@canonical.com> wrote:
>>>
>>> Hi Tetsuo and Dmitry, thanks for noticing this Tetsuo. And sorry for
>>> not looping you in the patch Dmitry, I wasn't aware that you were
>>> working with testing. By the way, I suggest people interested in linux
>>> testing to create a ML; I'd be glad to have looped such list, but I
>>> couldn't find information about a group dealing with testing.
>>>
>>> So Tetsuo, you got it right: just change it to
>>> "sysctl.kernel.hung_task_all_cpu_backtrace=1" and that should work
>>> fine, once Vlastimil's patch gets merged (and I hope it happens soon).
>>> Cheers,
>>>
>>>
>>> Guilherme
>>
>> +LKML, workflows, syzkaller, kernelci, cki, kbuild
>>
>> Tetsuo, thanks for notifying again.
>>
>> Yes, kernel devs breaking all testing happens from time to time and
>> currently there is no good way to address this.
>> Other things I remember is the introduction of CONFIG_DEBUG_MEMORY,
>> which defaults to =n and disables KASAN, which in turn produced an
>> explosion of assorted crashes caused by memory corruptions; also
>> periodic changes in kernel crash messages which I assume all testing
>> systems parse and need to understand.
>>
>> Is there already a mailing list for this? Or should we create one?
>> I.e. announce and changes that may need actions from all testing
>> systems.

I think we can create one.

>> Another thing that may benefit from announcements is addition of new
>> useful debugging configs. Currently they are introduced silently and
>> don't reach the target audience.
> 
> I've fixed this up:
> https://github.com/google/syzkaller/commit/c8d1cc20df5ca5d9ea437054720fa3cfdfa1f578

Excuse me, but that commit is incorrect.
There will be no /proc/sys/sysctl/kernel/hung_task_all_cpu_backtrace file.
What Vlastimil's patch will allow is to set sysctl values via kernel command
line option using "sysctl." as a prefix. That is,

-hung_task_all_cpu_backtrace=1
+sysctl.kernel.hung_task_all_cpu_backtrace=1

on dashboard/config/*.cmdline files is what you need.

> 
> But what would be even better is some kind of canned configs/settings
> for testing systems so that I enable it once and then such changes
> magically auto-happen for me.

Yes, updating kernel config is a burden for kernel testing projects.
I'm waiting for comments from more kernel testing projects on
https://lkml.kernel.org/r/55c906c8-ca70-9d1b-a90f-49660773856b@i-love.sakura.ne.jp .

> Imposing work on N testing systems maintainers is not good.
> And there really is no good point in the current kernel dev process
> for this. Announcing unmerged changes is too early (as this patch
> showed). And once it's in linux-next it's already too late..
> And I don't want to be inventing a new unique kernel configuration for
> testing. I don't think it's the right way to approach this. Whatever
> is "the testing configuration", whatever kernel developers want to see
> in task hang reports, I just want the system to provide that.
> 

