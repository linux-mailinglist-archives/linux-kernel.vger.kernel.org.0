Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DBE6EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfJ1JUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 05:20:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40335 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJ1JUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:20:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so8257888wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UntOsok0RJA5xyBdV5DE84ry7KtJuNs3rA69E2z2DlM=;
        b=JP4d5d7Rp2a/4tRoivSLq+T9QpD49Linqp+deoL1VU3fPfpuQx1pkHQc0AfSvCfx4S
         82e22oG+ChZcIaEWz2LAlG7Uv6N5f7OqHWgD8fs5Vi3gEPxj7GQtWAvfBDi0kHC32QWu
         /fyaI9E+kMjFLnw/Pe06IVT5vCAny2fA4QgtTxE0TW8ElrzkyucDbRNs74XJz1+s00My
         qFHluGcSUbJsjB/LxULcAycCqhuSAfpePvB4FQpwDD6QbgPQq7tQ15nlOWqRppw+sdpS
         rotuwM+0dwCWSbLcG2OwUT9Tc5Fc2UEbpWBRuTtCvWsFzWBgwBMmsSgnrcQc7tpmlbmp
         Us3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UntOsok0RJA5xyBdV5DE84ry7KtJuNs3rA69E2z2DlM=;
        b=ifVqWR/UWKa1sPhsRDZ/CCA+u/1Chgi5+6Bl3w1Kco2sZq8Eiq7hwHqdbzMqjZ1Fqq
         8EyNcolgrGV94v28Y9VpAV0ylYEW8Nzf6HcmZQkujXAACxEDKx/lvbS1HzaFKTRqjuPO
         d1NM2uZbdMbqAC9GhXHDwvCqriWdBQucxpnB0Y5h3ulR5MICG/LYBVJuSduYiPnNgqHq
         WaFDSH6SfXFG0m1X3Mn5qpYf57x5R/KRDxOlrPMEcdMMYoJLfW2nTsy4HLL0J5Y/ya3V
         PDt1mBQexVG8gPv7bHGSMn2rCApcZlgPhKm9PxlyRzi5xXNaUnWVku2ntmcUyNgnpVJv
         nPdg==
X-Gm-Message-State: APjAAAW3NM48hBKpLnyXx2pfSNtbqP22Yc5MqM6ehZtowfkDaT743yKS
        1zj3KucqyVJY1lz4DeLGQYw=
X-Google-Smtp-Source: APXvYqyJUBnyICbDWxYuvED5P/6503b/z3i6qtHWN/gRRjhaGQcOu9SUYbms5Y7BWsojxsYdr9mnyA==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr15828228wmk.25.1572254415073;
        Mon, 28 Oct 2019 02:20:15 -0700 (PDT)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id z9sm11427513wrv.1.2019.10.28.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 02:20:14 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        outreachy-kernel@googlegroups.com
Subject: [Outreachy][PATCH 0/2] sparse warning cleanup
Date:   Mon, 28 Oct 2019 12:20:03 +0300
Message-Id: <20191028092005.31121-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses the sparse warning about the
`amdgpu_exp_hw_support` variable and corrects the mispelling of the
word "_LENTH".

Wambui Karuga (2):
  drm/amd: declare amdgpu_exp_hw_support in amdgpu.h
  drm/amd: correct "_LENTH" mispelling in constant

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.17.1

