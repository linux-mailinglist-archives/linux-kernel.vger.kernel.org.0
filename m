Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1B0105D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 01:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKVAFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 19:05:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45546 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVAFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:05:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id n21so5198398ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpjzlQz2fMpAHDjP1l/+UaY8JIYWZ9EvltjrvoH1rb8=;
        b=MsxvqvFNl+4QDyZ13r6+5C2c7UUENK3f0XIzfYj8rl4l9ErTmGnoIokoX2t9ycbhDd
         dURXH1TKtvtnuBCRkQJoYpEABlDfiL5pSGHhZA/F2gkmZtLQQLl467dc7CkWRkXveqZ4
         KGQaZSAe6hmaqEPsRDmZ66IrONQOmcHs1okqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpjzlQz2fMpAHDjP1l/+UaY8JIYWZ9EvltjrvoH1rb8=;
        b=cKRb+W5DuZKK3FfjQJYkJu7wN7ZpFBWLR9nWp8/hXYVK2IuceXu1G2OHTzmlhY1eF4
         Z3GgDV06TBQC32qytLEUc6Gm73sKOFJjRm0np7780WGcGn8ht4cDYGsod6NK45U/1QgZ
         pGzidG4C5+ru4SEb67ppuHaC08BeOvE0BXufN6l+/bnFuYHur+xOMlAA9zmU39xyHmbk
         28X/xHfg7lJb7+ZNPxLQY6DNlhDFSEdmcBk5rKAUP/gyP97762FvFUkj1h2mixOkI0ui
         Yy5o35EH17KzAfbIgiW7clYXpLjevSIW0+baFf8r/w/IqwePVguJm5Krp8WlLTuFzfKF
         nhKA==
X-Gm-Message-State: APjAAAW4nEWVSE1MJQrLDgVdoyU5XnKwP5iD3a8FXSTnoXib5lkRwteF
        D0G1QIYOYDXeCiu0rPuMs8GT3h49xBc=
X-Google-Smtp-Source: APXvYqxG5aDZqyb0peRRT4N/0YNYSGhq6KG9HLyvt7ozO1MdW0E+hM2J55BkN/tEeXFIvaCBp4g7Cg==
X-Received: by 2002:a2e:974a:: with SMTP id f10mr9993240ljj.25.1574381116821;
        Thu, 21 Nov 2019 16:05:16 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k19sm2266286ljg.18.2019.11.21.16.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 16:05:15 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id m30so2226651lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 16:05:15 -0800 (PST)
X-Received: by 2002:ac2:434f:: with SMTP id o15mr9727805lfl.190.1574381114883;
 Thu, 21 Nov 2019 16:05:14 -0800 (PST)
MIME-Version: 1.0
References: <d6a7ca69-2f65-5bf4-edbd-2644a1f3f124@rasmusvillemoes.dk>
In-Reply-To: <d6a7ca69-2f65-5bf4-edbd-2644a1f3f124@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Nov 2019 16:04:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgf+qpDY31ojxqPdkSHT6f+E9yGM_L16iNhv9owEpbx7Q@mail.gmail.com>
Message-ID: <CAHk-=wgf+qpDY31ojxqPdkSHT6f+E9yGM_L16iNhv9owEpbx7Q@mail.gmail.com>
Subject: Re: can we get rid of the cpumask_t typedef?
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:55 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> The cpumask_t alias for "struct cpumask" doesn't seem to qualify for the
> kernel's requirement for when a typedef is warranted. It's also somewhat
> easily confused with cpumask_var_t which has very good reasons for being
> a typedef. "struct cpumask" outnumbers "cpumask_t" about 5:2.
>
> The motivation for this is that kbuild informed me about some driver
> that I just enabled for ARM happens to include asm/irq.h, and for magic
> reasons no other previous header happens to pull in cpumask.h. So the
> build fails
>
> >> arch/arm/include/asm/irq.h:34:50: error: unknown type name 'cpumask_t'
>     extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,

Yes. Please just add a forward declaration of 'struct cpumask', and
change that cpumask_t to use that instead.

I'm not sure we need to remove it entirely (there's a fair number of
users), but we can/should deprecate it, and certainly use 'struct
cpumask' in function declarations etc so that you don't need to go
through some include file hell.

           Linus
