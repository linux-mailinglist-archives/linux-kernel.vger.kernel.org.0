Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C707FDF9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 02:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfJVAhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 20:37:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44823 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfJVAhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:37:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id c4so140109lja.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 17:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWhaX4k6lFHGGs9vgp5PpGqm7vKA7sqLPJ/OVQwJYM8=;
        b=Mxn6zclG7aCJE+Gbl0eDGL3OWzLs5QH1w1HctpXaXwa9lerQff2UuOFWNngRVL4rXP
         DVdvDkzXv9TwweIDY/j2A/og6LdXEdMN/VBgdnfG92KVKX6hVsFCn4QCtKqr/tGmQ06q
         14m19p9d10EH7vCewH2Xl+BiXNWN+IgXQc0Wh2dJoGP10RmkbAo08sSWzf53pHr3wImS
         pUMTNlgMkEpEHZgE2FuTsgX9cUM/TK53D0iy90ILc3vDdTlNkaip67g+0i2mE4Li2tQj
         X1kbr936re/JPT+azvWX2YkV/0YmW1WpfQk3ageC8tYUU8XlDmFW4RmM93LstdIAb8i7
         /EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWhaX4k6lFHGGs9vgp5PpGqm7vKA7sqLPJ/OVQwJYM8=;
        b=DEDRMDnIocgwveyaHAdH7y6DpWOMa14QQ9w04WkAcGXVGhVt6Pdg3Ph02tfoTjQR0r
         9nSKrI5D2DHH69V26RAw65D5BblUXSh0dnqHbsKhkD7DktZOAyyFXxkO7cKFhYj895/w
         ntOhO0FCou/HOMa/B/7YvDAvlC7ZX9HzWGXA4c8EL6sVt5F3VH8MXcX7kA2Ao+4gxfcP
         pQRjfxgrwxAu7h6aT0YqfInuzXb5NpgaQ8OOIkzNfIzwZ/Ivh/5z/RbzL5HbPWEHnkoU
         c3T8Hbv8dA3pvTpU0gA91INL9wgOmBYDErJ8xEts8sFiIxJVsU8xhxkO0cKBUS8mlRGi
         sK8g==
X-Gm-Message-State: APjAAAV3KrmjtgY+IE8plctpaGDnk4hONRVJyhxsl1b2a7Cpjpp+uaVn
        DAUSpwdq08BMppmyXiYD79NKNTbM26lvQvyTP4w=
X-Google-Smtp-Source: APXvYqzJxVNLIiOghpn1W2rzPihKl7eHGQ0C3yaZSdE3EDpHK+15u/NGo2yCgMTFqy3MF6QpJLHu0T9oTVQysyHklNI=
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr16376348ljj.188.1571704626347;
 Mon, 21 Oct 2019 17:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190827180622.159326993@infradead.org> <20190827181147.166658077@infradead.org>
 <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com> <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home> <20191004112237.GA19463@hirez.programming.kicks-ass.net>
 <20191004094228.5a5774fe@gandalf.local.home>
In-Reply-To: <20191004094228.5a5774fe@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Oct 2019 17:36:54 -0700
Message-ID: <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 4 Oct 2019 13:22:37 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Thu, Oct 03, 2019 at 06:10:45PM -0400, Steven Rostedt wrote:
> > > But still, we are going from 120 to 660 IPIs for every CPU. Not saying
> > > it's a problem, but something that we should note. Someone (those that
> > > don't like kernel interference) may complain.
> >
> > It is machine wide function tracing, interference is going to happen..
> > :-)
> >
> > Anyway, we can grow the batch size if sufficient benefit can be shown to
> > exist.
>
> Yeah, I was thinking that we just go with these patches and then fix
> the IPI issue when someone starts complaining ;-)
>
> Anyway, is this series ready to go? I can pull them in (I guess I
> should get an ack from Thomas or Ingo as they are x86 specific). I'm
> currently working on code that affects the same code paths as this
> patch, and would like to build my changes on top of this, instead of
> monkeying around with major conflicts.

What is the status of this set ?
Steven, did you apply it ?
