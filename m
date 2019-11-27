Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2710AB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 08:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfK0HfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 02:35:04 -0500
Received: from mail.jv-coder.de ([5.9.79.73]:40818 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0HfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:35:03 -0500
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id AB6619F73F;
        Wed, 27 Nov 2019 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1574840101; bh=21uHLITcKotKZHWu+5wn+8F7nkw3137394TzTbzd/zY=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=CatkMYWChImV2Ha5IoUJETDkacT7BbaLjlKVqR7iOd5gZ8aSJoz46GMdeNgDY1yp/
         Y9ryjEIifOBcripPocr1NLOu+nPqgoVYsWNMMgcAQ/ZDFYH9qeq5f3epPu7J9Eg/ar
         kHLy/a+9Q3KHjQdX9J+mIiwBqbrurKh6dUj6CzqM=
Subject: Re: [PATCH RT v3] net/xfrm/input: Protect queue with lock
To:     Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Cc:     Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20191126071335.34661-1-lkml@jv-coder.de>
 <46d5e7ea-011b-a384-ac7a-9ba63bbe9ea5@redhat.com>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <30b9da41-437a-3b00-8306-82c7c44d1a91@jv-coder.de>
Date:   Wed, 27 Nov 2019 08:35:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <46d5e7ea-011b-a384-ac7a-9ba63bbe9ea5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,HELO_MISC_IP,RCVD_IN_DNSWL_BLOCKED,
        RDNS_NONE autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.jv-coder.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I didn't remove it, I just posted my patch again.
I think it is up to the maintainers to decide if
it is required or not. Most people using the rt
patches will probably have PREEMPT_RT_FULL enabled anyway.
It will never be integrated into mainline kernel, because
the bug is already fixed in 5.0.19.

Jörg


Am 26.11.2019 um 16:31 schrieb Tom Rix:
> Why remove the #ifdef CONFIG_PREEMPT.. ?
>
>
>> +	spin_lock_irqsave(&trans->queue.lock, flags);
>>   	skb_queue_splice_init(&trans->queue, &queue);
>> +	spin_unlock_irqrestore(&trans->queue.lock, flags);
>>   
> Fine otherwise.
>
> Tom
>
>

