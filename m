Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0274B69C57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfGOUHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 16:07:40 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:37917 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfGOUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:07:39 -0400
Received: by mail-lf1-f54.google.com with SMTP id h28so11900593lfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eixaqw4rkktSrGNopKKbb/e4i5OCHkekMi3cawhMjd0=;
        b=P2iRueoZZZolheElzwSTwYwc4RL+cazdVv/CsaDqThr07wrKc70nMd66dNr+4RJgdC
         BvRP6r9qDsoTmR2kyUtGbeyA8kOaLPvgB2B6eZHY99jN0c+s0VmexvYTt39LILXFaAJR
         8isLgd729Gom3bcquhSVnuvvT3p838Xh7cOZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eixaqw4rkktSrGNopKKbb/e4i5OCHkekMi3cawhMjd0=;
        b=aNcibE012uXOQhJP/vd7krRd2X5JAu+IyyIdCXTSyAhYo2a7smTgA8ON1NsXalrgCv
         97nMDNYK+fWtRqVN0OjAnYU+JGyMoZS8EebfJONrl1HHMyilpGyDc5bxHOAA68oI0EmZ
         BLucBBaj4WoKpScSxhQ2XIr8ZVw2/lDfx0Op/4pzqJkrl7Z+qwGZAhk/+FCT1mu6Vyat
         CC78qVkeJaK0ywI18gVcpJ1cmmXa0d3ZbbXAXEkP97HTgJ1SS1y9PD4qP1mS0fgTEjfD
         c/IER/UyxeBJExtLSDrn28UsiPPWqLhe0nnvZzkVVM3SlV8E0neBceqK780yIR4Sq6PN
         vJmg==
X-Gm-Message-State: APjAAAX2sGIrqEZmCwhwzOD/LZLWBL7abCiuhbprusePiyu/vUXhPJM0
        5qIFF11e3f6M4o3DRwhap6CY4BvrK1c=
X-Google-Smtp-Source: APXvYqy7QVUVPK6J0Zo17ZfhgQTASls/a/h0/eebvZRytnswCiwMYWYssVDjFLWl3YSamToOo56+Zw==
X-Received: by 2002:ac2:455a:: with SMTP id j26mr12181452lfm.18.1563221257191;
        Mon, 15 Jul 2019 13:07:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id p9sm3337827lji.107.2019.07.15.13.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 13:07:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i21so17559738ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:07:35 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr14547098lji.84.1563221255694;
 Mon, 15 Jul 2019 13:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com> <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
In-Reply-To: <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jul 2019 13:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
Message-ID: <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas@shipmail.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:36 PM Thomas Hellstr=C3=B6m (VMware)
<thomas@shipmail.org> wrote:
>
> - I've never had any kernel code more reviewed than this.

Hmm. It may have been reviewed, but that wasn't visible in the commits
themselves, so when I look at the pull request, I don't see that.

> - The combined callback / argument struct: It was strongly inspired by
> the struct mm_walk (mm.h), the page walk code being quite similar in
> functionality.

The mm_walk struct is indeed a bit similar, and is in fact a bit
problematic exactly because it mixes function pointers with non-const
data.

I wish it had been a 'const struct mm_walk *" that only passed in the
stuff that describes what to do on the walk itself.  Or separated into
two different pointers - one for the "this is what to do for the walk"
and one for "this is the walking data".

In fact, I think tight now that is actually _almost_ the case and we
could make them const, except for "walk->vma" which is updated
dynamically as we walk.  Oh well.

And for all I know, some of the walkers may be modifying their
"private" field too, since that's left to the walkers.

So yes, that one also has some problems, I agree.

               Linus
