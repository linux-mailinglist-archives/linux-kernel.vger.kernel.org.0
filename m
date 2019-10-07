Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1ECDA96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 05:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfJGDMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 23:12:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38528 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfJGDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:12:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so8137191lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYWjgTw5GkrwHymLyJCkMr92dUNrlshJ2F++JeqwTfM=;
        b=PlOETn+6XP6GogbseS1eada7ZC/+jLxJP+MQfcH+4KhnaLD+6vgIQ/uMIIW2W9xdBJ
         y/41fuZuX5dRGnHr9WX5qOggV8VhkLc+0+KHywTkQJ7HT2a/n9EX7ua4fqHF1WX/ykdb
         6sMZfuQaEiLs56OZZqdLOBJrlXUr42OLbFr5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYWjgTw5GkrwHymLyJCkMr92dUNrlshJ2F++JeqwTfM=;
        b=rdTee0FprC7vfDLr3kz4Iw6ujqnL28R7RK/csyxfi809jAZGbEJi06DkDhL7nN0K3T
         ej9DhWlzQX3VDJp4LXSdaQdNG1rC7UXr9r3cbcT8XwDPX4qDHwuScFh6iMKDt1CaAh+v
         XRJy4u/MY1mNcVhV1cYLyhW8AeOamonhCUotP+1hpVJQtiIdhLufXFVoPA6GVjqpjx3+
         fGGF7t1sMLR8Ax1KovJ4Fk1ujzw4nVjerhL2tKA12RhrO4JxPQudkDmBdxQVAMjzLQmX
         d0tr2I0Yx+6WLKUy+pHnbzLL0IcNTpfL1YPtjrJg4hZX+4xo/0iHVoyQPS9KfGtJhfv/
         Nojw==
X-Gm-Message-State: APjAAAVneIpOi81QH+suKl3DnJzLVJK8M6AZE2A3htUri45dyPXuU3aI
        AAk8QRViuKMIhgC1SAKuI+B8/yh2T+8=
X-Google-Smtp-Source: APXvYqywNXRmjtXs38mkqTAkp+gKHKTZeKnsrI5iq6+G6bpwpIMU4VURB7oT2L8dRbNDmoNc11Aklg==
X-Received: by 2002:a05:6512:75:: with SMTP id i21mr15114937lfo.95.1570417970472;
        Sun, 06 Oct 2019 20:12:50 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z18sm2779291ljh.17.2019.10.06.20.12.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:12:49 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id m7so11980862lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:12:49 -0700 (PDT)
X-Received: by 2002:a2e:2e17:: with SMTP id u23mr17071874lju.26.1570417969062;
 Sun, 06 Oct 2019 20:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <c3e9ec03-5eb5-75bb-98da-63eaa9246cff@roeck-us.net>
In-Reply-To: <c3e9ec03-5eb5-75bb-98da-63eaa9246cff@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 20:12:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKUHYSj2iZTaVKHuRve-=V6GJem78Uh6FkGb4pwYZd3Q@mail.gmail.com>
Message-ID: <CAHk-=whKUHYSj2iZTaVKHuRve-=V6GJem78Uh6FkGb4pwYZd3Q@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 7:30 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> > Mind humoring me and trying that on your alpha machine (or emulator,
> > or whatever)?
>
> Here you are. This is with v5.4-rc2 and your previous patch applied
> on top.
>
> / # ./mmtest
> Unable to handle kernel paging request at virtual address 0000000000000004

Oookay.

Well, that's what I expected, but it's good to just have it confirmed.

Well, not "good" in this case. Bad bad bad.

The fs/readdir.c changes clearly exposed a pre-existing bug on alpha.
Not making excuses for it, but at least it explains why code that
_looks_ correct ends up causing that kind of issue.

I guess the other 'strict alignment' architectures should be checking
that test program too. I'll post my test program to the arch
maintainers list.

             Linus
