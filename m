Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CD15267A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 07:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBEGx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 01:53:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgBEGx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:53:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so1149476ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rHfdxHhDLs+MM9uoNDxMNVLPLgX0yrzzDYb5bvzyPs=;
        b=YqGr520gJK49j9BS5djcnSQIVbFnezOdeXThn4a1UvkDe+fWAXI8xjLPZY/2hHQZgw
         W3dIK16G2ofRNyK8gtgqWihIhtD+XeKORIC66fA0OhNPtqIUalUUUfOHoVpoMxJwot5r
         fCn2gNfkYPjnpRyHiPVn/3Q7Io9ydT/2hly3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rHfdxHhDLs+MM9uoNDxMNVLPLgX0yrzzDYb5bvzyPs=;
        b=uCeivvEAhcFzu9/8DMLwLWvNRMA/FmLZH/VGBQI7e/oxD3+58xkRO3mpwAV0Y4MzEa
         6HvjdOnXuJvS6+uEOaQEOqy66CTub5UN/H4N+6Hat7dkazgZnKxGdz9s+kJT3xkX8/sc
         7KlkNJZmYvarmL0X7t65CIFtkv7ayoNkC1GQRhKGL+K0l5/sg3a3ygTxBo5o3fNXd4X6
         TbRLN9P//cMFOprkmnu+Cu7zUcwURCzd4VAOiCe+eKxEFuJRdWMR95gD3Pz4GrjU4tUC
         8sIYo6gUbZtvMxqTBQkIB8B57dxO5mRop5JGuZ+NzHQaSagRrk1441Fy8Iccstju02zv
         4hww==
X-Gm-Message-State: APjAAAWlL2BgO1NEezW5pq4EH/2WAVvhnuB8PfqLgiUB9a2ZOgawbTXB
        Z5H5AYL64gZtUPE3mjddBVnreJzsh6ImJQ==
X-Google-Smtp-Source: APXvYqxKO5ZtR9Q2dxwcFeLqbOvpNCwOKI9JYWzuPPolg6jYjf9eaQGDdX81rktJ09z++nD0krFMJA==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr18080863ljk.139.1580885605145;
        Tue, 04 Feb 2020 22:53:25 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l64sm11638012lfd.30.2020.02.04.22.53.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 22:53:24 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id c23so664453lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:53:24 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr17364590lfa.30.1580885603756;
 Tue, 04 Feb 2020 22:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20200204150015.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200204150015.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Feb 2020 06:53:07 +0000
X-Gmail-Original-Message-ID: <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
Message-ID: <CAHk-=wivZdF6tNERQp+CXyz7zeN4uG9O4d7mZhCrp3anJ29Arg@mail.gmail.com>
Subject: Re: [put pull] timestamp stuff
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 3:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         More 64bit timestamp work

Heh. pr-tracker-bot is not replying to your pull request, because you
misspelled the subject line ("put pull").

But pr-tracker-bot _also_ isn't responding to the one where that
wasn't the case:

   [git pull] kernel-initiated rm -rf on ramfs-style filesystems

and I'm not seeing why that one wasn't picked up. But it seems to be
because it never made it to lore.

I see

  To: Linus Torvalds <torvalds@linux-foundation.org>
  Cc: fsdevel.@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
  Subject: [git pull] kernel-initiated rm -rf on ramfs-style filesystems
  Message-ID: <20200204150912.GS23230@ZenIV.linux.org.uk>

on that other message in my mailbox, but I don't see it on lore. Odd.
Is it because the "fsdevel" address is mis-spelled on the Cc line?
Strange.

Anyway, both pull requests pulled, even though neither got a
pr-tracker-bot response for two apparently very different reasons.

               Linus
