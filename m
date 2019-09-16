Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932F3B43C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfIPWH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 18:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732784AbfIPWH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:07:27 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9593D21670
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568671646;
        bh=dOmx+5b6FQTG2S2CZB6xwqvYvyES1DQ1DZe+OAaMClg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vqktAQYAqdZQgDA2CtTybSuSETpsBWt7QdjYS1Ul6ZH2Zqd4TNkLn2pHNuNvPk/Vt
         4tJIsivFm0ZeY014fO1zUv9DeJY9X03hJAY8KY4lKExIcQtByGyCi6qUSYdoEUP7I+
         kMzmbws2N/zLBMqRsNuZ8b864lBbNVokNah0F+Vk=
Received: by mail-qk1-f177.google.com with SMTP id u184so1693298qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:07:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUdjNm3pgvipS0L4CR68mHfP2olEEgLM2mY4WXl+TSVgRbqCjIO
        uRnIignTcnrdH6KKHsV5yyIq4+RgubeGLeUS5w==
X-Google-Smtp-Source: APXvYqw0JdhpCWLexwIOT8ESTlHEFkeSnb9jRER69EJErTdTZGBlE/PDwDE/PA78bdeKSSrQ0wdFLVGRQB2aD4rqikg=
X-Received: by 2002:a05:620a:549:: with SMTP id o9mr575224qko.223.1568671645784;
 Mon, 16 Sep 2019 15:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190913122908.784-1-kraxel@redhat.com> <20190913122908.784-4-kraxel@redhat.com>
In-Reply-To: <20190913122908.784-4-kraxel@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Sep 2019 17:07:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJajCtM=vRgSDX2DQ6iJzDgMHicXgXgGqF7Bc-KdTUUQA@mail.gmail.com>
Message-ID: <CAL_JsqJajCtM=vRgSDX2DQ6iJzDgMHicXgXgGqF7Bc-KdTUUQA@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
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

On Fri, Sep 13, 2019 at 7:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>

Version? Pretty sure this is not v1.

> DEFINE_DRM_GEM_SHMEM_FOPS is identical
> to DEFINE_DRM_GEM_FOPS now, drop it.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
>  drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
>  drivers/gpu/drm/tiny/gm12u320.c         |  2 +-
>  drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c    |  2 +-
>  6 files changed, 5 insertions(+), 31 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
