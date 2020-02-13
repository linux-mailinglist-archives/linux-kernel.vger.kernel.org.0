Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0A15CAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 20:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBMTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 14:01:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40878 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:01:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so7960812wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dn/tfISxJoEgJnzBpyA8uxc0Qgp5ipdz2fWVodey7ek=;
        b=FvsUf/SD1XtJK8Wv0KC5LO+bJJrBnNL1zUODU1QXFKPaNQRfcb558edoDGX+tpbCkK
         +kHZ2AmiXYJdzjGVZ00LnSFk8Mz48I2UBSQLZpTPhYwKkdZfCxRVfhkWF3lHzMiRqT5A
         QAyIyXJaxFK6g4ZVmDQhUxoYLDBpGhw8UUEZNVtncCvNnesYT0IpuRmG3hl/iH5sm/ZM
         lpYnUr5luOuM9iHi9pKW54m3c+9hX4bGfcXaoR6j2pj3gFk4kC34PNxxzVhDoteoij1K
         Y50hRut0NDEO83w2ngofXVI2FPnMAFURWMuwL2nDwkhFwz18DLA4KOa1QAnbLR5Whypu
         Am+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dn/tfISxJoEgJnzBpyA8uxc0Qgp5ipdz2fWVodey7ek=;
        b=RRLHOOjp+ZYhwkCnzaYHhwpDSJXHrpdv9pDi1ub845hD/eqPPYPOuQrkt/rGm+bwl+
         Yxj3eQ4rFNaiv/MUmBX5CKs4gOLklXvtWeFrOi3woelj25Sdlt03NRkYKgCcyb3RTZQ/
         bNrROIYwbWGJfN7Ydrej3RB+M7/UzZVAekVQS7JEqXa3Zrpip52arbs7zhAIw9HogZio
         nft17utoQaZLYTIHZS6M7S1kksk1xdG4oRP3UvhmhT+KdjkADCu6fbgKsGGuhJ1Ln5h3
         WFXJeZXNhMdIkTXST1mXkJNU2B3OWCeV/ZpkddBFeKGaKntwBXNKJcd9UQEpIvPG8ZaV
         X9RA==
X-Gm-Message-State: APjAAAXQYds+Kul1GViBtZkjmdTA5Vh+dLFzACOQPJhpRp5wgMbiZumd
        VGFyUw+virPJgSKdkyZr1JaypBWzYhkPYOO+twEG
X-Google-Smtp-Source: APXvYqxifqjPohUlDkdJ9PNa3fGWK+UMVc1B6oEBOmY+Zk+EeWv0Eg5/XMUi08DvF5DxPv0oM1Wy2Tf0keasS3uVKtY=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr7230678wml.55.1581620506752;
 Thu, 13 Feb 2020 11:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-11-atish.patra@wdc.com> <87ftfe3g4u.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87ftfe3g4u.fsf@nanos.tec.linutronix.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 13 Feb 2020 11:01:35 -0800
Message-ID: <CAOnJCUKPZ72aDibwxcWeYN7Bh8UyohmcVQqEiSe1fa7p+M8y+g@mail.gmail.com>
Subject: Re: [PATCH v8 10/11] irqchip/sifive-plic: Initialize the plic handler
 when cpu comes online
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Vincent Chen <vincent.chen@sifive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mao Han <han_mao@c-sky.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 3:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Atish Patra <atish.patra@wdc.com> writes:
>
> > +static void plic_handler_init(struct plic_handler *handler, u32 threshold)
> > +{
> > +     irq_hw_number_t hwirq;
> > +
> > +     /* priority must be > threshold to trigger an interrupt */
> > +     writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
> > +     for (hwirq = 1; hwirq < plic_irqdomain->hwirq_max; hwirq++)
> > +             plic_toggle(handler, hwirq, 0);
> > +}
>
> > +
> > +static int plic_starting_cpu(unsigned int cpu)
> > +{
> > +     u32 threshold = 0;
>
> Pointless variable. Also you use PLIC_DISABLE_THRESHOLD down below, so
> please add a proper define for enable as well.
>

Sure. Will do that.

> > +     struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
>
>         this_cpu_ptr*&...)
>
> The callback is guaranteed to run on the plugged in CPU.
>

Ah yes. I will change it to this_cpu_ptr. Thanks.

> > -                     threshold = 0xffffffff;
> > +                     plic_handler_init(handler, PLIC_DISABLE_THRESHOLD);
>
> Thanks,
>
>         tglx
>


-- 
Regards,
Atish
