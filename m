Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AC10C669
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 11:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfK1KIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 05:08:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41707 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1KIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:08:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so7196143otc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNk3xsUZ+oSOk7bRz+4Bga5ws+iYwn78Pcl6qMinSnY=;
        b=u8f2cCPVHZdz5qbvTe0N+QH3BCTn+DwqVU0ovpjUW79cGc/UyyhtcJJDTeTFKMzGNO
         U8g5im8MNI4A0rVudkS7ji/3SJFqpbCmvfznJYiZK5BHS8n2zS7fCrB37gHSN5BMxlIB
         Q9gT6Xrlp24+3ZTzKcyyQ8IyiGi1lUW7SsjKh4JFC0rhSy/BiQbkvnKjoqP498OAKrwp
         FYX3Fu/Oa4snpMTCJl/SErXgEZQ8diNkkl9X0pw5X5vGUprmk4slAiXwJ4vnhEnyt65T
         BWpQ+reXf0KINt53gWxAaAWYw+La2rjfJFu3GlnYMs36ebMku6FnQIHhntTsfSiQ1jF3
         ObgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNk3xsUZ+oSOk7bRz+4Bga5ws+iYwn78Pcl6qMinSnY=;
        b=qtuwVO6ahVZOCLHlrmfxyoalTsU2yUfR0PzRuyXmqT8l8oHYguwtvDKrU9iiYCa+Si
         5Thq5DWf1lfg8cB82q4VzZ9aVOkkAcNCXLEhftK9CxfLZABOe5Xk9ZyOkxlA5LkpcjuA
         aciX5Ix9LKJofO59NwdEY04gmFZ8FPkwUD6yXSL7QGIaiiOw9AOgyChKVW2Uqq5doVAS
         brLDR2zluU+yIrTBnPkoUYGHbCPYL15BWrfTJpo4v0wFTms3V//udrsKYD1TFtg4Fpkx
         wARnEILA1eFZtEU/jG9Jva57zCd/O65kuyNENeslsF0vA7LbZqAULKQZatf69Wqk51xN
         Nc4w==
X-Gm-Message-State: APjAAAVX8CK/0d5UesFW9V8VUXVcacmE5YFBZetCirkfNxKJ/uquZeqI
        UCJUoa7vlGM0fFwCCxZgGP0+yvP+G77+b8pjiic/4p46
X-Google-Smtp-Source: APXvYqy2PMUfNncH77DaOJWnaAOzBzAJN4hv+1PXYJ8YkR9dHaty4QhojiAF5D2tEVm+0gdwe0n1c7sGXOEfpITUctg=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr6749995otf.32.1574935692364;
 Thu, 28 Nov 2019 02:08:12 -0800 (PST)
MIME-Version: 1.0
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk> <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
 <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk>
In-Reply-To: <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Nov 2019 11:07:46 +0100
Message-ID: <CAG48ez1v5EmuSvn+LY8od_ZMt1QVdUWqi9DWLSp0CgMxkL=sNg@mail.gmail.com>
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:02 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 28/11/2019 00.27, Jann Horn wrote:
>
> > One more thing, though: We'll have to figure out some way to
> > invalidate the fd when the target goes through execve(), in particular
> > if it's a setuid execution. Otherwise we'll be able to just steal
> > signals that were intended for the other task, that's probably not
> > good.
> >
> > So we should:
> >  a) prevent using ->wait() on an old signalfd once the task has gone
> > through execve()
> >  b) kick off all existing waiters
> >  c) most importantly, prevent ->read() on an old signalfd once the
> > task has gone through execve()
> >
> > We probably want to avoid using the cred_guard_mutex here, since it is
> > quite broad and has some deadlocking issues; it might make sense to
> > put the update of ->self_exec_id in fs/exec.c under something like the
> > siglock,
>
> What prevents one from exec'ing a trivial helper 2^32-1 times before
> exec'ing into the victim binary?

Uh, yeah... that thing should probably become 64 bits wide, too.
