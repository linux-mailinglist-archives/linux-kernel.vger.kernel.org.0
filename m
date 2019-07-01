Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3427165
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfEVVKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 17:10:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64009 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbfEVVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:10:35 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4ML9Ed0088910;
        Thu, 23 May 2019 06:09:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Thu, 23 May 2019 06:09:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4ML98Wg088888
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 23 May 2019 06:09:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
 <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
 <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
 <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
 <a6b6a5ef-c65c-6999-2bc1-7aaf9dd19fe8@i-love.sakura.ne.jp>
 <20190522234134.44327256@canb.auug.org.au>
 <03b5834d-5f8f-9c7e-20df-cfdf5395d245@i-love.sakura.ne.jp>
Message-ID: <abbfb5df-40da-63c8-0333-805083397533@i-love.sakura.ne.jp>
Date:   Thu, 23 May 2019 06:09:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <03b5834d-5f8f-9c7e-20df-cfdf5395d245@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/22 23:58, Tetsuo Handa wrote:
> On 2019/05/22 22:41, Stephen Rothwell wrote:
>> Hi Tetsuo,
>>
>> On Wed, 22 May 2019 21:38:45 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> I want to send debug printk() patches to linux-next.git. Petr Mladek
>>> is suggesting me to have a git tree for debug printk() patches.
>>> But it seems that there is "git quiltimport" command, and I prefer
>>> "subversion + quilt", and I don't have trees for sending "git pull"
>>> requests. Therefore, just ignoring "git quiltimport" failure is fine.
>>> What do you think?
>>
>> Sure, we can try.  I already have one quilt tree (besides Andrew's) in
>> linux-next, but much prefer a git tree.  If you have to use a quilt
>> tree, I will import it into a local branch on the base you tell me to
>> and then fetch it every morning and reimport it if it changes.  I will
>> then merge it like any other git branch.  Let me know what you can deal
>> with.
>>
> 
> What I do for making patches is:
> 
>   git fetch --tags
>   git reset --hard next-$date
>   edit files
>   git commit -a -s
>   git format-patch -1
>   git send-email --to=$recipient 0001-*.patch
> 
> I'm sure I will confuse git history/repository everyday if
> I try to send changes using git. For my skill level, managing
> 0001-*.patch in a subversion repository is the simplest and safest.
> 

I put an example patch into my subversion repository:

  svn checkout https://svn.osdn.net/svnroot/tomoyo/branches/syzbot-patches/

To fetch up-to-date debug printk() patches:

  cd syzbot-patches
  svn update

Does this work for you?
