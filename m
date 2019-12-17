Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168BF1225F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 08:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLQHyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 02:54:47 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40475 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfLQHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:54:47 -0500
Received: by mail-qv1-f68.google.com with SMTP id dp13so157098qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5l4//tPqX8+cxTOuVs9KhFWMcYb3LqJ7eqQCoXvsPxY=;
        b=JtqePC7JPCUwzjZCicFvgmrDaO2OrEUtPvbcwc1FQlvPkP/Nr5WqRH1sUgkLsTD49C
         GQcnHD8sQvmsih/7vEVjX/Oq5itDIJNrQZMgZ20zAul4YhHdJPFk9IAuShMV27TPTgpz
         /f+ebSQ3ADIW0Qz37pCLKNUSZ2WVpPOFTo/NDNjdWIaqddOK2vPlPcE4H49f+CXpngS1
         VTGtRnAUMEAAKNddG4QmNgfm2LThzHdw01NbPElkKLRDV/bUQlpBQRfBZEE/gjmJYq2m
         Z4fA0oWtRv9IPEXgJqbO9eHnuSz7F9vy4wo6SeaarY51Et1dbkzL0ym7cOmrrHxp0Kj3
         jJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5l4//tPqX8+cxTOuVs9KhFWMcYb3LqJ7eqQCoXvsPxY=;
        b=kkTcCORrFeIGgYHTGbc/9B3yrQc1sLmRjgf9zgMRljc0OfPjpXNik401rbA9DzDHU/
         u6xkMiKoIWRF/62dL6juU6+4SAG8H7liz14h3KYWJD0WltSkRmQFBaSVETe8gU3BPy28
         MDV+UbDltFbT90+akSIGxt7B8gLeprgpWniY7y45zNtD0aMZjQ4OIg1fEYTjwqWA9/U6
         KjZ4DQI4GBgg/yx6tdbvSbNQV/Ml2RkJvtxKOwkriINXD+s5WUGQM97Ot2L6ZI7TADAF
         w5D81PCQfbwNiDcbIuygprUoU5ZUpje0hM9m6yYsWgXYGG26QKFkeUFWU06dFZIhMET5
         XAhg==
X-Gm-Message-State: APjAAAUQGwHk0P4oWOK3y3sa88BkQEL8VmD2g3mZh5+vhsvceob1x/Ch
        1MylRWT1mukSJSpa+6whsztjv3ky/W2yoQ82EOSqZQ==
X-Google-Smtp-Source: APXvYqxIAmSU4Hq1DnMpsxMQfmHADjAfN6vlbcaAj4+89ENlpGdvnI1hnmtAslJOiSFHseYL6+PZmknTP7x1MHM3yIE=
X-Received: by 2002:ad4:4c84:: with SMTP id bs4mr3407059qvb.34.1576569286123;
 Mon, 16 Dec 2019 23:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp> <20191217051234.GA54407@google.com>
In-Reply-To: <20191217051234.GA54407@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 08:54:34 +0100
Message-ID: <CACT4Y+ZV_syKQt6hDwf3WH5-LpFo==rsVsQY7+YCMfpUCtzj_A@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:12 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (19/12/16 18:59), Tetsuo Handa wrote:
> [..]
> > +++ b/kernel/printk/printk.c
> > @@ -1198,6 +1198,14 @@ MODULE_PARM_DESC(ignore_loglevel,
> >
> >  static bool suppress_message_printing(int level)
> >  {
> > +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> > +     /*
> > +      * Changing console_loglevel causes "no output". But ignoring
> > +      * console_loglevel is easier than preventing change of
> > +      * console_loglevel.
> > +      */
> > +     return (level >= CONSOLE_LOGLEVEL_DEFAULT && !ignore_loglevel);
> > +#endif
> >       return (level >= console_loglevel && !ignore_loglevel);
> >  }
>
> Can you fuzz test with `ignore_loglevel'?

We can set ignore_loglevel in syzbot configs, but won't it then print
everything including verbose debug output?
