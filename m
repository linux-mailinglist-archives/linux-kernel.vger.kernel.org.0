Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF944472
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392069AbfFMQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:37:18 -0400
Received: from ns.iliad.fr ([212.27.33.1]:47284 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfFMQg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:36:59 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3CC0420A52;
        Thu, 13 Jun 2019 18:36:57 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 248BF20163;
        Thu, 13 Jun 2019 18:36:57 +0200 (CEST)
Subject: Re: [PATCH v1] iopoll: Tweak readx_poll_timeout sleep range
To:     Doug Anderson <dianders@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr>
 <CAK8P3a1_WvHYW243MR5-NdFm3cSt+cVGM5EJmOM8uiQMQ3vQjQ@mail.gmail.com>
 <a732f522-5e65-3ac4-de04-802ef5455747@free.fr>
 <CAD=FV=U+Ky1bAuAuuY+eBdTP9U3kbuH0tfwyN0Zs-iw0GNUFyQ@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <13cb7357-0d10-fe43-bee1-b2142d01684c@free.fr>
Date:   Thu, 13 Jun 2019 18:36:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U+Ky1bAuAuuY+eBdTP9U3kbuH0tfwyN0Zs-iw0GNUFyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun 13 18:36:57 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 18:11, Doug Anderson wrote:

> On Thu, Jun 13, 2019 at 9:04 AM Marc Gonzalez wrote:
>
>> Hmmm, I expect the typical use-case to be:
>> "HW manual states operation X completes in 100 µs.
>> Let's call usleep_range(100, foo); before hitting the reg."
>>
>> And foo needs to be a "reasonable" value: big enough to be able
>> to merge several requests, low enough not to wait too long after
>> the HW is ready.
>>
>> In this case, I'd say usleep_range(100, 200); makes sense.
>>
>> Come to think of it, I'm not sure min=26 (or min=50) makes sense...
>> Why wait *less* than what the user specified?
> 
> IIRC usleep_range() nearly always tries to sleep for the max.  My
> recollection of the design is that you only end up with something less
> than the max if the system was going to wake up anyway.  In such a
> case it seems like it wouldn't be insane to go and check if the
> condition is already true if 25% of the time has passed.  Maybe you'll
> get lucky and you can return early.
> 
> Are you actually seeing problems with the / 4, or is this patch just a
> result of code inspection?

No actual issue. I just ran into a driver calling:

	readl_poll_timeout(status, val, val & mask, 1, 1000);

and it seemed... unwise(?) to call usleep_range(1, 1);

But if, as you say, usleep_range() aims for the max, then I guess it's
not a big deal to issue an early read or 3... Meh

Regards.
