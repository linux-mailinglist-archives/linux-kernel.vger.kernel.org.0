Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB5C838F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 20:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfHFSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 14:51:03 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42380 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFSvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:51:03 -0400
Received: by mail-lf1-f47.google.com with SMTP id s19so62028801lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFrdn8TjmQNSnIaAcCuqbEzq3mrXCDg59WKear6Xdpg=;
        b=MlysRV02mcMixM5P973XDGPSxckBz4Nea7C3SNGSHcfQXpMYCeOaEo4xQvZFVIgIBy
         AFFjp9IQ8QdVB/2B+8z1j1rT4dC0Ak27vpobppoYytcpWfuMnn4/z0OVQMXSAxk5j/X4
         5pVDLEKsr8UIaKS0UpizhCPTazxnvNME05Bg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFrdn8TjmQNSnIaAcCuqbEzq3mrXCDg59WKear6Xdpg=;
        b=CPIDck8RaU7g1iIe2lu38mmJEVsZUQP2koSa5VO0oIMmP/8t8Ny3MwssxXpTEdBD7o
         PZK1ZOyono+BGqTijxUX2ExzWsn0WtQbRUFJ8uQl55SXAmaUSHsSVVKVok5OItei/zQ4
         EmV0/wn0xgjQNrYKF67LUtwuROh6WL1JIpoYomY4VuQE6mmlqD8x2pP2Cw93m8ob9iZV
         8L23Cmc/eVMeuloAFZrGoDIWCsco5yZxW6nrn/7ldijNOsdGjW0n0C3IFU67RXrpQyrS
         rf2CBhBPC3eyLHXvtbK3V3D/tssdDS/+c8knQMRHloGg0t7DgwRyumvnmLy08tU7KqUp
         9umg==
X-Gm-Message-State: APjAAAULCG97EPxTkP5pSzBYrg4Cv7BZaHngiWPF49aMs9//dq/D1deH
        YA2E2I5vWFMbtVRFcup1CZpHwF6Vph4=
X-Google-Smtp-Source: APXvYqxJjd6U9nt8sLXhA5ieCKFs6yAlcUtosHkCB4eBu/WZP9RowqNodXLXSsI19cimtZeBrFJSBg==
X-Received: by 2002:a19:5e10:: with SMTP id s16mr3374091lfb.13.1565117459797;
        Tue, 06 Aug 2019 11:50:59 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s24sm17980378lje.58.2019.08.06.11.50.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 11:50:58 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c9so61958997lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:50:58 -0700 (PDT)
X-Received: by 2002:a19:c20b:: with SMTP id l11mr3479307lfc.106.1565117458380;
 Tue, 06 Aug 2019 11:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
 <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org> <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
 <CAHk-=wghASUU7QmoibQK7XS09na7rDRrjSrWPwkGz=qLnGp_Xw@mail.gmail.com> <20190806073831.GA26668@infradead.org>
In-Reply-To: <20190806073831.GA26668@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Aug 2019 11:50:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
Message-ID: <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas@shipmail.org>, Dave Airlie <airlied@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 12:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Seems like no one took this up.  Below is a version which I think is
> slightly better by also moving the mm_walk structure initialization
> into the helpers, with an outcome of just a handful of added lines.

Ack. Agreed, I think that's a nicer interface.

In fact, I do note that a lot of the users don't actually use the
"void *private" argument at all - they just want the walker - and just
pass in a NULL private pointer. So we have things like this:

> +       if (walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
> +                       NULL)) {

and in a perfect world we'd have arguments with default values so that
we could skip those entirely for when people just don't need it.

I'm not a huge fan of C++ because of a lot of the complexity (and some
really bad decisions), but many of the _syntactic_ things in C++ would
be nice to use. This one doesn't seem to be one that the gcc people
have picked up as an extension ;(

Yes, yes, we could do it with a macro, I guess.

   #define walk_page_range(mm, start,end, ops, ...) \
       __walk_page_range(mm, start, end, (NULL , ## __VA_ARGS__))

but I'm not sure it's worthwhile.

                  Linus
