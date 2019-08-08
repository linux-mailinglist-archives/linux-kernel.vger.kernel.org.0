Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78AB86D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 00:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbfHHWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 18:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfHHWvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:51:50 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823402184E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 22:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565304709;
        bh=8Pp17pXv2BsvdUGgrjCA+x6loADEC1HGz0lVc93J0rg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=06U/6nvMdcCkxw7UcbHXLjGLUFy4AtCl3ss9jAZ+s8AHXPinmRTOMcTOo59OHykyz
         NDe7Mf3FCFD0xA2VihjqBz2+9Gzh0S2MrDRCKUqGdaDbpNwQI3cKQrcdKw9UKGcfRT
         oJCXkcagX7UsGQTlExLl2pKFLNyApTCSDnYH2gJ0=
Received: by mail-qk1-f169.google.com with SMTP id g18so70230937qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:51:49 -0700 (PDT)
X-Gm-Message-State: APjAAAW5bE0iOx3BMQnQYNDBISXw4tIVhpBvoOeXi3m7WXAxk3Saeel8
        RJnAOyDdq4+q+FyYFolIhhPmQer58qq+Td8uHA==
X-Google-Smtp-Source: APXvYqwbl/3VPMfI5y3PwG2THnJOA+RM7EdEeptDWTFIwfSk57LM3T+Yd81fZ13xvanJ+3+maiecJE8s+uVIpk4y0kM=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr16013485qke.223.1565304708728;
 Thu, 08 Aug 2019 15:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190808134417.10610-1-kraxel@redhat.com> <20190808134417.10610-8-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-8-kraxel@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Aug 2019 16:51:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rqigmySoJg0iknkEJ5hzWeD3w2iSTpWoqoD67fGV3cw@mail.gmail.com>
Message-ID: <CAL_Jsq+rqigmySoJg0iknkEJ5hzWeD3w2iSTpWoqoD67fGV3cw@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 7:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> DEFINE_DRM_GEM_SHMEM_FOPS is identical to DEFINE_DRM_GEM_FOPS now,
> drop it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
>  drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
>  drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
>  4 files changed, 3 insertions(+), 29 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
