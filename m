Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EDA15F9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 23:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBNWs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 17:48:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33950 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgBNWs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:48:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so10996214oig.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgoIP7Jshrn2duDl/cLkfq4CVlTeMc4BWp5pc4aKy4o=;
        b=MhgOWYPob9S6aZV6qa2b7vLLaVDvt275tODnygTV/CKd8wZi8f724KWNlUCRxs5mjH
         DCM690tw83yBr2LORN0E+j9ll5bD4HHOlWoWsl86QrhEuZIsmxOjBealBDm00d5vtezR
         vUaYfoe/EyPW0Yufblun637lPw3LqF5RI0rMvLWN47ZAf9ujyHXOjVyP4Qfo2c271JS9
         7rUY48zxABcoVUIkQPtg+0T4o5KmUJuvDUzJxKTBOgxeCBg2ZxJDuziggGbCQ9scH07Z
         1lMwyvU0Aa05SCjGeSZN7Mw6D5wbI4rvxo452JwFeUFIe8Ry6FtSz9LrvBReh5+rLGI4
         jBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgoIP7Jshrn2duDl/cLkfq4CVlTeMc4BWp5pc4aKy4o=;
        b=BaKis2DIkBctyJceopeUAfbHFG35wTYYtLIKqEa1hN1KivJbIIdIOO509OWmXAv2L1
         dLUjIhzbwOSOjL61jjpi8cXnYf7cAti8zuyOTEeOeM/oAWX90treY7TdiNJxqQLnWcqs
         1i/lGJmlLQfwy9TJ0XKN7RYCMQz/vXxyaepM6sx0WA6UFu245c3JfN3C1kL/aZkIzEAx
         F6/t1djMcDhmIg1CnGl9ZWoL/7ISSSiDeLQEPvQUGMAND4WHuINFwXtuwvqMx5geEw0z
         DIqTaMGNwUbkF94xslqX2b65mwV8WHuEyKBBEwIqgvkMAyW0vYpAxNA2lbxnrCvulUyP
         xcrw==
X-Gm-Message-State: APjAAAXii0z3qf2s6gbNJm1nZDbIFkcifSZv4AGRdSVRB5lBk9mMw90T
        F3KHCAtluixhAceFx6sj+c51RKCgYSltbzHA554pgA==
X-Google-Smtp-Source: APXvYqxFBb2HQnzGcPUG6cOYpfmJqP7PlimlMr1+iPFrbiJ4dnvduE/oWnmZgKQGPbeT3ha1e9ByvWDejgMmMZKdE+Y=
X-Received: by 2002:aca:6542:: with SMTP id j2mr3470435oiw.69.1581720536963;
 Fri, 14 Feb 2020 14:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
In-Reply-To: <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 14 Feb 2020 14:48:46 -0800
Message-ID: <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Eric Dumazet <edumazet@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 2:38 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 2:24 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > We are testing network memory accounting in our setup and noticed
> > inconsistent network memory usage and often unrelated cgroups network
> > usage correlates with testing workload. On further inspection, it
> > seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
> > irq context specially for cgroup v1.
> >
> > mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in irq context
> > and kind of assumes that this can only happen from sk_clone_lock()
> > and the source sock object has already associated cgroup. However in
> > cgroup v1, where network memory accounting is opt-in, the source sock
> > can be unassociated with any cgroup and the new cloned sock can get
> > associated with unrelated interrupted cgroup.
> >
> > Cgroup v2 can also suffer if the source sock object was created by
> > process in the root cgroup or if sk_alloc() is called in irq context.
> > The fix is to just do nothing in interrupt.
>
> So, when will the association be done ?
> At accept() time ?
> Is it done already ?
>

I think in the current code if the association is skipped at
allocation time then the sock will remain unassociated for its
lifetime.

Maybe we can add the association in the later stages but it seems like
it is not a simple task i.e. edbe69ef2c90f ("Revert "defer call to
mem_cgroup_sk_alloc()"").

Shakeel
