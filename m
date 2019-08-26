Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8779D0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 15:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfHZNoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 09:44:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62781 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfHZNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:45 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7QDiXgm019577;
        Mon, 26 Aug 2019 22:44:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Mon, 26 Aug 2019 22:44:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7QDiXGe019573
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 26 Aug 2019 22:44:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] /dev/mem: Bail out upon SIGKILL.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
References: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190826132916.GB12281@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <87bb0adb-1d36-6481-6845-a93e5a3e5d17@i-love.sakura.ne.jp>
Date:   Mon, 26 Aug 2019 22:44:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826132916.GB12281@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/26 22:29, Greg Kroah-Hartman wrote:
> On Mon, Aug 26, 2019 at 10:13:25PM +0900, Tetsuo Handa wrote:
>> syzbot found that a thread can stall for minutes inside read_mem() or
>> write_mem() after that thread was killed by SIGKILL [1]. Reading from
>> iomem areas of /dev/mem can be slow, depending on the hardware.
>> While reading 2GB at one read() is legal, delaying termination of killed
>> thread for minutes is bad. Thus, allow reading/writing /dev/mem and
>> /dev/kmem to be preemptible and killable.
>>
>>   [ 1335.912419][T20577] read_mem: sz=4096 count=2134565632
>>   [ 1335.943194][T20577] read_mem: sz=4096 count=2134561536
>>   [ 1335.978280][T20577] read_mem: sz=4096 count=2134557440
>>   [ 1336.011147][T20577] read_mem: sz=4096 count=2134553344
>>   [ 1336.041897][T20577] read_mem: sz=4096 count=2134549248
>>
>> Theoretically, reading/writing /dev/mem and /dev/kmem can become
>> "interruptible". But this patch chose "killable". Future patch will make
>> them "interruptible" so that we can revert to "killable" if some program
>> regressed.
>>
>> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
>> ---
>>  drivers/char/mem.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
> 
> What changed from previous versions?
> 
> That goes below the --- line at the very least.

(1) Moved fatal_signal_pending() test to end of iteration.
(2) Added need_resched() test before cond_resched().
(3) Removed -EINTR assignment because end of iteration means
    that at least one byte was processed (sz > 0).

> 
> thanks,
> 
> greg k-h
> 

