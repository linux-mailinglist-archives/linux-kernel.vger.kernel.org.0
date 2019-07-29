Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35978B70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfG2MNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 08:13:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44458 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfG2MNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:13:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so61564546wrf.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 05:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OAFiZVjNkFUKfTygRlCRfwGcUdmnJeWZ6/SJ1tkJ51o=;
        b=UoZ8nFmiYwo+fe67NqY0zX+EqSZ3TAjR1Pzpuhn4M32XFlmSp3zWgATaxVufHX0L8R
         PrqGeP5lxGoH73ZvCkrnX4PdpRX3qBf+SmcMFy/+Zhh2JkKEypzbBwPZHhCRicqI9pXE
         n96Gm25gDUpYArfoL1n61xX7sv5VtSQ5MC9PwS0HIghug5lmOLM1qj5XhwWNeVWtXZza
         Fu6rhD7X6uIGKRxLMct9hpSvYdQa/dsX3WdDp6YPcm47UcRs1xGkjz3Yn4QaCOZz/W8v
         Eejit5kjWvt3cp0e/Rt9GQzkAxrutv/UHQ46vnMHi0yHG5pl+rPzvnbJYXHGf+XOpCxX
         QM/g==
X-Gm-Message-State: APjAAAUmEMOvYyJ6dVBvv2Yh/J8lRj5XpzYx56v17jmcvA2GsMQEwVAh
        ObLnoE/Jo5R/E4qmwRHbjdblXA==
X-Google-Smtp-Source: APXvYqxYLwdceXu+TMC5pTK1KmiI8eJ05r+J2TyubiU3AKCGtptL9+JT+SU512H9+wia+z4GtJd3Gg==
X-Received: by 2002:adf:f450:: with SMTP id f16mr88352291wrp.335.1564402398265;
        Mon, 29 Jul 2019 05:13:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y24sm45263300wmi.10.2019.07.29.05.13.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:13:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <20190729110927.GC31398@hirez.programming.kicks-ass.net>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net>
Date:   Mon, 29 Jul 2019 14:13:16 +0200
Message-ID: <87wog1kpib.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
>> lantianyu1986@gmail.com writes:
>> 
>> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >
>> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
>> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
>> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
>> > to set the sched clock function appropriately.  On x86, this sets
>> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
>> > scaled and adjusted to be continuous.
>> 
>> Hypervisor can, in theory, disable TSC page and then we're forced to use
>> MSR-based clocksource but using it as sched_clock() can be very slow,
>> I'm afraid.
>> 
>> On the other hand, what we have now is probably worse: TSC can,
>> actually, jump backwards (e.g. on migration) and we're breaking the
>> requirements for sched_clock().
>
> That (obviously) also breaks the requirements for using TSC as
> clocksource.
>
> IOW, it breaks the entire purpose of having TSC in the first place.

Currently, we mark raw TSC as unstable when running on Hyper-V (see
88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
instead. The problem is that 'TSC page' can be disabled by the
hypervisor and in that case the only remaining clocksource is MSR-based
(slow).

-- 
Vitaly
