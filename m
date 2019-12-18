Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF711243F0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLRKHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 05:07:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38468 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfLRKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 05:07:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so1194689wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 02:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnc+Qtpj1ux44k69lNmT/0NQKfi5c/PxZmcRKhpeVUI=;
        b=V/Dz4ukr1yXILlDlis3/bkczr5RqrcSC2dG1fl+a/0z5tFQ9DJsxZPhKgBN0vWRz4l
         f+qIVDEcu5artj5f24a197YuqSVUJ7kY+hYWbjkqxwJtZjkLAwOjUZYOYKxI4Z2SRaf6
         Dzwf/lfFAh7DNfT3xkoorL39dUXmytJfnAsBoPlN73EtATwoiwlapXDcFkfBIu0XToxz
         Mxd2FGvgA7vrFzsmNBJviZuyZ9546Z9N1KVMVPkOioIre4m6UORtDov4ffjjv7lEu4qL
         K8xWGtfwKiqAkoSvulzPHo/7IDkqZFqB88fAnXI27bwMijlcDIEhDV/oUbkqyPsLksa/
         kzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnc+Qtpj1ux44k69lNmT/0NQKfi5c/PxZmcRKhpeVUI=;
        b=if5LAmi8jfaNHgcC3IS8UgXjP9spZDjIiIXr1L4kwF2WYGTYCEcL0Bc9uLDbQSl5te
         KSBuRnnD8YQr4VOzBmDZKrEviO4cbmqXWXf1NGvDFNeKc8yyx67z8reUnt6HE/LdcVIR
         M8We1rgyK4xwZfiNb0E197GzBAej3geBEIUMU6JyGuILOAUPzonwzCLBph+nhlvhRlnm
         KjjA8k/psa/ZbfxnujOSEzvogQUI5ih+Ol6aTwwZnI3v6GIp5MQc4P8rN/0VDUHdmeon
         1tN2bR2A4jROX239BRwlqsbHvut68yje5mdi6n8VxXrFhped/LDqQcyxOb5QHpG32oSG
         EpXw==
X-Gm-Message-State: APjAAAXEnvv8wEDVuczjpZqigJOyOe0M1fmFnSQF+/ubbru3zzcN1hEi
        GRTU39N6uPqRq1JqTvGpN24p35pz4hEwtu+5xnk=
X-Google-Smtp-Source: APXvYqyBbxfNZX/fDYlx1sQzQD+dovvpivZ0Iw+N5kjZL1Q5w3uZFQVgiOCiHCoKXk1Up5mOW7UsoYWMnotVP71Bs7A=
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr2309027wma.5.1576663653844;
 Wed, 18 Dec 2019 02:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20191218084757.904971-1-david.abdurachmanov@sifive.com> <mvmo8w63r1d.fsf@suse.de>
In-Reply-To: <mvmo8w63r1d.fsf@suse.de>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Wed, 18 Dec 2019 12:06:57 +0200
Message-ID: <CAEn-LTojXuAbY31nReCsbE=7Q9PkuKexAttTc+35ZFn7SLG-_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: reject invalid syscalls below -1
To:     Andreas Schwab <schwab@suse.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:46 AM Andreas Schwab <schwab@suse.de> wrote:
>
> On Dez 18 2019, David Abdurachmanov wrote:
>
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index a1349ca64669..e163b7b64c86 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -246,6 +246,7 @@ check_syscall_nr:
> >        */
> >       li t1, -1
> >       beq a7, t1, ret_from_syscall_rejected
> > +     blt a7, t1, 1f
>
> How about using bgeu instead in the preceding check?

The syscall number could be -1 if tracer rejected it.

We could do:

li t0, __NR_syscalls
[..]
// first check if syscall was rejected
li t1, -1
beq a7, t1, ret_from_syscall_rejected
// then check the bounds
bgeu a7, t0, 1f

>
>         /*
>          * Syscall number held in a7.
>          * If syscall number is above allowed value, redirect to ni_syscall.
>          */
>         bge a7, t0, 1f
>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
