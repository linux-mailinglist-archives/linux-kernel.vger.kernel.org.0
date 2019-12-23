Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCF0129B70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLWWZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 17:25:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42071 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:25:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so13439762qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 14:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBSCcguh86RU2MjYQybWUO1cC1w1F0GMFsIwQi3RaQ4=;
        b=XxczpVoUvwkL3j5zifDkQaf7UzpjuvToIQKVamcSYSQoI8+w3NlOKrfRdGHk9zKAkv
         MTOVmNlZ6kbOAaqjGIWwMJA0ovy2kfYk7yrqfYpqSH8jKviEHzs1UEGRjkrKyCwZ1qL0
         F9gpSF+Um7poLCqxIa7JXhHS26Q75LRH4hxxnEQ2KCHQ97N3ipmaItUevjFkZuVpTSUA
         vjBGjvb1rb9TAevzDgixp9Oej1B0mZrK6/Of0PuBt7c7DSL7j5pgi1+W26pk38It4iOR
         WGml2hirA+OXL3WXB65+NtpP4yHVN8hcnk9raENJd4Koqw/2xn1LxGW6tTlYwAguDuvG
         fdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBSCcguh86RU2MjYQybWUO1cC1w1F0GMFsIwQi3RaQ4=;
        b=Jff6XeLDdgdZdlHANphR7/JYogsv9nWOV2BMgdcc91xYNPnHDkq2GfMyMm1h0lgGvd
         BFMOYYBrKRv04OAtEc1Erz2I/0h351PKOWoFIclo9lrLpDXLYX9vLEQ4KmluzHHqcnvf
         4395+3OowDyWvZsM9LSN83ZAtZAL74D8uCkd+9GpbLONV0IyKT+N0ro/YkUbvHy2qJqK
         AQ7yfgXeAmo9OtOpq7M3dE13+soRvrdfJ4VcYTpaONgIdpGff16XaWtwrHTDZoihXKJ7
         hvyUr7BPkiSLuv4Prjf6JjwERukXS4nVGbLCKD4Gqk/jm+hLR1jJEn+TgCd9iIaeVgt8
         8pug==
X-Gm-Message-State: APjAAAVdDBlTLxgBtXmgjf8XT2mMWHiWXG0hQkmrAO+HcC9hfXayD5z4
        5TJkhgoNXhSaNpQMlOAs83sPE3O/4bWSsj0VuOA=
X-Google-Smtp-Source: APXvYqyHnD19kKfSR3we78qYA0sDLcQ8RWtrGDmHKcJqAwmVdcZ7qCvLx58GFR51v4Nr9Ys7QVXzXuCY1ywSMJuBapI=
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr27439986qkg.71.1577139929155;
 Mon, 23 Dec 2019 14:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20191221151813.1573450-1-raj.khem@gmail.com> <20191223171043.g54secptjtqkhuve@box>
In-Reply-To: <20191223171043.g54secptjtqkhuve@box>
From:   Khem Raj <raj.khem@gmail.com>
Date:   Mon, 23 Dec 2019 14:25:02 -0800
Message-ID: <CAMKF1sqvEH94Abv2Ptz3XTCg6hGk9tQ1Dr86RwYn+bpSLQVyxg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed/64: Define __force_order only when
 CONFIG_RANDOMIZE_BASE is unset
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 9:10 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sat, Dec 21, 2019 at 07:18:13AM -0800, Khem Raj wrote:
> > Since arch/x86/boot/compressed/Makefile overrides global CFLAGS it loses
> > -fno-common option which would have caught this
>
> If this doesn't cause any visible problems, why bother?
>

it does break builds with gcc trunk as of now e.g.

> Hopefully, we will be able to drop it altogether once we ditch GCC 4.X
> support.
>

gcc10 is switching defaults to -fno-common so we need to solve this one way or
other, I am not sure if gcc 4.x will be dropped before gcc10 release
which would be
in mid of 2020

> --
>  Kirill A. Shutemov
