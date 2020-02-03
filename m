Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D67150EAE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 18:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBCRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 12:35:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41613 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBCRfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:35:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so15553706ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG+6B41kuMUO4MlgmmaIjJFesunEaxv6J793bDCq9tA=;
        b=JxadzzTrcUsyEnMxTTvf/OPUdgp68RyYoD7xlWF8FCfOh7XpGYzkaGtj5IzoN9XI9Q
         R/+BlPWCfdGWYQFT8eCrZnolA9DxzM2Zc1tp+Id3cDfTJYJJJvpHe3axYVbjW3ApcL+t
         9uPabRgCZ6k19Q3NlXKP6bhqbpKo7RE38E9rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG+6B41kuMUO4MlgmmaIjJFesunEaxv6J793bDCq9tA=;
        b=pwnMiocKldPI9fuZX2QjIjSrHSK+0gDg1q9ptHlbL8Jp8BtfrkK62Dd1/FqkkTWfbt
         okNKBTz+YG1rKWdX37UKLJmbc+pJ3818WTDaRx74psEjR5mFhSmG5bo7UdrZHcBrpWLg
         KlndUyN6aJ20GKroe8nVG0UezZQBEwQ9NIkmnOKl40hV8wFMJzStaD1WXM1lCyoG8dua
         PNtvvISeIoL3lCpALKcSsoTszZVfpMsM2PsrxK8AQ09uzHVL3096oXCUK9hWkiZGAmtT
         y7xlbKYgIWqggEZbw2Z6nObZFECCuP8xGZSiT0JGPldPM+sH3jUf9c1291RHutaGGClb
         dIxA==
X-Gm-Message-State: APjAAAWD5z3HhNDFPLiw/Jg+qCCVU7LQC524nefVy2pOa/OyfRcvCU9S
        ThulBEknGIW/3FTHgN6k0BcKQEmgXGVEQw==
X-Google-Smtp-Source: APXvYqwnaj4YVjgHGlaX+doVZOGJjlpIEm5lQdKlaTSaB7GC8Y14Nb+6+dqJYDk4Ph1fmm0MtM9X7A==
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr14991567ljo.1.1580751327274;
        Mon, 03 Feb 2020 09:35:27 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i20sm9261738lfl.79.2020.02.03.09.35.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 09:35:26 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id z26so10234426lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:35:26 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr12458719lfm.152.1580751326085;
 Mon, 03 Feb 2020 09:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20200203164708.17478-1-masahiroy@kernel.org>
In-Reply-To: <20200203164708.17478-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Feb 2020 17:35:09 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiERN+VgxBEOUKMhZFG-yAvVjmDSZXGR22vQBZETQ75yg@mail.gmail.com>
Message-ID: <CAHk-=wiERN+VgxBEOUKMhZFG-yAvVjmDSZXGR22vQBZETQ75yg@mail.gmail.com>
Subject: Re: [PATCH] initramfs: do not show compression mode choice if
 INITRAMFS_SOURCE is empty
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 4:47 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This commit hides the Kconfig choice in that case. The default cpio
> is embedded without compression, which was the original behavior.

Btw, is there any way to figure out automatically what the initrd
compression is (for the external case)?

Because I think it would be lovely to be able to have sane defaults
for the CONFIG_RD_xyz things.

I'm assuming the answer is "no", simply because it comes from distro
installs, but I thought I'd check.

                 Linus
