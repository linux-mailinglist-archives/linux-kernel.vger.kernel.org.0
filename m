Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066DB17B2BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFAVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:21:21 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53663 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCFAVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:21:20 -0500
Received: by mail-pj1-f65.google.com with SMTP id cx7so295678pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJSb47iRAmacuiIgPWOL6dFUPqbDjpIVJqy0/NtA6/o=;
        b=CKYtvbCQIDRoU2urvS0iaJ8B+f6KWSMedxeRgGs2XCLSRQ7E0n0NPAy7fsx/4NWiN3
         xaaUL1ki4WjoFup6wgcUYLY+anMKStvUn25Oc7J95rrz3iO2WTCK2F93/ehzzWeFtJOP
         7U5FsNYBGY59eodEfQ81oloKD2DLpT19Zy9SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJSb47iRAmacuiIgPWOL6dFUPqbDjpIVJqy0/NtA6/o=;
        b=QMvr1QB7fIBMLseT+ZXEYTas4qHyZAjGI4VHsp+FhuBn+rT5y1SWwiAXxQ/IOXqdsI
         b4HytqFuqozSjlAqA7SRwY2yaV/TSAYElOcsbJJe0eaE2fFXsKdN/dbWRil+14hn9tjl
         IiLheHShwsDwJS9h3SuoQc/NlVkrN18vt8TfI15r/+gvKaKVwfLmJ3rCdnk9jQTlRIFD
         gf3176p64CIJVweRnxJGmBbBV6wsiJhRlsQluxaHquBsH6jbVSCw6gEzJ+L0FQ8amrOb
         71P+dz0nOrlMoGtFx4jQ95S0VHN6s4Sk6m7HD4otgMeHlBjfPVFcezFhYnSzPeWm+gxT
         uIvg==
X-Gm-Message-State: ANhLgQ2+SnBOoCB57hwHAlyt9TpFvJ6U9Vb7wNwdQL53sLNn4Q1BYC8u
        ba6upVO/ptrtOJ07rNPBUSR84RVqu2E=
X-Google-Smtp-Source: ADFU+vvmhMGHJxnqwlSNBaW/zJEwPDdnnhVY/JhYtnz8CTMEhmrOcwC0a3b957LsR4UX7PR0yEDTmw==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr715297pjv.57.1583454077682;
        Thu, 05 Mar 2020 16:21:17 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id y1sm30080225pgs.74.2020.03.05.16.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 16:21:16 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v10 0/2] Panel rotation patches
Date:   Thu,  5 Mar 2020 16:21:10 -0800
Message-Id: <20200306002112.255361-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the plumbing for reading panel rotation from the devicetree
and sets up adding a panel property for the panel orientation on
Mediatek SoCs when a rotation is present.

v10 changes:
-Adapted to drm_panel_attach changes, so panel orientation is now set
 for the connector in get_modes
-Dropped patch that was already accepted

v9 changes:
-Changed to copying display properties from another copy of
 drm_display_info in drm_panel_attach.

v8 changes:
-added reviewed-by tags
-fixed conflict with i915 patch that recently landed
-Added additional documentation

v7 changes:
-forgot to add static inline

v6 changes:
-added enum declaration to drm_panel.h header

v5 changes:
-rebased

v4 changes:
-fixed some changes made to the i915 driver
-clarified comments on of orientation helper

v3 changes:
-changed from attach/detach callbacks to directly setting fixed panel
 values in drm_panel_attach
-removed update to Documentation
-added separate function for quirked panel orientation property init

v2 changes:
fixed build errors in i915

Derek Basehore (4):
  drm/panel: Add helper for reading DT rotation
  drm/panel: set display info in panel attach
  drm/connector: Split out orientation quirk detection
  drm/mtk: add panel orientation property

 drivers/gpu/drm/drm_connector.c    | 45 ++++++++++++++-----
 drivers/gpu/drm/drm_panel.c        | 70 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_dp.c    |  4 +-
 drivers/gpu/drm/i915/vlv_dsi.c     |  5 +--
 drivers/gpu/drm/mediatek/mtk_dsi.c |  8 ++++
 include/drm/drm_connector.h        |  2 +
 include/drm/drm_panel.h            | 21 +++++++++
 7 files changed, 138 insertions(+), 17 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

