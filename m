Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2214A635
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgA0Oeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 09:34:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40245 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgA0Oep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:34:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so7489138qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+w00Z+a9Lc3UGBwoCrl8G1pruFGPJ/8zu/QyRd1NbE=;
        b=PjGAUmwkw5hENfh9WggpD4J+4ewz3me369iaHjzeRLHxT5b1pE0b5p+XPhr7qaE06B
         tYxg4Hn9fZoQCb8+9BBtfjC+oIGpB60Xo/82Ef4ZyISG6hNHqX812CY4Cr0qqR93UGQN
         O8p6tzyIBj6ZvJlBWT5R1q8UPMl0vbj3/Wlvn9oqzj037GI7envTjRV4iCZXd+1ZV+Sj
         a79onzpcvgef1qdE63ntplKozKMIvcNjt+JjYIJaPFkiEjztSJtx7747Lz9yHlS167CM
         brk8H8YffPG80bvxknob5+2WXPNlTY6fdLwKlQ8z56lOTMf0WNqVGVzn3E6PnMR4OoHg
         vdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+w00Z+a9Lc3UGBwoCrl8G1pruFGPJ/8zu/QyRd1NbE=;
        b=CCP7NfLXq62/v+e8fceOQL7UVWYsf3BD9ccnmOIAsAqDpg8CLVvKAXV8093LdlvQI2
         /8KE72uV6VAjKitApIWi0Bjk0hYH6HoPjXjXaknnDG/Qa1SqRUXwUtMMQ//yFVvwhlBF
         Yw2eB5XAzfLd3zZOSBcvrYnAxo2PXDVBmyJnptq208c9Qhye/Qe4naysZl+Fz3VBD/dR
         IlTP+1ASvKQ7QZ/KVzdlkZ6WRPnYExQ9rMuBKw2GTIxmRAaLL23Us/UdIyQhaDsZTuLd
         dz5/M/qB07+7ggx8MSUbOPTvGQwH2mg9jhKecIiCset8nrKjfpvdB9rsaEdl2B07edc8
         esuw==
X-Gm-Message-State: APjAAAUrMVVVHDyTMEw4+xCuPAsqh3fcy94QZvXfi2W2biksveubo3MX
        JkdODEL0kJstFVkvDgsg11C1XUV3GM9lEZZivdg4lg==
X-Google-Smtp-Source: APXvYqxVMVrUAZqUZayzZO2qnNrfkdGEBHyN3IVl6dTc/yqBU1rShNCy6+RWgClLHDmVDV8d0UX1hrgHMZhXlVnjU+A=
X-Received: by 2002:ac8:340c:: with SMTP id u12mr15564452qtb.257.1580135684302;
 Mon, 27 Jan 2020 06:34:44 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004dbaf2059c193a36@google.com> <20200126024957.11392-1-hdanton@sina.com>
 <20200127092850.GX1847@kadam>
In-Reply-To: <20200127092850.GX1847@kadam>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jan 2020 15:34:32 +0100
Message-ID: <CACT4Y+ag59G4p=DO3Dg7jnFt3wQb=dtjzBujADtGHKn-97O8_g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in hiddev_disconnect
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+106b378813251e52fc5e@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 10:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> I already fixed this bug in an earlier thread.
>
> Syzbot always reports a use after free as two separate bugs, a read
> after free and a write after free.  It's too much hassle to mark all
> the duplicates.

+syzkaller mailing list

Hi Dan,

Not that it happens always, but, yes, it happens for racy bugs (for
single-threaded the type of the first access is usually
deterministic). Worse, sometimes they show up as GPF, unable to handle
kernel paging request, null-ptr-deref, user-memory-access, especially
for crashes that happen very frequently so that syzbot starts catching
long tail of more weird/unlucky incarnations.

The exact string is under our full control and can be changed. We did
some refinements to strings/grouping lots of times. I considered if
all of these should be grouped together and reported just as, say,
"bad-access in [function name]". However, the problem is that changes
to the strings/grouping will affect _all_ existing bugs: they will be
re-reported under new names, then old will be suspected to be fixed
(stopped happening), fix bisected, some closed as obsolete, some
concluded to be still happening, etc. And we have 300+ for upstream
(https://syzkaller.appspot.com/upstream) + 4 LTS versions + 4 Android
versions + a bunch of internal kernels + all users of syzkaller for
linux out there. So this will produce a whole lot of churn for
hundreds of people. The ones that we changed just affected
significantly fewer bugs (e.g. a new bug type).

I don't know what's the right solution at this point...
Changing the title will include lots of churn.
Marking as dups is too much hassle.
Not marking as dups will lead to hundreds of lots bugs and/or lots of
wasted time for people to rescan list of open bugs again and again,
missed backports, etc.
