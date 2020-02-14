Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7D15FA39
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgBNXMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:12:41 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46239 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgBNXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:12:40 -0500
Received: by mail-yb1-f193.google.com with SMTP id n131so2232300ybg.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 15:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uatDFsIT20Tr7lDZflfez2EhiRhyLK/asm5Si1dIGu0=;
        b=bcDSHQvvV96yGTTBRaB8x59yqMJOXsrLkX+6lOtHFWjjtjj7KqevWTBgWaz/71B+nt
         gtS9q14yDtUdDOH39hmoZZW763p287iNzMsFru3GOmmYq2LdEXOM0aqi4ENgnMQ84ygt
         xwdNGRAZShNjNgD7GoS6tiTM96AanEO1yfwvXXAH4zVUES/ITWy18m+kROoI/RoWkb0w
         uNxeQC845/tLmKRHSNwkR196QibBSJSyrX+6ZtKqUzvsHAg7nR2Z7Z0oPrSjCqhsQWAq
         xIRpoWrtAfrDtxulQYPXvT8z5ND6nMHvA66yZe02wBC2VyD2zrBerpKVt7XOolE8e0Fl
         ccKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uatDFsIT20Tr7lDZflfez2EhiRhyLK/asm5Si1dIGu0=;
        b=bjCEWPAqRUOX1cD6/k0q7FxU2Mm0qwLUwM1YlE/69qsY2yxqOzf3dVjhuq7b5kAeQ0
         /K4x1kn6MytS8cYrCwa89T6tImrMuQ1RmZBYCMfEh1swZJw0WZA7rldD3oX0+1b6RsUW
         +Q9BnwRM8U+W7Bmye4dBdXcNttnHgmJnu/8SdYrDP4GYElAQJq3S4c7QmXS0PSpT/rm6
         Ng3pUHZC4RQ5+ZH5ZfzcvaXN7PcrsYgfCEjM7W5k5Z9eCPNGxnLxVjR1eNEeLP4tJvjT
         7XWSw9aIT1l6AiQFVzlC78jfLGCgo3M3dzyHkKdjtvGLlvoIfWJBENfKBbCM+1Btioib
         /TKg==
X-Gm-Message-State: APjAAAXSWn6BxORJOCfPHBDUP6TRghDpfcGDthy9QGSzpvK7ueC+M2sb
        OuefRkAVJqo8toun7XxfFFz6zJJTGxQplN3Urv4Q9A==
X-Google-Smtp-Source: APXvYqxkNZYzOofzcj/O8oXklWpy/AuGc965qcSeMb2Eklii3RnwyzikN+gAWkqbXYq0KMhnOa0jTnOmd7sm5bDO9Bg=
X-Received: by 2002:a25:640e:: with SMTP id y14mr5021685ybb.380.1581721959525;
 Fri, 14 Feb 2020 15:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
 <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com>
In-Reply-To: <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Feb 2020 15:12:28 -0800
Message-ID: <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Shakeel Butt <shakeelb@google.com>
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

On Fri, Feb 14, 2020 at 2:48 PM Shakeel Butt <shakeelb@google.com> wrote:

>
> I think in the current code if the association is skipped at
> allocation time then the sock will remain unassociated for its
> lifetime.
>
> Maybe we can add the association in the later stages but it seems like
> it is not a simple task i.e. edbe69ef2c90f ("Revert "defer call to
> mem_cgroup_sk_alloc()"").

Half TCP sockets are passive, so this means that 50% of TCP sockets
won't be charged.
(the socket cloning always happens from BH context)

I think this deserves a comment in the changelog or documentation,
otherwise some people might think
using memcg will make them safe.
