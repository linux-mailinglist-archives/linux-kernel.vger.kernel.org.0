Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3274311D33B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfLLRLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 12:11:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46059 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfLLRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:11:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id d20so3095279ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICBZ+2Sd9tfmFcrdW3O7fc/UNhWSUyLmfpG5i/hGM7E=;
        b=f0VHPW2Bi/XQejHvGiWUPZHd0FPLqv5MeDX2LcpZSX2vPAG4qO3a/uQ86y5r9XZG84
         Mf2Vm6TfzrZ7/CGmCKCU8WVBw931mlrGteN6eiLSnHarrlxNaQWvqZEaEr4b9rAl3Ut0
         HhzUgFepqD4KQguWxjBcAy40sBWj37ZYsmiog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICBZ+2Sd9tfmFcrdW3O7fc/UNhWSUyLmfpG5i/hGM7E=;
        b=jTvTdImITlPRJUQnK+ZRBWjnOPBMpn/Oa0iHqnoYN2jI8fSXujkhr51BeVt6Gc2NJa
         c7JQgAgrkZyyO907SO0NoWRK6h0s95gxKEe/7HWXVZifxxDuOz7uqbqwXJatv8iysuXP
         DrcirY7lj2sUnjTz+o5VVL6zfb3cxhvsZQQ8iKEHlqhMbwNCloUy0f05XuOmN6ghjDaP
         +UpYvk4rMpbDrW/2VIibyzwLI0mGF1EPJ7SYDDeYpdSAqEoULRQvTnz1/J+rtKhWQE1H
         LbWNjxV8T29QZhrPgG1ho30nrS1zfKqtMm96GSfRu/UT9R/5EnExIRyWi9VORC6SHaN6
         5zpg==
X-Gm-Message-State: APjAAAX2hSuxZ0A78JeuXSlThyLhqBnrvSj07TtTlUsPs02K5R4S6BmP
        kZqBnUGehH6RIdR8KrZoCrEBOuxRXic=
X-Google-Smtp-Source: APXvYqxoZ5LNdSLA3NmM82USBtfJpEa4Qv3aE9925vhEHnI4dDxR77UmHDaLoJyAtosXqgnUM2oYFA==
X-Received: by 2002:a2e:9694:: with SMTP id q20mr6552400lji.248.1576170687942;
        Thu, 12 Dec 2019 09:11:27 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m21sm3212004lfh.53.2019.12.12.09.11.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:11:27 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id r19so3127273ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:11:26 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr6730555ljj.148.1576170686344;
 Thu, 12 Dec 2019 09:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20191212135724.331342-1-linux@dominikbrodowski.net>
In-Reply-To: <20191212135724.331342-1-linux@dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 09:11:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQRXLjXC5YxJd1VHoGpMB6wg=2XaLj1FgH=H+bP8=fDQ@mail.gmail.com>
Message-ID: <CAHk-=wgQRXLjXC5YxJd1VHoGpMB6wg=2XaLj1FgH=H+bP8=fDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] use do_mount() instead of ksys_mount()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 5:59 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> This small series replaces all in-kernel calls to the
> userspace-focused wrapper ksys_mount() with calls to
> the kernel-centric do_mount().

If you fix the pointless cast I pointed out, and put it in a git
branch, I'll pull it.

In fact, just do both series in the same branch, they do conceptually
the same thing, after all.

             Linus
