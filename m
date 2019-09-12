Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC4B1605
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 23:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfILVsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 17:48:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38197 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:48:00 -0400
Received: by mail-io1-f65.google.com with SMTP id k5so33194683iol.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nsh9wMtR+piWKMVssRxEW2CCDveInH3zQuunz33C6pw=;
        b=HvE2JMW9DzbOnl+GJq4DI6qFxnw9TBb1eNu3XAJmXzaj7H21B/fTsn/qhRSoMS6r0Y
         jqt72xjKycAC7WPfc0t8jkHr3Pky0s11I8NjLHyrolMES9x+IWJsc7wYD2hG/9Fes2Ik
         nGxgHcJfhQISv8I2FcUw/ng61z1YORiGfiVeASwoda5a4J8R39JWJdAfEasQhs2ItKW2
         6ynBtqYv3FAA1LDnwigBmH9w4Hb+X8d1qIG1FA+MiZAQQ6DAgKekp9P5XVlaB2BCBRM9
         E80xav8My8RbT71tBoGsurjYpBALHN/v+wfEkBrRyqL82xOzLAxYFiPDUdsY1QX+WZnB
         JZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nsh9wMtR+piWKMVssRxEW2CCDveInH3zQuunz33C6pw=;
        b=ajj50Y9ZTyfku9qPvRcgbelrQrGXSOVJ3Cf+wYly8/KY+V2t4zQzS2+i0TopFwFRkP
         ZmZ7OFX+YT6FHf5sHpHZfToGCKT2piB7AG76CXY5NWgmAoBGebpbXREy0PRfcjsooAog
         YD7wipk69z3kX0+A5c2VNPkBH5mM9XcqLSPH6PsAiSD2iqix7xy+Z+vzxbpI85KgyUqK
         MKHJf1H3vQSlm1Cv5Dwv0yc7wx3GO+N2qki9gC68LKuAueV5ZB89Uv6+/hQJlx8LuYmK
         fo6Cw1IsJ1aHbqil1P0svnExJr83JgQRWx9Ep1NJvqChhBac9QeKYtt1xFRE+n/cPDGd
         wIlw==
X-Gm-Message-State: APjAAAXD0pEueMKvSsRPqYJmZwbvcvWG/NTgVufcl/9684AbIAV0HQ2v
        AEXTS1gLORYjArQyc/BQGWHbN0VzKQiwGfjw1J0=
X-Google-Smtp-Source: APXvYqzNx4+RAMwUP0AmKza386+UJ1O8aCkriLtdGYKB0a3YLsBG+HWOAjyS4JOKf/XHHXzSp5FmG2p5vw1yFzQk8as=
X-Received: by 2002:a6b:db0e:: with SMTP id t14mr7016055ioc.93.1568324878498;
 Thu, 12 Sep 2019 14:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190912114627.20176-1-kraxel@redhat.com>
In-Reply-To: <20190912114627.20176-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 12 Sep 2019 14:47:47 -0700
Message-ID: <CAPaKu7T_TrCUEyjthshTjr_=uDQs+iJuPV68QYmmDJ7vodR35Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: enable prime mmap support
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 4:46 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 0c9553ea9f3f..96c240dbf452 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -200,6 +200,7 @@ static struct drm_driver driver = {
>  #endif
>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> +       .gem_prime_mmap = drm_gem_prime_mmap,
>         .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
>
>         .gem_create_object = virtio_gpu_create_object,
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
