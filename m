Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2148D11FAD9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 20:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLOTvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 14:51:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43441 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfLOTvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:51:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so4361113ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6ga5Dij19gRlbZuFsvjV48za8B/ozUT+pF6pWHLfdc=;
        b=EKgmCh3VQlwvNo2cKRez+F2dNTyhNipLcOxSlHHRddG2LPsdMyWZ6gjxZifjjL8Nrg
         GsrGGw/+RTAmX49CoqvKLZPmgeHNho5AnGcp+OhZDacyAnfwqFDiKiWkMI0W+QLHLAJW
         60XKpY2owTpOLSh8k/lLAJHpqBQY1EHpkjfgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6ga5Dij19gRlbZuFsvjV48za8B/ozUT+pF6pWHLfdc=;
        b=SC0Jxu5XYMM251ZHGjWw2EqRAdc3UpE9AV1QTUwhE6zgBlE0SFYnB21rIXwnP0H0q1
         AmcwVM+3d1sNHxjcqv5g5AfXQjEjlAZpPSCIwHgDiLUc2+o9IUpl+bYoTCh6JNmT3yhC
         vLqvFJIw/cv8qb75BcHfuUQGSUrIcETHEJ20A/SprAKVXACDC4/y4mYtkFU2pTh9XtpR
         KMqRQoygN7Sw3aPZld7hFeuompc0h01wJi9wp+7Qo2nJ09t8/GbMrPsrYQe4fgIqrZly
         ADu7h+z4yDdFJnKNSdkae/njujJRPPs6dLeIjMzdRkW1Qy4ah2LMAffeMCZSSTrIJKiw
         EXgQ==
X-Gm-Message-State: APjAAAVjntUip1+t6LUUYgmj8nkOroW305dMGEDnV3TEIh2iabvsmPmq
        RNpq6udyWPsYi9rTyBgFItnQhGqxy20=
X-Google-Smtp-Source: APXvYqxoxstUFr7MJqNRedCNQQRBCqDI0Oqtt5tgHkpsfWgR8Vuu0Cl8hO616K0xB9exC2Ls0zmpnA==
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr16976229ljm.68.1576439464441;
        Sun, 15 Dec 2019 11:51:04 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m8sm8952801ljc.16.2019.12.15.11.51.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 11:51:03 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id e10so4389174ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 11:51:03 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr17333620ljj.1.1576439462915;
 Sun, 15 Dec 2019 11:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
In-Reply-To: <20191212181422.31033-1-linux@dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Dec 2019 11:50:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfD_b6fS+tYp68gVFw9qB7FgTGa-coNHZeho0B6t3nMg@mail.gmail.com>
Message-ID: <CAHk-=wjfD_b6fS+tYp68gVFw9qB7FgTGa-coNHZeho0B6t3nMg@mail.gmail.com>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
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

On Thu, Dec 12, 2019 at 10:14 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
>       the fifth parameter (void *data)
> is either NULL or refers to a full page (only occurence
> in init/do_mounts.c::do_mount_root()).

We probably should aim for the fifth parameter being a "buf, len" pair
at some point.

Then the system call interface still needs to copy the whole page and
pass in PAGE_SIZE as the length, but it would be a better model than
the magical fixed "it's always one page". And the kernel init sequence
wouldn't need that silly temporary page any more.

                 Linus
