Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E16599BBFB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 07:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHXFXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 01:23:09 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:33377 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHXFXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 01:23:08 -0400
Received: by mail-lf1-f44.google.com with SMTP id x3so8622453lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u6/+wFW8V2VNoIXw+4p1fdQvpQu+HadJVx/6VAdQfK4=;
        b=ucxSIsCZbsj+lVB6JqcvZX9B77ULKHjh/6W2T9/qDt1CJbcW5ei7Wy2UCd9OMwU749
         3xCfcA5sdqL66FCYNBi66rbRizZuCjqT/jttPnwVFeSgfZTpUKKhoLukzeT0GGwpqNQp
         CgUZdHeiU3FfDwMz6S+6UI029KNgZseQZEX0U/Fus0TLl7mapDuhX6HT0D/38PhSu0qG
         nXTZED2f2LIHAH4KF4P/RBHfI6rtgoEfSsSsuANxFd1YA2SNvSSWHq7r0xjT3jytYksg
         vanKmLjczKPR2Pux+q5VVA8MWhz098i9CRHT0BnTCqfQwMtr93pycEz/50m4QUMaazMt
         HtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u6/+wFW8V2VNoIXw+4p1fdQvpQu+HadJVx/6VAdQfK4=;
        b=tHZKFUC3Jv4P73bO6cB3xikNkz6pIwGWklK9VVXKWWZsIZannyFALA1Rbx9UNB1v1l
         1mVf+S7wKDevc3ETq6OVCfK/uxCakn8/8XAj/Z236ta+vaLccdkrXnbnAJ7T5IHjn/Fw
         zPn35o3r5uVMWYl7uocxZrkhk3WzJH+eDr8OWz6HE1b4qgQpvXbDTuVLcJtw0AZAqGqi
         hhW4N6HkVSjAZ94Pdn8p6X7BDCM25ywHiwKn/q4PKIFnQfyqfij2heyNsEG+mOxa9dBM
         vcfBcu1vPM+9udkVUkBdMFgdmWdzJhfEJFkAdFCJzYaXTJWTBtIfzsZWOqW9+9rRMcXK
         Rcuw==
X-Gm-Message-State: APjAAAUXJx0kLjYXDr8KDjAzIPP9VGj9UKj/DdtZKd2NmdtJoOMa3YI7
        D3ilGvXHvbtWAVDGcicDn6sD5P8NAY00JL597hc=
X-Google-Smtp-Source: APXvYqyMQ3B/fV6I229TFJGpuuSsZT/R+bhkUCO5DrGtNZcGvKbFfaPbfkJLfhpM5ATgbxw1Yo4Ijy2WGJW7Cu593cU=
X-Received: by 2002:a05:6512:4c8:: with SMTP id w8mr4697724lfq.98.1566624186100;
 Fri, 23 Aug 2019 22:23:06 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 24 Aug 2019 15:22:55 +1000
Message-ID: <CAPM=9twtUmogvabQJD8CcazYfhWUjTUOyRkFomor77LbVDrcKA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.3-rc6 (the second coming)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Although the tree built for me fine on arm here, it appears either
header cleanups in next or some kconfig combo it breaks, so this
contains a fix to mediatek to include dma-mapping.h explicitly.

There was also one nouveau fix that came in late that I was going to
leave until next week, but since I was sending this I thought it may
as well be in here.

Dave.

drm-fixes-2019-08-24:
drm fixes for 5.3-rc6 (part 2)

mediatek:
- fix build in some cases

nouveau:
- fix hang with i2c and mst docks
The following changes since commit 75710f08ea7e41b2f7010da3f6deab061f7a853b:

  drm/amdgpu/powerplay: silence a warning in smu_v11_0_setup_pptable
(2019-08-23 11:46:32 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-24

for you to fetch changes up to 7837951a12fdaf88d2c51ff0757980c00072790c:

  drm/mediatek: include dma-mapping header (2019-08-24 15:09:20 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc6 (part 2)

mediatek:
- fix build in some cases

nouveau:
- fix hang with i2c and mst docks

----------------------------------------------------------------
Dave Airlie (2):
      Merge branch 'linux-5.3' of git://github.com/skeggsb/linux into drm-fixes
      drm/mediatek: include dma-mapping header

Lyude Paul (1):
      drm/nouveau: Don't retry infinitely when receiving no data on i2c over AUX

 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)
