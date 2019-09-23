Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72F4BBC90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502472AbfIWT66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:58:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWT66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:58:58 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iCUU1-00059w-Uh; Mon, 23 Sep 2019 21:58:54 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Fix unnecessary returning broken pipe error from devkmsg_read
References: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
        <20190923100513.GA51932@jagdpanzerIV>
        <027b2f0d-b7dc-4e76-22a7-ce80c9a0aade@windriver.com>
        <20190923113936.73lhmpxurynem62e@pathway.suse.cz>
        <6b73354a-c61e-b92c-41f4-0edcb2372952@windriver.com>
Date:   Mon, 23 Sep 2019 21:58:51 +0200
In-Reply-To: <6b73354a-c61e-b92c-41f4-0edcb2372952@windriver.com> (He Zhe's
        message of "Mon, 23 Sep 2019 22:11:44 +0800")
Message-ID: <87d0fq239g.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-23, He Zhe <zhe.he@windriver.com> wrote:
>>>>> When users read the buffer from start, there is no need to return -EPIPE
>>>>> since the possible overflows will not affect the output.
>>>>>
>>>> [..]
>>>>> -	if (user->seq < log_first_seq) {
>>>>> +	if (user->seq == 0) {
>>>>> +		user->seq = log_first_seq;
>>>>> +	} else if (user->seq < log_first_seq) {
>>>>>  		/* our last seen message is gone, return error and reset */
>>>>>  		user->idx = log_first_idx;
>>>>>  		user->seq = log_first_seq;
>>
>> IMHO, the patch is wrong.
>
> If this is the case, I'm going to submit a patch for RT kernel.

It should be enough just to remove the if-branch.

FYI, this bug only exists in the RFCv1 of my proposed printk patchset,
which is what RT 5.x is based on. The code currently being prepared for
mainline does not have this issue.

Thanks for reporting. Looking forward to your patch.

John Ogness
