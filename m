Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2131310CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEaPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 11:03:24 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44126 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfEaPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:03:23 -0400
Received: by mail-yw1-f65.google.com with SMTP id e74so4232926ywe.11;
        Fri, 31 May 2019 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ab4Nh0FZkrZQCQChzSfnebh5p0VEbtuG5pXGGr0tef0=;
        b=nOS3EcqnXLPrMLW6+22jRFGGaRQwwdCB/1abNj75WPFLIRLjChddHEySgEYPQXe9JX
         p0FwzrOeuV94MZd/n0FBYFK7l41UQNumuusNoqyNL27LJyksNahNFySC36sqq689t4HS
         8/U+1ce19isNXjqktokyPRJNOyIDfVswImh66/uJ+2yv+GKO2ICQEfYlEa69+cBtfciH
         JJ8IQNd+OBwKRSB0JfOgJS6iSScpHS2UstEGxBgeKfCMbGZcKp/ytuj4E50pGT8zqde4
         8b5DQjmSjJIJLA51+bevM0UIs9E/ZMnZt9YD06X8L4dc6AZ65p0blxRwAiCzM0mxCr8P
         RWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ab4Nh0FZkrZQCQChzSfnebh5p0VEbtuG5pXGGr0tef0=;
        b=dSBy3xiAZdIW6E+xXyb2581yOU9c5vcu/QQMHvUimE7X1LWbZ10ZIrJOpd0owacwZg
         rJfIX+P32dhHIPybVoVOSq5uglVStaTcP5H1DaL1PRCktBWQq2m14/pdX+Ej7BxWYVmF
         8loVGXqtsEhybDPrqW7POL/SHLoY/pq5dvUWUrzNbigvXBG0+zuZ6VEaOdfCy9PE4ZAl
         hLPyw7Ik38vcJJUlTy/a4J/2kQt6pb3Pe8u2smnt/+oXUdbjLvG/63oA/O4809oj4Adw
         QFvjDRXvR9pkU33O6WRKN+27Ue/vAdfBaRS6uUnvDwvTWCv0uvKubhoeMiDuVoxiIkQt
         mr9A==
X-Gm-Message-State: APjAAAXpdJudw8rhURUVDp2GX9FCbdSvVzLyL29AQx5+NaeXgY3LaNvX
        vuVYbgaz3/VK1NS96VlnwnkQj0iWCNMCOEo+fP8=
X-Google-Smtp-Source: APXvYqybMv6mcv53VLj6NtwjvPaXw2yuyOGNGxF8jSVmrF9SkBpO0tit0PBZ0tyPsIc8DdWX2gvUIvKgVeFchLXX/u8=
X-Received: by 2002:a81:3411:: with SMTP id b17mr5553993ywa.280.1559315002885;
 Fri, 31 May 2019 08:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
 <f7378a751557277eab6f37f3f5692cf5f1aff8c6.1559171394.git.mchehab+samsung@kernel.org>
 <bf8163be-eb1f-f060-1c5a-405bc6d4c8c5@gmail.com>
In-Reply-To: <bf8163be-eb1f-f060-1c5a-405bc6d4c8c5@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 31 May 2019 11:03:11 -0400
Message-ID: <CADnq5_O8Dh-6Mpz=_+5iTOz+UuVUid44=S-SrHenoVzFB77u-A@mail.gmail.com>
Subject: Re: [PATCH 11/22] gpu: amdgpu: fix broken amdgpu_dma_buf.c references
To:     Christian Koenig <christian.koenig@amd.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:00 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 30.05.19 um 01:23 schrieb Mauro Carvalho Chehab:
> > This file was renamed, but docs weren't updated accordingly.
> >
> >       WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -fu=
nction PRIME Buffer Sharing ./drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c' fa=
iled with return code 1
> >       WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -in=
ternal ./drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c' failed with return code=
 2
> >
> > Fixes: 988076cd8c5c ("drm/amdgpu: rename amdgpu_prime.[ch] into amdgpu_=
dma_buf.[ch]")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>

Applied.  thanks!

Alex

> > ---
> >   Documentation/gpu/amdgpu.rst | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rs=
t
> > index a740e491dfcc..a15199b1b02e 100644
> > --- a/Documentation/gpu/amdgpu.rst
> > +++ b/Documentation/gpu/amdgpu.rst
> > @@ -37,10 +37,10 @@ Buffer Objects
> >   PRIME Buffer Sharing
> >   --------------------
> >
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >      :doc: PRIME Buffer Sharing
> >
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >      :internal:
> >
> >   MMU Notifier
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
