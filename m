Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC13B99F3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2019 01:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407068AbfITXKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 19:10:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33803 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407054AbfITXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:10:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so6145806lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO+3q5x038gSPZF/nLZWoOveo/vi3BJr9fEYGq5u1Qs=;
        b=b0bLoLz9YWB+dnb6SUOQYyE1UG7Fm/CiRt9E6LOt5jNDkZBpysWuFmg6W9pLGQLDKb
         WEpU9p2xmLJOYOSUMCpecUg+sWWLcFbpwLUo70evRNP41Q3StF1A42Il21OBbR6H99xJ
         iNnVTFFFgkWYCoAEIw6rXlpjOGG/wqJpFAmnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO+3q5x038gSPZF/nLZWoOveo/vi3BJr9fEYGq5u1Qs=;
        b=Yh6Ieipxe62WFX2STGaDnahBQ8Kja9DbVm3ToM4+xhhId/hHm6l9GlWJe3Cr+BjH0X
         0MnWOOXhabtJwP24O/2UNkEFQU5ypzBEdoVyeyeWgvaSolb/yq7DLE1JDOKsQAorTj+j
         tMtKN1CxwqvBduM7WbcsuJAWJQuyTwYR1rk9wY0Y8YV4t/xQHZcDJijweV9CDMVDRPNW
         kMT6ifNGPtC1+z8KBySqwOd81NuLiZeH9ya3gqwI3CXEzUL5qWxnmqZkeevCnjyMq+H+
         M8ZjDQwehJUcelG5wWJfedHUUclkexlUpbOW2i3dCZVFJBzBFatRXKQD3SCE3MJfs3fP
         Ierw==
X-Gm-Message-State: APjAAAVq0K+tE7cSGlkVALJu4+ML58S1FbLoly9+o3EGPL2/gCoVi/zW
        GzP5oHO09LbGwbFKMTJemYeVY6SqybM=
X-Google-Smtp-Source: APXvYqzqpDnCqrqjGIePQi85R2mSfp/yZvk8rZyhOXC08amRnCK5svvriMPyUitsPIPTg5Jk+sktgg==
X-Received: by 2002:ac2:4551:: with SMTP id j17mr9952448lfm.81.1569021021773;
        Fri, 20 Sep 2019 16:10:21 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e7sm757267lfn.12.2019.09.20.16.10.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 16:10:18 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id q64so8519860ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 16:10:18 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr10586601lja.180.1569021018229;
 Fri, 20 Sep 2019 16:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <156896493723.4334.13340481207144634918.stgit@buzz> <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
In-Reply-To: <CAHk-=whmCZvYcR10Pe9fEy912fc8xywbiP9mn054Jg_9+0TqCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 16:10:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
Message-ID: <CAHk-=wi+G1MfSu79Ayi-yxbmhdyuLnZ5e1tmBTc69v9Zvd-NKg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file writes
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 4:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> Now, I hear you say "those are so small these days that it doesn't
> matter". And maybe you're right. But particularly for slow media,
> triggering good streaming write behavior has been a problem in the
> past.

Which reminds me: the writebehind trigger should likely be tied to the
estimate of the bdi write speed.

We _do_ have that avg_write_bandwidth thing in the bdi_writeback
structure, it sounds like a potentially good idea to try to use that
to estimate when to do writebehind.

No?

            Linus
