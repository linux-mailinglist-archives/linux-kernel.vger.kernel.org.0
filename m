Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7262C85379
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfHGTRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 15:17:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33503 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfHGTRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:17:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so64976975lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMxqo/U0nw6DmpEA9S3YJIdfMVgNoxeRFMQ95NzIcMY=;
        b=QFLKrC5vkJW5FKE/Mdgg0Cdcp3sO/GQpVGltLV5Ca6yR5XaMmMWdxOVi8385PLpByn
         E/O5WhMsHLvDBDcmUFvSEBG08jBSq6LjIkgwV1Bf+j33ocpUvmt4+vvljJI1lHX8UUqK
         0knAjZ61PyQ7e0qOT6M/ZBN+bdOB8TBJJv+4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMxqo/U0nw6DmpEA9S3YJIdfMVgNoxeRFMQ95NzIcMY=;
        b=f2d7wxZrBYpRjlV3MTad9tRfsp8Z6IhyAtghytYIb3LBf6rzZZpySVXbPegw2lo8zP
         xW1gXX71+eMdMW1+Z+8ZUpQYzGpssZVr7v37afcl6YVE+v+oWJb+tOKw0oC8cwnvjUl/
         5y9+q5xJ87xNFGhTnEhJ721KDNG06VcBmqYqM3PFe7WVb3LnzY/1s+vO3wg243txuSQb
         OnMwvgNCWhof95IV2kJurH6OStyoOrscUOkSQ2zLZ/IKzO05Mb2PlLIK4VpLboBL3hy+
         5ap2siRc81MLe4zj5RSWu0djhYSbxic9ASP45+HWXJmzkMgoqcs5ZHlnhPeeis/uwslu
         jXYQ==
X-Gm-Message-State: APjAAAWzZOFIGH3JWDNrnUsDXzyYLQpGhGEMxjK3UpV6XyQBElw2VUjv
        s1ZjxgXeddFTJ5ek76nYhyRKm94r6Lo=
X-Google-Smtp-Source: APXvYqyE0zP/Q8LGoQKR6dNnJbwBRg+fQZ5O5b+JD/fijlCLwhocmWXsnoVHRNe9wRwNZDh35HAakg==
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr6496524lfp.80.1565205430686;
        Wed, 07 Aug 2019 12:17:10 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id q4sm21075569lje.99.2019.08.07.12.17.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 12:17:09 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r9so86524498ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 12:17:09 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr5553524lji.84.1565205428980;
 Wed, 07 Aug 2019 12:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
 <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org> <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
 <CAHk-=wghASUU7QmoibQK7XS09na7rDRrjSrWPwkGz=qLnGp_Xw@mail.gmail.com>
 <20190806073831.GA26668@infradead.org> <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
 <20190806190937.GD30179@bombadil.infradead.org> <20190807064000.GC6002@infradead.org>
In-Reply-To: <20190807064000.GC6002@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Aug 2019 12:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUO5hWJmMT7r8aCzP7DOkg9ADkv6AzZ=SrKLOoKxzD_g@mail.gmail.com>
Message-ID: <CAHk-=wgUO5hWJmMT7r8aCzP7DOkg9ADkv6AzZ=SrKLOoKxzD_g@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
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

On Tue, Aug 6, 2019 at 11:40 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> I'm not an all that huge fan of super magic macro loops.  But in this
> case I don't see how it could even work, as we get special callbacks
> for huge pages and holes, and people are trying to add a few more ops
> as well.

Yeah, in this case we definitely don't want to make some magic loop walker.

Loops are certainly simpler than callbacks for most cases (and often
faster because you don't have indirect calls which now are getting
quite expensive), but the walker code really does end up having tons
of different cases that you'd have to handle with magic complex
conditionals or switch statements instead.

So the "walk over range using this set of callbacks" is generally the
right interface. If there is some particular case that might be very
simple and the callback model is expensive due to indirect calls for
each page, then such a case should probably use the normal page
walking loops (that we *used* to have everywhere - the "walk_range()"
interface is the "new" model for all the random odd special cases).

                Linus
