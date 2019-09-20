Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9C4B94FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392069AbfITQNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 12:13:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37162 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbfITQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:13:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so7871128qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KRt2eO4265RvjOZt0uXZpaJi7G2Fc0WrcvWpo7dNLs=;
        b=PC5Rm/MNlVYG4hAUpVfxggZ29cqeMZ0SbqOzGCvjSO/AEVVluIBPdz4p6e+w2gcUV1
         JYawH7yifWF5Pp9d09F9f+XcjFDIke/gu7/K5/d0zWBo7og0ocmUSq5dstDe4UJGbFaG
         wq7GxlinSzw2L3Ljj+tR2FrD7VCUS+JkD07c+XOpKKmO3/wZXbMi4DJUVfiJ1ap517j5
         W272PKtk7l0n3aFyg4dKNPUOQm1fSqRwKkbNGCl/Pj34yLsdzNuTVfKX75ooJeyDUtNJ
         bhiMS4SQqvvlvriNSO/HSBGNJABpHrm0C1W/pcAk0wRZT/RvdY1pGLy11GOcNJPAjwm4
         a0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KRt2eO4265RvjOZt0uXZpaJi7G2Fc0WrcvWpo7dNLs=;
        b=oKH6jaskd2/IjaNGbnkM/nOoovFlHele1sPNeVfPzm0gd42kDXkHMb+Paw93rJJG29
         IEPORdDjrCWr88B53Klkkd872yhoOQQSX6Fxn3gb4qNatTC687c3V+fJRvk6t2fCNVsJ
         GeO1RnmXAX0gFv6SREW1qIh4F2vJmOHmFLWNYBuvxe+x7EHfC1tAPUTAySmNnoapvTOn
         ADF7Wxs4RLIbx7DL24JqP9wtJYgcgX3zojHvvo066JZ7Ott9/rFBIth6Ao7D2IZI90a7
         rZ/oLCUDyh6WM/Y8ZiVt/c60i8vzX2uPhk3AQtrc4jIJsvrg9Iy6AmsfvGMEMsFZReiN
         1O1A==
X-Gm-Message-State: APjAAAXpVY6Hi9nam4MwXs09fwzz8WF85jw0kp1j0+POn/maGRPVSBQm
        EmZsq4aROpAfIYWIjIJ49xqFTcY05Q4KA0uNvWI=
X-Google-Smtp-Source: APXvYqwBdbXYB9whMv59Ht+lFG9oCle+iuMEfAA3OUQXDylTx0BKXVaENvwYUBi2YcBlQNBa44m1najM2kKPfflpUfo=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr4535890qkf.203.1568995995092;
 Fri, 20 Sep 2019 09:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com> <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com> <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
 <20190916152325.GD3084169@devbig004.ftw2.facebook.com> <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
 <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com>
In-Reply-To: <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 20 Sep 2019 09:13:04 -0700
Message-ID: <CAPhsuW6zxkKd3ExXj5GCq+4yEWv85qmM9_Weatv4PoVd+aWKDQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Fri, Sep 20, 2019 at 1:47 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello Song,
>
> On Thu, Sep 19, 2019 at 3:43 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> > Sharing some offline discussions with Tejun.
> >
> > ino in current kernfs is not a good unique ID for cgroup, because it doesn't
> > increase monotonically. So we need to improve kernfs.
> >
> > For 64-bit, we can make the ino monotonic, and use it as the ID.
> > For 32-bit, we need to make the ino monotonic. and use <ino> and <gen>
> > as the 64-bit ID.
>
> Thanks for the sharing information!  For 32-bit, while the ino itself is not
> monotonic, gen << 32 + ino is monotonic right?  I think we can use the
> same logic of kernfs id allocation, but not sure what the problem Tejun
> mentioned before is.

How would we manage gen here? One way that works is:
1. make ino monotonic,
2. increase gen when 32-bit ino overflows

I think current kernfs id is not monotonic, so it can be reused before overflow.

Thanks,
Song
