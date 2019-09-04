Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B48A804B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfIDKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 06:25:18 -0400
Received: from foss.arm.com ([217.140.110.172]:51282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDKZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:25:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6388B337;
        Wed,  4 Sep 2019 03:25:17 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258AD3F246;
        Wed,  4 Sep 2019 03:25:16 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
To:     David Laight <David.Laight@ACULAB.COM>,
        'Alexey Dobriyan' <adobriyan@gmail.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com> <20190903181920.GA22358@avx2>
 <651c419e45e043e9be8d0877b5a5406d@AcuMS.aculab.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d46b479b-247b-a291-75f9-b60dd7114440@arm.com>
Date:   Wed, 4 Sep 2019 11:25:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <651c419e45e043e9be8d0877b5a5406d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 10:43, David Laight wrote:
> From: Alexey Dobriyan
>> Sent: 03 September 2019 19:19
> ...
>>> How did you come up with this changeset, did you pickaxe for some regexp?
>>
>> No, manually, backtracking up to the call chain.
>> Maybe I missed a few places.
> 
> Renaming the structure field and getting the compiler to find all the uses can help.
> 
> 	David
> 

It's a good idea but sadly doesn't cover whatever the config doesn't
compile. A safer starting point could be

---
@state_var@
struct task_struct *p;
identifier var;
@@
(
var = p->state
|
p->state = var
)

@@
identifier state_var.var;
@@
- var
+ FIXME
---

But I'm hoping we can get something even better from coccinelle, stay
tuned...

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
