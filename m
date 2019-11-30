Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0E10DDA7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfK3Msg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 07:48:36 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57676 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfK3Msg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 07:48:36 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAUCmYxe079069;
        Sat, 30 Nov 2019 21:48:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Sat, 30 Nov 2019 21:48:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAUCmXcG079065
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 30 Nov 2019 21:48:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: sleeping function called from invalid context in
 __alloc_pages_nodemask
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>,
        Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000c280ba05988b6242@google.com>
 <CACT4Y+Z_E8tNtt5y4r_Sp+dWDjxundr4vor9DYxDr8FNj5U90A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <77abfacd-cfd0-5a8d-4af7-e5847fb4e03a@I-love.SAKURA.ne.jp>
Date:   Sat, 30 Nov 2019 21:48:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z_E8tNtt5y4r_Sp+dWDjxundr4vor9DYxDr8FNj5U90A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/30 16:57, Dmitry Vyukov wrote:
> On Sat, Nov 30, 2019 at 8:35 AM syzbot
> <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    419593da Add linux-next specific files for 20191129
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12cc369ce00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com
> 
> +Daniel, kasan-dev
> This is presumably from the new CONFIG_KASAN_VMALLOC

Well, this is because

commit d005e4cdb2307f63b5ce5cb359964c5a72d95790
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Nov 19 11:45:23 2019 +1100

    mm/vmalloc: rework vmap_area_lock

@@ -3363,29 +3369,38 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
                va = vas[area];
                va->va_start = start;
                va->va_end = start + size;
-
-               insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
        }

-       spin_unlock(&vmap_area_lock);
+       spin_unlock(&free_vmap_area_lock);

        /* insert all vm's */
-       for (area = 0; area < nr_vms; area++)
-               setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
+       spin_lock(&vmap_area_lock);
+       for (area = 0; area < nr_vms; area++) {
+               insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
+
+               setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
                                 pcpu_get_vm_areas);
+       }
+       spin_unlock(&vmap_area_lock);

        kfree(vas);
        return vms;

made the iteration atomic context while

commit 1800fa0a084c60a600be0cc43fc657ba5609fdda
Author: Daniel Axtens <dja@axtens.net>
Date:   Tue Nov 19 11:45:23 2019 +1100

    kasan: support backing vmalloc space with real shadow memory

@@ -3380,6 +3414,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,

                setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
                                 pcpu_get_vm_areas);
+
+               /* assume success here */
+               kasan_populate_vmalloc(sizes[area], vms[area]);
        }
        spin_unlock(&vmap_area_lock);

tried to do sleeping allocation inside the iteration.
