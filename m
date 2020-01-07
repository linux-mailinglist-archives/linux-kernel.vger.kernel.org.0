Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0363B13275B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgAGNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:15:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51768 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:15:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so18894521wmd.1;
        Tue, 07 Jan 2020 05:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XcFe6Azg3XaFd0To0uqPkwELi/kDPwyJ6dIt6qtSEk=;
        b=aT1GH/e8AvTHe5ZtAESsybljucniEiRSvfwjIXt23QKTYzk+h5wuAAsm6shVkiFKkD
         xoHowhD2A6xsW9+Mwbkg9zI+kc2VvJoW2KwzoP1L5TvykA4wmIc+0uWhTnAdNcgFmXT3
         PuBeN/7s81ObFo9IVtYIsmqls3b25kigcnqsCuIagWkQUBvvhB5AKsdIeCyO85HYeo5I
         d4fd4RhkSxGrolYRlG/XdEpgHHvPpEz0d8pavWtVl10b90BUghXSXKFpK4+/3aFtcjJb
         Byny+kxz5bs3+pZpKX/4LLWIaFR5DrwB+gUfkVfAmAMcy8wmxnyPsxH5FW1GbIx0A3zv
         iJWg==
X-Gm-Message-State: APjAAAUP1nQA1wognWJDgff2UzgHTAsvIM3cNxVK70rBMHJX5qcUZHh5
        dNYS9dxEoFqlRxIpxLYEnU155CtqohvG/IBg49EYNQ==
X-Google-Smtp-Source: APXvYqyGnN7bNXxby2LGd+8y446S2vHzdG6/ddOugf7gHJwSgMa/GiO59FOH+2xoC1qjgErIZEs3TE0n4VaDjRcaIsA=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr39337529wmk.124.1578402912643;
 Tue, 07 Jan 2020 05:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20200102122004.216c85da@gandalf.local.home> <CADVatmO8mvhtgZ=CNv8uxhVkh2nqg5bjCLzTxyA9UDerRox8Ug@mail.gmail.com>
 <20200103181921.3858c90a@gandalf.local.home>
In-Reply-To: <20200103181921.3858c90a@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Jan 2020 22:15:01 +0900
Message-ID: <CAM9d7cg8Q9Urm4FLJez-yC5bke7aBSd8JFRLFjU5pNeyxAsHvQ@mail.gmail.com>
Subject: Re: [RFC] tools lib traceevent: How to do library versioning being in
 the Linux kernel source?
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve,

Happy new year!

On Sat, Jan 4, 2020 at 8:19 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> BTW, while doing some minor fixes, I realized I still have generic
> names for "warning", "pr_stat" and "vpr_stat" and thought they should
> be changed to "tep_warning", "tep_pr_stat" and "tep_vpr_stat" for
> namespace reasons even though they are weak functions. Would this
> require a major version change, or perhaps its early enough to get this
> in with a minor version change as the libraries are probably not being
> used yet?

Hmm.. I don't think it requires a major version change as they are not
public APIs actually.  They are internal functions but can be overridden
by external ones, right?

I guess it's because there was a concern with printing messages in
a library.  What about adding a mechanism to register callbacks
(and maybe defaults to discard all messages)?

Thanks
Namhyung
