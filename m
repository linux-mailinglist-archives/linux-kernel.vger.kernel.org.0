Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4F156C83
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 22:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBIVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 16:07:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36433 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbgBIVHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 16:07:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so2746350lfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 13:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tux2M6kbHMvH0JKLVPtftfWBRCeZSrUVwZt0sUDjiao=;
        b=V/y+he4C4lbnnySe4+33BUrHatJiIha0qohX2VfImnaFjdkrXTdYEIlY9Qe6ePSUbY
         R/aa08k6/eX/UrvS3bqqnMLAUVib6NnIqQknCbB/0C6zaWj1sD2zf0FZIj/B0gfLYHt8
         KYaHZ5fezZJC5/PBK2yNgBs39t+XAlJzIisRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tux2M6kbHMvH0JKLVPtftfWBRCeZSrUVwZt0sUDjiao=;
        b=evMOjc1RNHWr3AYmZXALVqL831KyDJZuk+f/1scBEaGXlaAdf3CfxyPYpNWtjLDsf1
         Cv44nrvxtWFj9DFx81BpmJ1EGVtgWutVwt1G6eN5dpBfFDoiA7LayvFqwCcahEXpCHed
         3ZE+/rhT0JrHA0i1fwGVxFNCNhWA+WTw9FvKpXe4SYj/JsDOOCGS9ARB+uhk+CwDr55N
         utV5CE7QOdthnmDL5aYEQ24mZgF+tLkSB8KC6RXho94w6OZr2AgxBMB2f32UOf9L7H++
         85hBoOuhmZ5qm/YzNePhT1doVZAzlKFmpopEHtABsDWuK+pYVNAW6f8/klAbzTeCPxjq
         kTfw==
X-Gm-Message-State: APjAAAXWsv2stMM5ZelDOImSyfcyAKvfz3DjMVGPJY/vA7HMqM2JmdIK
        I5y11mSkWpaxdToP40VMLCZ7nFsvWuU=
X-Google-Smtp-Source: APXvYqwxbVgwIpAENYWq/8DDNKuZeiHggV3YRXmHVJmhNexyEr11F6/MvdJ1CbwhfgRzipXStEoLaw==
X-Received: by 2002:ac2:44d5:: with SMTP id d21mr4419378lfm.188.1581282463504;
        Sun, 09 Feb 2020 13:07:43 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g15sm5215428ljl.10.2020.02.09.13.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 13:07:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id x14so4781763ljd.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 13:07:42 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr5868447ljj.241.1581282462078;
 Sun, 09 Feb 2020 13:07:42 -0800 (PST)
MIME-Version: 1.0
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.3631526665331853849.tglx@nanos.tec.linutronix.de>
 <CAHk-=wiEg6+j1UuRSAZmXozJEw0p33gM9uPT2oAOFwsOUaa=uw@mail.gmail.com> <877e0v5vp0.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877e0v5vp0.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Feb 2020 13:07:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1YsNpd6t2=QKC0XrfrKB52eXrtaARON3MCGEnwtGvSA@mail.gmail.com>
Message-ID: <CAHk-=wg1YsNpd6t2=QKC0XrfrKB52eXrtaARON3MCGEnwtGvSA@mail.gmail.com>
Subject: Re: [GIT pull] perf fixes for 5.6-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 12:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > Pick out the five speeling errors in that pull request message.
>
> But I have to admit shamefully that I really should have searched my
> misplaced reading glasses instead of trying to squint through my driving
> glasses.
>
> Want me to redo it?

Oh I've already pulled it, and fixed the spelling errors I noticed.

I don't know how many I didn't notice, of course.

               Linus
