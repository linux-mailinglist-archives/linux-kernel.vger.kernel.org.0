Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430D986D68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390361AbfHHWvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 18:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733140AbfHHWvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:51:13 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98E132166E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565304672;
        bh=2E5zXkmUdh7YQCGVCVw3jcywOMy6GhyyM90zGnvuCe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pebzK+QkjACrnuP9JbealzZ490748wvrZe8I+BlTpj4nkRcwzqUE61Xga4hMDpYL/
         hHzx9lIbkXJHshWB7MLp0zjsgu+A0iwoZ3FOKkOVKKUhlTIh6mfCPHU3GrXwEzQPIC
         3uVfoA9QCFrYbc77z2Ke69Iu8FDsgiOLP1enN8SE=
Received: by mail-qt1-f174.google.com with SMTP id l9so93927888qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:51:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXbipXh1wThzxWNhIgbHekE3qPcHZ0IUlljJybBOxykxu2xh5XM
        1z7wKi4n3T7v7BXLyli/YzQJnV2h0p4wyC6lAA==
X-Google-Smtp-Source: APXvYqyA2hIn0XiJuNJycBxSwBWHdeqoDL4GvlfM5I+8YAcF6aweUhFP77P+e7q5rCrWfED65M/i24zSoWbAiQ4R7gM=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr15618231qvf.200.1565304671853;
 Thu, 08 Aug 2019 15:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190808134417.10610-1-kraxel@redhat.com> <20190808134417.10610-7-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-7-kraxel@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Aug 2019 16:51:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd=Ra1Fc=g5qu4AABmi_YaQzaBFdhnoTkQpkA6n4B82w@mail.gmail.com>
Message-ID: <CAL_JsqJd=Ra1Fc=g5qu4AABmi_YaQzaBFdhnoTkQpkA6n4B82w@mail.gmail.com>
Subject: Re: [PATCH v4 06/17] drm/shmem: switch shmem helper to drm_gem_object_funcs->mmap
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 7:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Switch gem shmem helper from gem_driver->fops->mmap to
> drm_gem_object_funcs->mmap.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_gem_shmem_helper.h      |  4 ++--
>  drivers/gpu/drm/drm_gem_shmem_helper.c  | 18 +++++++-----------
>  drivers/gpu/drm/panfrost/panfrost_gem.c |  1 +
>  drivers/gpu/drm/v3d/v3d_bo.c            |  1 +
>  4 files changed, 11 insertions(+), 13 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
