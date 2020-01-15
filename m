Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69FC13CD41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 20:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgAOTmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 14:42:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40319 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:42:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so13644365lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaRwIBTidRg+FeQMjaWJXF4LpWPIm2ptNeGHjO7tn9s=;
        b=Jws/Fhg/9IKJk9+nS1RTqQGl/D/R2qUDHpS3GKFKtCU0aMrpgYvxxwk+s7k/EB3PQG
         PvYHuYbuMYFbFlZxmS9QO1Dbd5gN7atnObLK9kI8sUR0ADxQryVnxUBd63vqDyd6qx16
         WmkdXjfC8d3E/yNKayDZNJMSD7y4f95VjoUt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaRwIBTidRg+FeQMjaWJXF4LpWPIm2ptNeGHjO7tn9s=;
        b=RY2nHvgStPUyxRAUE0qHTjihr7cNXQuvYtppYbtlUpJuMbNYtA0fbvExdl9j2mk4IJ
         m+TQphNy0yi0i8w5srNwzynDCoN2dFKSxSNMwvC59UD7KS29r3gu+E8xB5rfVpjrptaW
         cJPJUQs4PuBxeKOrTbuQK7xC+kz6yTAJxIE9klRdT4zMeLO2P69tnt1MBwHd5+bgfL6d
         jy6SXL0sitrtPD+6lqNHGvRI8cSiQ/faWf0B1YfFMmqrF2gmgCThksuDGZS3Pash8ZVG
         EFxRvfNZJ27H44An+dRgHrcgpKwesUDPMLMp/A4rb5A+txqGR8Y6m30e9H9gHR1ZvVcV
         vMBQ==
X-Gm-Message-State: APjAAAVhN8uIPNqRjgIaUKtGGIVvsHYdeVWLSRM8yuTZOfOuZxeCSI7H
        NVO46VDHmyIPxuUtak33WNSjp0ybrPI=
X-Google-Smtp-Source: APXvYqwmpnLSpnqD9ORkcjgzdiSDIysAl+kIQZ45O6f8WJoZjMNmo1sKx1qgG4QvfKGaG5NW8An32g==
X-Received: by 2002:a19:850a:: with SMTP id h10mr294477lfd.89.1579117323356;
        Wed, 15 Jan 2020 11:42:03 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r9sm10881680lfc.72.2020.01.15.11.42.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:42:02 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 9so13663233lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:42:02 -0800 (PST)
X-Received: by 2002:a19:22cc:: with SMTP id i195mr314766lfi.148.1579117322138;
 Wed, 15 Jan 2020 11:42:02 -0800 (PST)
MIME-Version: 1.0
References: <CACMCwJK-2DHZDA_F5Z3wsEUEKJSc3uOwwPD4HRoYGW7A+kA75w@mail.gmail.com>
 <20200113154739.GB11244@42.do-not-panic.com> <CACMCwJL8tu+GHPeRADR_12xhcYSiDv+Yxdy=yLqMxEsn=P9zFA@mail.gmail.com>
 <20200115021545.GD11244@42.do-not-panic.com> <CACMCwJLJCA2iXS0QMKKAWQv252oUcmfsNvwDNP5+4Z_9VB-rTg@mail.gmail.com>
 <20200115185812.GH11244@42.do-not-panic.com>
In-Reply-To: <20200115185812.GH11244@42.do-not-panic.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jan 2020 11:41:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOC9dakUZ_BzHq2d5oKXXGnrKf+M-4gZ8U+=F_OX4+Ew@mail.gmail.com>
Message-ID: <CAHk-=whOC9dakUZ_BzHq2d5oKXXGnrKf+M-4gZ8U+=F_OX4+Ew@mail.gmail.com>
Subject: Re: Fix built-in early-load Intel microcode alignment
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jari Ruusu <jari.ruusu@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>, johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> But *how? Why is there a 50/50 chance of it being aligned to
> 16 bytes if 8 bytes are currently specified?

What?

It's trivial.

Address 256 is 4-byte aligned. But it's also 8-byte aligned. And
16-byte aligned. And..

So if you ask for 8-byte alignment, and you already had that address
(or were just below it), you'll get 8-byte alignment. But it will
_also_ be 16-byte aligned just by happenstance.

And yes, exactly half of the addresses that are 8-byte aligned are
also 16-byte aligned, so you have a 50/50 chance of getting the bigger
alignment simply by random chance.

In fact, often you probably have a _better_ than 50/50 chance of
getting the bigger alignment, since many other things are aligned too,
and the starting address likely isn't very random. So it might have
started out with a bigger alignment even before you asked for just
8-byte aligned data from the linker.

(Of course, the reverse may be true too - there may be cases you were
coimpletely mis-aligned, and asking for 8-byte alignment will never
give you any more aligned memory, but I suspect aligned data is a lot
more common than unaligned data is)

              Linus
