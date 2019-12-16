Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC9121B86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 22:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLPVH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 16:07:57 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65414 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLPVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:07:56 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBGL6td0036251;
        Tue, 17 Dec 2019 06:06:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Tue, 17 Dec 2019 06:06:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBGL6tM0036247
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 17 Dec 2019 06:06:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
 <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
 <20191216201834.GA785904@mit.edu>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <46e8f6b3-46ac-6600-ba40-9545b7e44016@i-love.sakura.ne.jp>
Date:   Tue, 17 Dec 2019 06:06:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191216201834.GA785904@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/17 5:18, Theodore Y. Ts'o wrote:
>> this case was too hard to blacklist, as explained at
>> https://lore.kernel.org/lkml/4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp/ .
>> syz_execute_func() can find deeper bug by executing arbitrary binary code, but
>> we cannot blacklist specific syscalls/arguments for syz_execute_func() testcases.
>> Unless we guard on the kernel side, we won't be able to re-enable syz_execute_func()
>> testcases.
> 
> I looked at the reference, but I didn't see the explanation in the
> above link about why it was "too hard to blacklist".  In fact, it
> looks like a bit earlier in the thread, Dmitry stated that adding this
> find of blacklist "is not hard"?
> 
> https://lore.kernel.org/lkml/CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com/
> 

That thread handled two bugs which disabled console output.

The former bug (March 2019) was that fuzzer was calling syslog(SYSLOG_ACTION_CONSOLE_LEVEL) and
was fixed by blacklisting syslog(SYSLOG_ACTION_CONSOLE_LEVEL). This case was easy to blacklist.

The latter bug (May 2019) was that fuzzer was calling binary code (via syz_execute_func()) which
emdebbed a system call that changes console loglevel. Since it was too difficult to blacklist,
syzkaller gave up use of syz_execute_func().

