Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617DB4BB89
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfFSOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 10:31:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40050 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:31:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7328210pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXioLI4ccNXuZ33HgVEpCi8jpqiCJ00T1WpUkqmwUYw=;
        b=hlgsbTM5UcZQlT+as20mX6TTptl1Oi2Jaf5ZfM41SkZNzwroOKbCyFsCv4fU3KXz1V
         1WRllA1Chn6owFJRI/EXKOz5vkPIYIbsYtzfKd2SXLbQtRbYPzn7zmN59pGuJFjl4z3b
         o8lR9ehnDTdPGftISnLyR0GJlitieRuHdgjPTrkEN5ReXu8Ekhi8vOWoHfiCus23XaZL
         41mzUm8VWcBkGVaP7pN2+DmjaLEw0CsA6xOgJP4Iqz8bXkP71Z4lO0Z8xOmP15BNsV8J
         kcM2tlqkyySFNqsvzwANLL7W/mG9/YQce1x2mbO+jI+0Z+AWDeV/lyuXZJbmoJjWhejy
         LLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXioLI4ccNXuZ33HgVEpCi8jpqiCJ00T1WpUkqmwUYw=;
        b=NO7kk+LawXMxqPv4BonpoNpsz/qZlASojR7Eg34uVFr3XuPv40V2WoZmk95aSzwOv1
         j0DioVrbdaxQFbVYjA+XNt1bZA+gJjOa24N6QomRkEiOSLfXTJuHEapNqtIMGlW9DZD+
         arVMwj+qdxuWAu8ycGyoW8PmbYGOAmim45UtIh55KnEfDLh/egLRAwjetRLevTQpYK+p
         IJQ0XwDN7WEt58oonCVe5VqJuYpW/ej1d0aJN6wHzbEveU4cunCOQndzQox6Ry7hVbL2
         buX0SgOE7use9CuH2ycvyi5YA+sN+qIRCk/TnUS1l4rdeouZxTd6bp4ptG6VUtWSRoTm
         H7aw==
X-Gm-Message-State: APjAAAUNdj5VMDpblJJBrSwaS6QRLZaLhRWQyFH2BN5HL4dKosMnl1wf
        3cwCRbId0oOv8Rpv7qO0+cBKGY0wourEYVauY8lQKg==
X-Google-Smtp-Source: APXvYqyJiPokAPdYnARPmPP+MPZ8yDlJF09SJR7TRCKGI9xwpOutJFrHS7Faa3PFxAG0K9j5yvqYCtIAFr24I5AEEak=
X-Received: by 2002:a17:902:4183:: with SMTP id f3mr3933700pld.336.1560954715477;
 Wed, 19 Jun 2019 07:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <b3761c6479a49b60316325ebc22da904e36d4538.1556813333.git.andreyknvl@google.com>
 <20190502163907.GA14995@kroah.com> <CAAeHK+w9xGtaQ5oSCq-=1YNk_11T2Tz9LKehkL7ZsAz-XwKajw@mail.gmail.com>
In-Reply-To: <CAAeHK+w9xGtaQ5oSCq-=1YNk_11T2Tz9LKehkL7ZsAz-XwKajw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 19 Jun 2019 16:31:44 +0200
Message-ID: <CAAeHK+w-Ok_3_ath67u5=J71cd7pEBw5iobFj_2VLhH6ZcqeCw@mail.gmail.com>
Subject: Re: [PATCH] media: pvrusb2: use a different format for warnings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>, linux-media@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com>,
        syzbot <syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 4:30 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, May 2, 2019 at 6:39 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 02, 2019 at 06:09:26PM +0200, Andrey Konovalov wrote:
> > > When the pvrusb2 driver detects that there's something wrong with the
> > > device, it prints a warning message. Right now those message are
> > > printed in two different formats:
> > >
> > > 1. ***WARNING*** message here
> > > 2. WARNING: message here
> > >
> > > There's an issue with the second format. Syzkaller recognizes it as a
> > > message produced by a WARN_ON(), which is used to indicate a bug in the
> > > kernel. However pvrusb2 prints those warnings to indicate an issue with
> > > the device, not the bug in the kernel.
> > >
> > > This patch changes the pvrusb2 driver to consistently use the first
> > > warning message format. This will unblock syzkaller testing of this
> > > driver.
> > >
> > > Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
> > > Reported-by: syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I don't think I see this patch picked up anywhere. Should this fix go
> through the USB or some media tree?

Ah, found something here:
https://www.spinics.net/lists/linux-media/msg151398.html

I guess it'll go in with 5.3.
