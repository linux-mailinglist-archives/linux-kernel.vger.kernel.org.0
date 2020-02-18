Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9E162EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 19:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBRStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 13:49:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34398 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:49:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so24202108ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/hRoOXddpf2rg3/iA7HHccAIzHUJB1ObxyUSqAalTY=;
        b=NZzRuV1ykVa1MAKkVAJ+ayE7uc4yeKrTUPiopFgzMVSDworqehvv6s1IVq73p/Olth
         xB/LLOUygDjmABRDoAr27sggaJdlNl63J92LiGLxnz84PmCA5tETqhf2S1Vm6zwMxzef
         51K5GQq09q/p65UvpTOXQtxzKGwp4nzMgihRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/hRoOXddpf2rg3/iA7HHccAIzHUJB1ObxyUSqAalTY=;
        b=mXqdSYO41WXp95tP87/gWrsKY/dxrS4UKtqLJ/fHLfedOCcsfkw7LcRRkRb/OKn30j
         dyd85ILsrtJ8WBX5uG6OpHiUJPGVNKE8j+C3IrPN1eeitHjGJ21OV+TL2Z8jAIRzSg+n
         EVeCeJCD+lSJgKYdEVdoXosVNCBD5fMIDQbVCk2iX0H6Z67FsPmzKqMn6IVbDW7pKKzp
         wCLvsYqgeFX6S4HAzjjRGq9hWHjWnYLOulLN9iXZ6EuYPay2Es8Z/2VZDVSXHDNLGyQ+
         /Je2WzCC/NZw9LriYZxoLG+8PdMjarxoeCjwkp2kns3ylPNuLJiLEcN5/niOeKCCNzm3
         k4Iw==
X-Gm-Message-State: APjAAAXYVwc/zAx+DNGLM2L1wOFbyeQYaWNlDdetANr42xaefRvKHY6F
        gG9PbFdApW9pYBjSc8z1KxogMx2qj18=
X-Google-Smtp-Source: APXvYqwXRngoRyq0/lTKFLS989+5zDvvt5iK6aiy6+ZC34wSmGAFy0OiRa1RYDsAuBaAEpm9YueEIw==
X-Received: by 2002:a2e:8e2a:: with SMTP id r10mr12999821ljk.219.1582051787803;
        Tue, 18 Feb 2020 10:49:47 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u15sm2697831lfl.87.2020.02.18.10.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:49:47 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id f24so15290809lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:49:46 -0800 (PST)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr10897394lft.192.1582051786457;
 Tue, 18 Feb 2020 10:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com> <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
In-Reply-To: <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 10:49:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
Message-ID: <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 4:07 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> I'm not sure what you mean by efault string.  Are you referring to what
> %pe is doing?  If so, no -- I would keep %p and %pe separate.

Right.

But bringing up %pe makes me realize that we do odd things for NULL
for that. We print errors in a nice legible form, but we show NULL as
a zero value, I think.

So maybe %pe should show NULL as "(null)"? Or even as just "0" to go
with the error names that just look like the integer error syntax (eg
"-EINVAL")

                 Linus
