Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAAE117DC88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 10:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCIJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 05:35:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58376 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:35:02 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBEoD-0004h7-Ic; Mon, 09 Mar 2020 10:34:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C3CA210408A; Mon,  9 Mar 2020 10:34:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        lkp@lists.01.org
Subject: Re: [futex] 8019ad13ef: will-it-scale.per_process_ops -97.8% regression
In-Reply-To: <20200309085123.GE12561@hirez.programming.kicks-ass.net>
References: <20200308140200.GO5972@shao2-debian> <CAHk-=wgJV7xrxsTkOG203huPShzZBEC6N_BG0KGwHBmEq4yqWg@mail.gmail.com> <CAHk-=whrpL8pbKLg3_s3+bxv6kbPnzbSP8dQkZ+Rv=jAT3aoKw@mail.gmail.com> <87h7yy90ve.fsf@nanos.tec.linutronix.de> <20200309085123.GE12561@hirez.programming.kicks-ass.net>
Date:   Mon, 09 Mar 2020 10:34:48 +0100
Message-ID: <87y2s97txj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Sun, Mar 08, 2020 at 07:07:17PM +0100, Thomas Gleixner wrote:
>>  static struct futex_hash_bucket *hash_futex(union futex_key *key)
>>  {
>> -	u32 hash = jhash2((u32*)&key->both.word,
>> -			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
>> +	u32 hash = jhash2((u32*)&key->both.ptr,
>> +			  (sizeof(key->both.ptr) + sizeof(key->both.word)) / 4,
>>  			  key->both.offset);
>>  	return &futex_queues[hash & (futex_hashsize - 1)];
>>  }
>
> Groan... I've gotta ask, why isn't that written like:
>
> 	u32 hash = jhash2((u32 *)key,
> 			  offsetof(typeof(*key), offset) / 4
> 			  key->both.offset);
>
> Or better yet:
>
> 	u32 hash = jhash((u32 *)key, sizeof(*key) / 4, 0);

Histerical raisins :)
