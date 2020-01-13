Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67FF139A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAMTTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 14:19:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42041 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:19:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so10035963otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoYTay9gEdUwJzd8flck47gwEsidyqOErVEeC39Jq2o=;
        b=PWAQO6n8uYq2a4CdtE53n1PqHPbBvA3iHygW7xlF/mSri9aldE4CMUkmnObd7hvGs+
         XD3R1Xw11ZzgSnhSmK2jiytZo/UPfvHdS8pHGjOXyjnUpk963f33BYXN60mn6ZimSH7g
         iiZRP7Sm1suyhXpkmTz0ed2tCy9XjdSobgkM3xuDVIL8GV5mRpPyinERHpcyJgDMCaIn
         j+f26vKogVX03oygCZPnkb35fMmNiERhbVQNmh0mCoevC5PTlQTz2jgggfS3utSfwGla
         fT5WYAnROxmU06T+LAPng4nnHMe9Zi4KN5FYNFewShO4WtQI1iD4Zd5FGjZ8i9u1WEvK
         +kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoYTay9gEdUwJzd8flck47gwEsidyqOErVEeC39Jq2o=;
        b=Bdyp7r4GdvNWIf/H8fZ3yia9CIoSXO9IrTt4Ti5oXIKc8AEQDBepZN3+SF+aFvCdPY
         oP+nmKUP+aECVT8Sxv4Gii7IdPLDP50MCxxDxOEBtYaAx7JGl4PW91RHjkjGD/rz6MnC
         4dL3W3pEuJt3juLWzJN+Xm82UwjTG8GlVV+8kkVVp9ACg18Wk56cBd742KF0dXVgvIjz
         MLU1wM112YfW4aFdsA0cOc7u8AENGF8pgF7seikcX/11AZfNn7rReCDyZatAcoLrYiF3
         yVa1RpEH8DXL6l+ELqy09br/rGrbUgUpscBtUuTaO/V2ueGeD340Cmib54izLQrAZCfB
         iksg==
X-Gm-Message-State: APjAAAUfDLMa2rVGdZuO/rZa1rVcU71OjIh19OQFKpKKq2NGu8Wa/vsX
        fDjSXjGBFXAGgkU4QISMT+Dh44/9IFnUYFIDMVa9tAPH
X-Google-Smtp-Source: APXvYqwzd6z4BsjCgwUlGC6h2jl1N7nb469FD4i67Yk4Xbt8zlAhmtvz3QdfKHsOBvBT2VACljpoCk6xfa7vX5xy6N0=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr14712535ota.127.1578943140656;
 Mon, 13 Jan 2020 11:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20200110213433.94739-1-minchan@kernel.org> <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
In-Reply-To: <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Jan 2020 11:18:23 -0800
Message-ID: <CAKOZuevwbQvrFWqy5GOm4RXuGszKLBvRs9i-KbAi3nPcHhwvSw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020, 12:47 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > +             size_t, len_in, int, behavior, unsigned long, flags)
>
> I don't like the interface. The fact we have pidfd does not mean,
> we have to use it for new syscalls always. A user may want to set
> madvise for specific pid from console and pass pid as argument.
> pidfd would be an overkill in this case.
> We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> allow this?

All new APIs should use pidfds: they're better than numeric PIDs in
every way. If a program wants to allow users to specify processes by
numeric PID, it can parse that numeric PID, open the corresponding
pidfd, and then use that pidfd with whatever system call it wants.
It's not necessary to support numeric PIDs at the system call level to
allow a console program to identify a process by numeric PID.
