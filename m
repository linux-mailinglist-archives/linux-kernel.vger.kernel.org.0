Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB9151331
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBCX06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 18:26:58 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:26:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so16510066oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7PxxR1GHzdRYycbWi00wyis2Uv32fIAZsG7I2NFRsIw=;
        b=lRl7kEazMGZ0aJYBJaZOQQ5GyJy5smLO4fSz59JEidrYoVvgNAeu8G+Hq01N3IG0Wt
         GcO5t5AcYet5PTGky992RAU4BYSPrXqyBHCWZVMiEuvTb2FayVBeWUYfr5drb1onrv5r
         434b1B486q9Puk65Q+hCeY1Re26uRfXiU6V1YWmrzqvGs1QvF3GTM2i46MEMvnvCL5uZ
         26xMlFMquu9fiLm1ZTvHJNXW9ZVcaXZO7sCi011C5/s/UEhWQXTGdI21lCxBFLCyG4/N
         gjn1mdv/f04vJlTtyt8q2hwVIQsuXOTMm5XBr1z9al/K74+Bm1oehy+1OwWl27hc8f5X
         UsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7PxxR1GHzdRYycbWi00wyis2Uv32fIAZsG7I2NFRsIw=;
        b=H9xBuMQpwzQ9B85q4JWvuw40+bCGjY6UeRdqefLuYpFIRoxUoG94YcC/s1m4cDvRst
         jbn65VTXtsjpGuKwuNiejBbmsbK/vyzbIl37s99yv0Y7gBm6WMjVf+qRSDc4qE2YfT4d
         FnA4Ej6zcGNvqxT8Xa24SvFcpuS/DGQFXOPIiJfKA5iDr1UKcdt8PsiUkA0CVutv9MVL
         KguR5NQSU/vtz572MQ3S6v+kyo9wosQvifMe1kt1H8Ya0OqQNN2ntJ95puSkrmGFsJLg
         akPst4wCFdPIX3Ot6p1OSKo2ABJlLKVWVJMkSJznLG5ZSD+vrMgWm8Zh9noAhdVbmcpa
         oWbg==
X-Gm-Message-State: APjAAAVQ9EOcgWr4Kdes62jAQZFvkuS5NF/uixvhQbgSgUxW8iuptzms
        LeBqPIqwaFUsDxeoiEodpyD4wc2GIyRXJF9cznQ=
X-Google-Smtp-Source: APXvYqzCVSOmE/7CGjSxr8z/VVtC3D8eo9OyTml6D6R4PWfUHm/aXYct9eXk9L00tlcvpbTKk2N0nD0hatGuIMMDhgs=
X-Received: by 2002:aca:815:: with SMTP id 21mr1230178oii.52.1580772417222;
 Mon, 03 Feb 2020 15:26:57 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 4 Feb 2020 09:26:45 +1000
Message-ID: <CAPM=9tyPRUfbZZtVWWxs95aLkuaXkenwGU+QfR3N6NLRn+PsHg@mail.gmail.com>
Subject: [git pull] drm ttm/mm for 5.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thomas Hellstrom has some more changes to the TTM layer that needed a
patch to the mm subsystem, this adds a new mm API
vmf_insert_mixed_prot to avoid an ugly hack that has limitations in
the TTM layer.

Should be all correctly acked.

Regards,
Dave.

drm-next-2020-02-04:
drm ttm/mm changes for 5.6-rc1
The following changes since commit d47c7f06268082bc0082a15297a07c0da59b0fc4:

  Merge branch 'linux-5.6' of git://github.com/skeggsb/linux into
drm-next (2020-01-30 15:18:38 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-02-04

for you to fetch changes up to b45f1b3b585e195a7daead16d914e164310b1df6:

  Merge branch 'ttm-prot-fix' of
git://people.freedesktop.org/~thomash/linux into drm-next (2020-01-31
16:58:35 +1000)

----------------------------------------------------------------
drm ttm/mm changes for 5.6-rc1

----------------------------------------------------------------
Dave Airlie (1):
      Merge branch 'ttm-prot-fix' of
git://people.freedesktop.org/~thomash/linux into drm-next

Thomas Hellstrom (2):
      mm: Add a vmf_insert_mixed_prot() function
      mm, drm/ttm: Fix vm page protection handling

 drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++++++++-------
 include/linux/mm.h              |  2 ++
 include/linux/mm_types.h        |  7 ++++++-
 mm/memory.c                     | 44 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 63 insertions(+), 12 deletions(-)
