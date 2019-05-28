Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE5A2C899
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfE1OVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 10:21:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58540 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfE1OVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:21:23 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4SELMwP009072;
        Tue, 28 May 2019 23:21:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 28 May 2019 23:21:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4SELKgN009063
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 28 May 2019 23:21:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV> <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e564ee00-6a93-defd-4eab-e306bbfe8b01@i-love.sakura.ne.jp>
Date:   Tue, 28 May 2019 23:21:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/28 22:42, Petr Mladek wrote:
>> Ahh.. OK, now I sort of remember why I gave up on this idea (see [1]
>> at the bottom, when it comes to uv_nmi_dump_state()) - printk_NMI and
>> printk-safe redirections.
>>
>> 	NMI
>> 		loglevel = NEW
>> 		printk -> printk_safe_nmi
>> 		loglevel = OLD
>>
>> 	iret
>>
>> 	IRQ
>> 		flush printk_safe_nmi -> printk
>> 		// At this point we don't remember about
>> 		// loglevel manipulation anymore
>> 	iret
> 
> printk_safe buffer preserves KERN_* headers. It should be
> possible to insert KERN_UNSUPPRESSED there.

But is context dependent buffer large enough to hold SysRq-t output?
I think that only main logbuf can become large enough to hold SysRq-t output.

We can add KERN_UNSUPPRESSED to SysRq's header line. But I don't think
that we can automatically add KERN_UNSUPPRESSED to SysRq's body lines
based on some context information. If we want to avoid manipulating
console_loglevel, we need to think about how to make sure that
KERN_UNSUPPRESSED is added to all lines from such context without
overflowing capacity of that buffer.

