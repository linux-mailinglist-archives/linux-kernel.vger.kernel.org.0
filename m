Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC52A8F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfEZHdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 May 2019 03:33:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36558 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfEZHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 03:33:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so458638pfm.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Cg/vgbjG/t5rG/2rIMWKtSp0D9gxhMUNGBD8lfkvzS0=;
        b=lInDxgR8++aiOOZRRg7PG6aQtERRyRMGsmCHU6znVpDZc33N+8MpiwAJx8drlR10dO
         ELNAGAeiqJFGXlisYv4hQcaHFN7P5g5Wynl15duks0SHXubMzJbMUzPGfHn01RslVPSu
         tHH48FIHLaQa3TXfb0hikzk0yOTGBas5C8SayH22GHTFQQVy0ZfeP3Hd0P66KRSfmCb/
         Ngpnzrs6jxXiL1SJlxJWUhk31y7WwugDhakoIJeXw8AFSJyTyvcq0O9ywMAd2Sce7UKM
         pZHr55rv0Mh6mD3Idu/mb1cxgHRM0pVtFKHJL/Ze8V3/mh1Jn6fReiA9Ig/1mnQZk3dx
         RE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Cg/vgbjG/t5rG/2rIMWKtSp0D9gxhMUNGBD8lfkvzS0=;
        b=G5Ztepn9fo+17kL2RJUprBi17fB5aTpgQfqS84POwELNSCoyDSVH1/65t5ZHpzZCS3
         GuZmbi1rxO10giopKNf5BfGmkyEWylzCWkyCQVqoExR6ZXrkDk5DpG1+oIW6VLqb35LV
         gsHKsbIF6/A8rUUhubcMiMHlwpM1tiya5/R6tDkDg6XSzGoN/Va58bqLyD/x5dEMGFEI
         JV5XUZSKtRkZvEF39wMtUvLla69+ah/KsCvvTt/7++JSMhV21vALSDIzsGRxJrr0cQ7W
         StBwpbdZGV2RGrCVHxSILf+90ohL+rQsSoOEJFGzUQ9UngyDajRZy5CK9Epq4ChjOW/L
         UNLg==
X-Gm-Message-State: APjAAAUTLaSejO31pGdGj3YgW60JnFx7zrKZPdbZNfViclY+q/NxhEh9
        C6/OgdVDB6BXj5lPip9eKmTnFrfzyGk=
X-Google-Smtp-Source: APXvYqxQfNCd1WBIL1/OjP2muAsSzBBETx0VADMdKojpASOPaJ/A7j+32WalD3l/bEIL0ShiPa0T8w==
X-Received: by 2002:a17:90a:a4c7:: with SMTP id l7mr21999145pjw.49.1558855982428;
        Sun, 26 May 2019 00:33:02 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id z9sm6652704pgc.82.2019.05.26.00.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 00:33:01 -0700 (PDT)
Date:   Sun, 26 May 2019 13:02:54 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Huang Rui <ray.huang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        James Zhu <James.Zhu@amd.com>, Shirish S <shirish.s@amd.com>,
        Trigger Huang <Trigger.Huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/amdgpu: Remove duplicate including duplicate header
Message-ID: <20190526073254.GA8567@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicate entry of soc15.h. Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c763733..d723332 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -34,7 +34,6 @@
 #include "vega10_enum.h"
 #include "hdp/hdp_4_0_offset.h"
 
-#include "soc15.h"
 #include "soc15_common.h"
 #include "clearstate_gfx9.h"
 #include "v9_structs.h"
-- 
2.7.4

