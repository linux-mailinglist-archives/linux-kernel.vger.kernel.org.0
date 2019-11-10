Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76371F6B8F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKJVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:11:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33007 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfKJVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:11:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so11612293ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sw0pGWOp+H0Cc/o3nartd+rrdu30v5KC8Ks0EukSTW0=;
        b=RAfCRzWXqkBygzjvTQF7B/q3F9bZcWhNFKa+vgcKxcPhwpgR7QOlK6Eii8RWszMJSj
         /GKxKFp6PJbUk5mDWk1Rs08zEWAX5Km6Ng5cuqqTumC+Wxu94ZiBemBAFzFqqkBvwDF2
         D0F/g+SzyQvat+TyfcmfcY6DipCQs83wis1FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sw0pGWOp+H0Cc/o3nartd+rrdu30v5KC8Ks0EukSTW0=;
        b=A49Dho0UMSVLkQuQ3hbiVNu4CRJVCR6rv0uroUpJFUNY4ei6Ll1YXE67NEqsZTlo5a
         KTfiUmkwUKW+olpbLHAKwMFJWO9BN8yKcKtm4xY61mP3eOHWRnPfnU6ET3YqReGBNt7H
         CvADslccT3kxiS07c9qeUOy4QnBBwdp1EkV6qE8IjPziCJortPXjIWz077JdehL4ySn9
         RGkp7lWKqW4rIQ3uw50lQijDiUNyR0/bmiAYhmUX0PFXqM9o7T/TzWBHswgWdNMMy6yl
         r2mj1BCM+vYlx9yuXJ0AJAZ9l56A/WA666tzMjx2JCORIF/gv8wsNw4nFnx7XAZqE/p8
         j6HA==
X-Gm-Message-State: APjAAAUgCgAzW7X9b91efotPAZJGpENWp9J4tR6Xwg0SH4ZiPXJrRT8q
        d68RCYxmZndaLH/XUgNFz2O5XUFLh+c=
X-Google-Smtp-Source: APXvYqxaIkM/1M9CjQZbYkfFuN289ZoIiU20DYO/vOkizEnMzllUgfvEc0IfZwvHoA/Itd/1OuFaSA==
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr13566744ljm.38.1573420258326;
        Sun, 10 Nov 2019 13:10:58 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u2sm11915600ljg.34.2019.11.10.13.10.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 13:10:56 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e9so11543348ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:10:56 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr13861151ljh.82.1573420256107;
 Sun, 10 Nov 2019 13:10:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
 <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
 <CAHk-=wghq7rmtskFj7EbngpXUTJfc4H9sDcx10E6kMHoH2EsKA@mail.gmail.com> <20191110204442.GA2865@paulmck-ThinkPad-P72>
In-Reply-To: <20191110204442.GA2865@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 13:10:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjm40mcf7tk9DZQXd=dftZw_VpmE837c7pTZ1_cR+t4Mw@mail.gmail.com>
Message-ID: <CAHk-=wjm40mcf7tk9DZQXd=dftZw_VpmE837c7pTZ1_cR+t4Mw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 12:44 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> But will "one size fits all" be practical and useful?

Oh, I do agree that if KCSAN has some mode where it says "I'll ignore
repeated writes with the same value" (or whatever), it could/should
likely be behind some flag.

I don't think it should be a subsystem flag, though. More of a "I'm
willing to actually analyze and ignore false positives" flag. Because
I don't think it's so much about the code, as it is about the person
who looks at the results.

For example, we're already getting push-back from people on some of
the KCSAN-inspired patches. If we have people sending patches to add
READ_ONCE/WRITE_ONCE to random places to shut up KCSAN reports, I
don't think that's good.

But if we have people who _work_ on memory ordering issues etc, and
want to see a strict mode, knowing there are false positives and able
to handle them, that's a completely different thing..

No?

              Linus
