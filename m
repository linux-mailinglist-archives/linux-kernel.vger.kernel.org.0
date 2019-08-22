Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6999183
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfHVK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 06:59:13 -0400
Received: from foss.arm.com ([217.140.110.172]:43810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbfHVK7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:59:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9161596;
        Thu, 22 Aug 2019 03:59:12 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DC713F246;
        Thu, 22 Aug 2019 03:59:11 -0700 (PDT)
Subject: Re: [RT PATCH 3/3] hrtimer: Prevent using uninitialized spin_lock in
 hrtimer_grab_expiry_lock()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org
References: <20190821092409.13225-1-julien.grall@arm.com>
 <20190821092409.13225-4-julien.grall@arm.com>
 <alpine.DEB.2.21.1908211557420.2223@nanos.tec.linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <6f637e70-9a7b-47fd-08b0-82b6494d3ae1@arm.com>
Date:   Thu, 22 Aug 2019 11:59:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908211557420.2223@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thank you for the review.

On 21/08/2019 15:02, Thomas Gleixner wrote:
> On Wed, 21 Aug 2019, Julien Grall wrote:
> 
>> migration_base is used as a placeholder when an hrtimer is switching
>> between base (see switch_hrtimer_timer_base). It is possible
>> theoritically possible to have timer->base equal to migration_base.
>>
>> Even if it is a placeholder, it would pass all the current check in
>> hrtimer_grab_expiry_lock() leading to use softirq_expiry_lock
>> uninitialized.
>>
>> This is can be prevented by checking whether the base is equal to
>> the placeholder (i.e. migration_base).
> 
> That's a lame argument. The point is that it does not make sense to do that
> on migration base, but not for the reason you are giving (uninitialized
> lock).

Fair point, I will update the commit message.

> 
> If base == migration_base then there is no point to lock soft_expiry_lock
> simply because the timer is not executing the callback in soft irq context
> and the whole lock/unlock dance can be avoided.
> 
> But, yes. Good catch.

Do you want me to resend the series or can I just provide an update to the 
commit message here?

Cheers,

-- 
Julien Grall
