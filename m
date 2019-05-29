Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC91A2D438
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 05:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE2DZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 23:25:06 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:37667 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfE2DZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:25:05 -0400
Received: by mail-qt1-f177.google.com with SMTP id y57so879328qtk.4;
        Tue, 28 May 2019 20:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7jMmQ805XOFY1RecqIVsVKw8Wv7KaR0RUM1pyfgUNQ=;
        b=DRPwuWuL/d0tw86uQzToWiIfQ6wc0zZIS1jaaw/T8sWSFM2acw763vSGft/xi08iad
         gxVSzCzu4SiHbDcCByxnp+8ennWhTV7bJUvkVOHf8t9anDxPkjTl4v7zo0l0XAqGPIqP
         bNkq83uEEqbU9XzGdw397olRRzw8BbutNaGU11FOqwlCe7ZJ/F2rwz2zWzVYQXXa6IZY
         nsjIUElDgKDMN6gHNSd8NRPExxhlj7BQIhvJnlm5zj9t67LGy4odr81zPvCkDBQAOft3
         9z+UmPdCI9K+n33dM/ZNjYTrlBxjGHcSnUNdk0539NvzeN64vrdJs6LAYL+03+redAYa
         EpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7jMmQ805XOFY1RecqIVsVKw8Wv7KaR0RUM1pyfgUNQ=;
        b=B7Rvs/9tml6yJHoDRPyKaRGc2A+9aUNxtCyZxq+AAuAMdsy3wLJ5kQZLEOZMU+q2jA
         8eoLfhM2bPezFQIpKCNqaoeIGv/pklOTzXjEvYqd22Iab/AtHc8LKuuvCiDCMtXxr2xc
         vq76WVgqx2DnB0rhGyVwWkKM+/6cwCmK+z0VwzG5euUdQkZKbac06f0MdacpTQ4daB5U
         +YQu8n026TGr+P8JKHG/SNSahKx7nsoildMu9IDQE+znhG5P8FqwZYK7l1/LeZ3Hm54E
         WUjcP6dNk0c/C7qO/Sk8fRfSl8i5lEbg0W9lMeUoZtHDGC2ct1Hpat687Glbb6pIHKzX
         kufQ==
X-Gm-Message-State: APjAAAXV2qJI76RlOGiWn3FWFSwE6tfJaPWzEUJXh6RHxgHPgz/Z9GKB
        btP6sz0xCFN/hw0z+jfpHNX0M9zcAqiAJU+sHJZeww==
X-Google-Smtp-Source: APXvYqyQaS4Gps42wNqA6MZscB8fnWZF+JqILV/ghhZz4CwMVOpKhu6zOI1HDLjhfBZY/kYQI+K1ISr4PAR0c2W0bFw=
X-Received: by 2002:ac8:1205:: with SMTP id x5mr86437682qti.284.1559100304524;
 Tue, 28 May 2019 20:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190524142713.360c0c10@canb.auug.org.au> <CAH2r5msm9TfC8f5WNOyD-9g01u9m-UNPuk_XPp3Ykhc4u7+Rtg@mail.gmail.com>
In-Reply-To: <CAH2r5msm9TfC8f5WNOyD-9g01u9m-UNPuk_XPp3Ykhc4u7+Rtg@mail.gmail.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 29 May 2019 11:24:52 +0800
Message-ID: <CADJHv_tzocJ6heXoAa176zJU+8cP+3t8bXqxQDjZ4rm_FOiA=g@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     Steve French <smfrench@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:14 PM Steve French <smfrench@gmail.com> wrote:
>
> fixed and repushed to cifs-2.6.git for-next

Thanks!

[resend including mail lists]

>
> On Thu, May 23, 2019 at 11:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commit
> >
> >   f875253b5fe6 ("fs/cifs/smb2pdu.c: fix buffer free in SMB2_ioctl_free")
> >
> > Fixes tag
> >
> >   Fixes: 2c87d6a ("cifs: Allocate memory for all iovs in smb2_ioctl")
> >
> > has these problem(s):
> >
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >     or later) just making sure it is not set (or set to "auto").
> >
> > --
> > Cheers,
> > Stephen Rothwell
>
>
>
> --
> Thanks,
>
> Steve
