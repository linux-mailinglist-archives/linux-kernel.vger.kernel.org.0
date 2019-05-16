Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05FE1FD86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEPBuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:50:23 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:46709 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfEPBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:50:16 -0400
Received: by mail-lj1-f178.google.com with SMTP id h21so1502323ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eJ7zq+bbWUBl6uTT/Oi/zTtKOAXvl0vTCu6S+eKKjg=;
        b=Pf0mWhiZ+sUUrUff614uWxE95Su9GTskTCzTGgmd97yGl7tdorXVdA608ETMTsE7c3
         iBNGIH0NJh5+rka4Hc+AwsdujnfIVuE43zsq/IOFAGPARTBtQhHQORhBIfx/5qQL23zC
         9nOh30bk37wglCI+MPC+x9M9E1z+6wmtbpzJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eJ7zq+bbWUBl6uTT/Oi/zTtKOAXvl0vTCu6S+eKKjg=;
        b=PKFB7HLyUYtcOxNvCjaTWHqKBLnjDTpPwt9+ZvkkCi4UuXPWatiXODRiMb0gDbhKNw
         +AfN5xOkWIZ7skMv5m5YKEmDV68DVcXOSGhCXy2VpHlsNjHPNaeBFREWqtT0xymOj83E
         EZ2xiJQfm7je4vU/Kgs3n0a42XIKasqGRlJ5Aa5bjE5falO8hHs6+VHGlB6hyej/fATC
         Vfed7Rkj4bEgNkjbg3U7CwllPRNUaD88ZNdDBAMUE8vL9v7MVD+71O81PRAsDNM82WfV
         F5/4Fj/Eqd6HhXkYpbtzGThkwD++NLOMD9S0XEORMg5WJHrTMpLyY+YYr2GZfAr1/16F
         XI8A==
X-Gm-Message-State: APjAAAXoa/oJ8n0klzgkrWXDBZ02Vnr/VfQi4YDGki3a4K1D6XoEXToy
        rQnjwWLQGcaa+cT4t+mmZKg5mquIASU=
X-Google-Smtp-Source: APXvYqxPRIp9prHj/Y1Dx0HBY0e2WievSrsHr69rw6LQIoBe//CRQXCuhtnx47x7M1qQjBoPHDaRSg==
X-Received: by 2002:a2e:d1a:: with SMTP id 26mr22257753ljn.147.1557971413793;
        Wed, 15 May 2019 18:50:13 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c23sm669219lfg.43.2019.05.15.18.50.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 18:50:13 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 14so1547925ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:50:12 -0700 (PDT)
X-Received: by 2002:a2e:978f:: with SMTP id y15mr4350081lji.125.1557971412623;
 Wed, 15 May 2019 18:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <21598eb7-8ff0-2b6b-4cab-c0d1295fd46e@wdc.com> <mhng-54fad465-30c1-426c-84c1-99fd4ac827b0@palmer-si-x1e>
In-Reply-To: <mhng-54fad465-30c1-426c-84c1-99fd4ac827b0@palmer-si-x1e>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 May 2019 18:49:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBRKqBHe5Au=TpDq3B5p=AFKvpaf_7XSU3Mv0MgfGj+A@mail.gmail.com>
Message-ID: <CAHk-=wjBRKqBHe5Au=TpDq3B5p=AFKvpaf_7XSU3Mv0MgfGj+A@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 6:43 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> Linus: I'm not sure how to tag this PR as a mistake, so I'm going to just send
> another one.  If this gets merged then I'll handle the follow-on.

Just emailing in the same thread ends up with me hopefully seeing the
"oops, cancel pull request" before I actually pull, so you did the
right thing.

To make sure, you _could_ obviously also just force-remove the tag you
asked me to pull, so that if I miss an email any pull attempt of mine
would just fail.

.., and if were to have ended up pulling before you sent the cancel
email and/or removed the tag, it's obviously all too late, and then
we'd have to fix things up after the fact, but at least this time it
got caught in time.

            Linus
