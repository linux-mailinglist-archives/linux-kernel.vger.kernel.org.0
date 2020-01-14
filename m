Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8213B0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgANRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:24:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54656 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:24:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so14749428wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6aoFKbKaSXKUSg/Zz8IkoRTb5Zfu+nxqGB3mWWn4Q0=;
        b=ArcAMvR7ix2hUFG5Z2tEeErcMWOiY3d8Aa/kwMLCzY3U/FpXEFipZoTzmyk3JRh3em
         savlZuS1Gk1UuhGiUY4GTtsFYWCTaZPad4G516SCMOAYOcyJ2LC5nywTlTYJQdO7VISM
         SDJLD0WoxPv4//6zm/GpVqdr59rSuYqN+yO7y//z0sHwBu6T15NWaAFMd8yCaiZ4bv4y
         ThWoHvEHbao6jl3w2QiVN6kto8hpBb1lg9Hg0ann7mXu34UUkUg7l7G9As4MY3Fh8Z6k
         ASk1M0fvEIuUDKtqsOv9vO4iABBDwS29V6ts98xaMzSjWBtpL98P3cPHZzm9iFbJcG6G
         piAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6aoFKbKaSXKUSg/Zz8IkoRTb5Zfu+nxqGB3mWWn4Q0=;
        b=VBHwasPu0yDQnTyRQeu974KmDgvBmJlXd40C5UDPlDibPG6jfabfSHnLcK+F06fnkA
         1ShXxam19nUMC1l+41sM3qaTygoFzqpLXcvpjFIyxQ1HZ7LwVL49XYtZO+u7gDfCqc6N
         W/pyQ0rszJMBaBxPqCcjUYsnrI2HcYmNbnGxKbv2QleKUzCZjkifWcgWpGBoTwP16lcC
         eqsvXReBlU8kn6KTIsT0ASa+Gp8pD8JvxXoasPOSL0QN3pwudBiO13a/M39JiAOyS/YT
         80raeXlHAVy04ggvGPBJPd89LPXHFC3KzdVACu7Ut/LecrY1VlUyCy6CFge/daj9lmHe
         IzbA==
X-Gm-Message-State: APjAAAUxsu+1xNF+Oz8pvg1VXZvWtKzP/XfXpw9Kzp2sB8UbZu/NtkjW
        vdaUAk/gBvGjUfB5jck6s0KmOx9T0/YwMHRpSJ8W4A==
X-Google-Smtp-Source: APXvYqxFPtYZzzqA3cLfob6Rs5gHh5OVDZcHkoF3CiUI8z4YceXDq16n9DQUtkiYDzHp+XLYdvCR9eGd83FL4VO7kLM=
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr29500320wmj.122.1579022668374;
 Tue, 14 Jan 2020 09:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20200114124919.11891-1-elver@google.com>
In-Reply-To: <20200114124919.11891-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 14 Jan 2020 18:24:17 +0100
Message-ID: <CAG_fn=X1rFGd1gfML3D5=uiLKTmMbPUm0UD6D0+bg+_hJtQMqA@mail.gmail.com>
Subject: Re: [PATCH -rcu] kcsan: Make KCSAN compatible with lockdep
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will@kernel.org,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -337,7 +337,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>          *      detection point of view) to simply disable preemptions to ensure
>          *      as many tasks as possible run on other CPUs.
>          */
> -       local_irq_save(irq_flags);
> +       raw_local_irq_save(irq_flags);

Please reflect the need to use raw_local_irq_save() in the comment.

>
>         watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
>         if (watchpoint == NULL) {
> @@ -429,7 +429,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>
>         kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
>  out_unlock:
> -       local_irq_restore(irq_flags);
> +       raw_local_irq_restore(irq_flags);

Ditto
