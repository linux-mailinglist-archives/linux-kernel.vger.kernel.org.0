Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88FE313F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEaRfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 13:35:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38528 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfEaRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:35:33 -0400
Received: by mail-vs1-f65.google.com with SMTP id b10so7220042vsp.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UT95TGe8i+iSc4Mrslq2c6bgkkgpf7MqKUVEvywS9rQ=;
        b=XkRXGO8rGh8TZ4EUzxfokC5808K1dz1UcgRHXk5nSZXjzX7ByJ9OOS3VUfLxIGGAe4
         tBJOQ41tQiTrAGL8Vqh+uDVv6x0PoGvSasP0vc6fBcPf9wEekZyVRoXaNo1xuJ2Fn5wJ
         Mdw2jJZ25WDo6I4uz8vJmqlZY84v/5BJKw6tSscV26kE59k4+mPTnBO54Ga2JiQ3fF49
         9f36MMHIrDv6UDicgzKbwCc4KmUky3yRfA6nB2SCVng6BOkS7L2+dNFKBJmEgZK6JRI0
         aOaHXvY0eVS+UnHvlhi71Ao0kSR18YVuOC0awHBXNUVnRpG6nJezGgjBM5MLoZEwisfe
         er5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UT95TGe8i+iSc4Mrslq2c6bgkkgpf7MqKUVEvywS9rQ=;
        b=gMyhVM4OOOF24+h8/4vL7DXeS5Mvq77/yIY5yiiCNqm1u5f3j7xlvttzsNJg9dU+BL
         oJQ0JuS5jALkuTkxBYbdFcbifxGpEV2qMkRcdSIhRCuzSV6IFUqwE5kBZwVFqFZHLTgn
         NqvBN+x+YvmGOyu9RgshHuneW4coqMwA3DHCA5fFy6qoy+xnlhz8ARlWQiB3dMeFY4XG
         Ecqx5b8pR8mb05dYwiDVDdEsQRPxNMy1dZtR3IyG6MkPF97CRzoAeIEOlhsuUwLV23Z3
         VAYsWEWqbMdSg2Gg/6KBWdBqn9crihCOre0b+dgiAuL+QYLRqUszZeAoW6EhFAf8eD2S
         B52Q==
X-Gm-Message-State: APjAAAVjkAmkMt5NfzlRAXP2BF9o1XrLrMtLUjqSdF/StWofHzhrNPbY
        MGwf51h1EqZW7gJCvMDOg7MTzOVH6yzhka6szeMhMg==
X-Google-Smtp-Source: APXvYqwXzH1wOrhlClP+4XIXhtYESdkaXQctuZZmUpL+byNkQuwIQh6PWl6WuJPpoo7fr6T7kU+2n6RwqkoaZfzW3Nw=
X-Received: by 2002:a67:2084:: with SMTP id g126mr6137960vsg.114.1559324131824;
 Fri, 31 May 2019 10:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190531064313.193437-1-minchan@kernel.org> <20190531064313.193437-6-minchan@kernel.org>
In-Reply-To: <20190531064313.193437-6-minchan@kernel.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 31 May 2019 10:35:20 -0700
Message-ID: <CAKOZuevswVxZjffQcwjqJFa5V4Vv2jxq=mq6hWhd1SpNrGAGkg@mail.gmail.com>
Subject: Re: [RFCv2 5/6] mm: introduce external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>, oleksandr@redhat.com,
        hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:43 PM Minchan Kim <minchan@kernel.org> wrote:
>
> There is some usecase that centralized userspace daemon want to give
> a memory hint like MADV_[COLD|PAGEEOUT] to other process. Android's
> ActivityManagerService is one of them.
>
> It's similar in spirit to madvise(MADV_WONTNEED), but the information
> required to make the reclaim decision is not known to the app. Instead,
> it is known to the centralized userspace daemon(ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without
> any app involvement.
>
> To solve the issue, this patch introduces new syscall process_madvise(2).
> It could give a hint to the exeternal process of pidfd.
>
>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
>                         unsigned long cookie, unsigned long flag);
>
> Since it could affect other process's address range, only privileged
> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> gives it the right to ptrace the process could use it successfully.
>
> The syscall has a cookie argument to privode atomicity(i.e., detect
> target process's address space change since monitor process has parsed
> the address range of target process so the operaion could fail in case
> of happening race). Although there is no interface to get a cookie
> at this moment, it could be useful to consider it as argument to avoid
> introducing another new syscall in future. It could support *atomicity*
> for disruptive hint(e.g., MADV_DONTNEED|FREE).
> flag argument is reserved for future use if we need to extend the API.

How about a compromise? Let's allow all madvise hints if the process
is calling process_madvise *on itself* (which will be useful once we
wire up the atomicity cookie) and restrict the cross-process case to
the hints you've mentioned. This way, the restriction on madvise hints
isn't tied to the specific API, but to the relationship between hinter
and hintee.
