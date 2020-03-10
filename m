Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10161808D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 21:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgCJUL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 16:11:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34809 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:11:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id g6so15291040oiy.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3vOtJHo8wa+L0rub3QWCJZcPdNt+IghtsNXVMZnf9o=;
        b=m/uY0trWMAr4FqVX9i9CSnmjQPURPHBOvx6pe5fEMWJ/e5Tk2vaRLevTLCVkqDclV/
         9U8dYbHfSmT1VryWEJSOssyM6R8QAQdwr6JjSl1yllVynLdhE+EqANllz3GJD9T5HKJx
         5o1mk82fLBEMHb75zYy13h8oqLlVg+LksCTipqO4JL4jJKJTlWmW0OpW3rTbODkp5lQD
         o6zv+ZZn4FMnxGec2LxSQUD3vMa8YdhAk6f9V4RcuRPJetmizxPCHUgu3hzhD81e8CVo
         Qx3HgSr4qFdSi9ME0sT7JSnsZUpOvPvCvsVRKmVC565oSKAhwb9Ar6hsa+h/gil57td2
         EUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3vOtJHo8wa+L0rub3QWCJZcPdNt+IghtsNXVMZnf9o=;
        b=ZQz/kYUWmx5uXxZgT4LRmYiPf1ZjsGedyuzmVmiIWq7P1PX6MEUaHrJqzW5F1Sew8t
         wXk6atlReUdlNS5+oDA6Djrg99T5Kd4ByktFam+e394sTcJ5mxREDWCQR8ZJkxUk71/+
         KleAJSxmczGT8az/MEWJwxYYm+qPPpAoFJ4b9TUmOFQNlVZwe3F8ADm3RNTrftNBVv8R
         a3XjFtcKhtiLlFIVihO+6vz+IiyfDVrE4Rdxsm5ctUTJwX8RDHaZVQ8Ye/GcHvXo2+TO
         u9uUpj56q5+8HWWGRXHKQq/x0yWTWUqcAVLRQPjOiH7FPhI8PG5Rfq1a6LDZ06X/Zmve
         cpIA==
X-Gm-Message-State: ANhLgQ20vA03wDLMI7AJRdc5+sR6Vud5nuJ6nxSGrHDujboY/d1/hMPr
        Hz/OQ+0aSryI6AoL9nq+RB0r1sDTwrOTMU0RNLtXiw==
X-Google-Smtp-Source: ADFU+vvZVc2KY+6w3Oc3P2SV7qOVRFP8YKpYN4giT8uBe7Bxf6wvbyMTpIifKCNOOu6O6nioDLX4rtyrr5xoVXiS41s=
X-Received: by 2002:aca:bac1:: with SMTP id k184mr2032952oif.157.1583871086051;
 Tue, 10 Mar 2020 13:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <87r1y8dqqz.fsf@x220.int.ebiederm.org> <AM6PR03MB517053AED7DC89F7C0704B7DE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB51703B44170EAB4626C9B2CAE4E20@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87tv32cxmf.fsf_-_@x220.int.ebiederm.org> <87v9ne5y4y.fsf_-_@x220.int.ebiederm.org>
 <87eeu25y14.fsf_-_@x220.int.ebiederm.org> <20200309195909.h2lv5uawce5wgryx@wittgenstein>
 <877dztz415.fsf@x220.int.ebiederm.org> <20200309201729.yk5sd26v4bz4gtou@wittgenstein>
 <87k13txnig.fsf@x220.int.ebiederm.org> <20200310085540.pztaty2mj62xt2nm@wittgenstein>
 <87wo7svy96.fsf_-_@x220.int.ebiederm.org> <CAG48ez2cUZMVOAXfHPNjKjYsMSaWkjUjOCHo0KYZ+oXQUW4viA@mail.gmail.com>
 <87k13sui1p.fsf@x220.int.ebiederm.org> <CAG48ez2vRgaEVJ=Rs8gn6HkGO6syL8MpSOUq7BNN+OUE1uYxCA@mail.gmail.com>
In-Reply-To: <CAG48ez2vRgaEVJ=Rs8gn6HkGO6syL8MpSOUq7BNN+OUE1uYxCA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Mar 2020 21:10:59 +0100
Message-ID: <CAG48ez1LjW1xAGe-5tNtstCWxG2bkiHaQUMOcJNjx=z-2Wc2Jw@mail.gmail.com>
Subject: Re: [PATCH] pidfd: Stop taking cred_guard_mutex
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 9:00 PM Jann Horn <jannh@google.com> wrote:
> On Tue, Mar 10, 2020 at 8:29 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Jann Horn <jannh@google.com> writes:
> > > On Tue, Mar 10, 2020 at 7:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >> During exec some file descriptors are closed and the files struct is
> > >> unshared.  But all of that can happen at other times and it has the
> > >> same protections during exec as at ordinary times.  So stop taking the
> > >> cred_guard_mutex as it is useless.
> > >>
> > >> Furthermore he cred_guard_mutex is a bad idea because it is deadlock
> > >> prone, as it is held in serveral while waiting possibly indefinitely
> > >> for userspace to do something.
[...]
> > > If you make this change, then if this races with execution of a setuid
> > > program that afterwards e.g. opens a unix domain socket, an attacker
> > > will be able to steal that socket and inject messages into
> > > communication with things like DBus. procfs currently has the same
> > > race, and that still needs to be fixed, but at least procfs doesn't
> > > let you open things like sockets because they don't have a working
> > > ->open handler, and it enforces the normal permission check for
> > > opening files.
> >
> > It isn't only exec that can change credentials.  Do we need a lock for
> > changing credentials?
[...]
> > If we need a lock around credential change let's design and build that.
> > Having a mismatch between what a lock is designed to do, and what
> > people use it for can only result in other bugs as people get confused.
>
> Hmm... what benefits do we get from making it a separate lock? I guess
> it would allow us to make it a per-task lock instead of a
> signal_struct-wide one? That might be helpful...

But actually, isn't the core purpose of the cred_guard_mutex to guard
against concurrent credential changes anyway? That's what almost
everyone uses it for, and it's in the name...
