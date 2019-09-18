Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164C8B620A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfIRLF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 07:05:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35404 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbfIRLF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:05:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id a24so3863986pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=30kQKIRjGxbZH2nrKPWjM2nH2PE3zFDpBAbVHM44zes=;
        b=I4c5ggCxKN2zNntPxQ1I5QqVgDzZVa6XYoqPMTttSpuZBN0gfixeIStuTRzRZ6WY3X
         HfrPeeV1m9D33/ag0Z0LnvCdpfZyE6LJZ6wyjSTM2ZDIvm5I4RAWp65JG82Pip5qSctc
         OvhmV3Vad1ufLfnCOQ60M8Th5bwDxuUfm2I3FhWNW39zqFIYu3+HklpG+HBD2MRa93Fq
         oYbkGAvV6Tqb9xt4uQS59a1Vy5MAbVtZp0hJLl6mkz2Fe9qVcyfbYqt0n0tRnqQc+tjY
         gwAfhkvtxRkfp2Sntw+teo7GrHp0+Xxg2BJCiYdrEtzIhQfCIGnVpGWU7dKH0zPH2eDR
         W6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=30kQKIRjGxbZH2nrKPWjM2nH2PE3zFDpBAbVHM44zes=;
        b=XAHOyBFMpRQSWsT9khxI0iy7nL/jddgWDwdxB8nzwADRJtgAzelmGKo33mrykqLone
         fdpPAVs77nzG4wDXlnI8DlIPm9mbcCBCyTBg0th3+W2fkFT91YysDLKvPQWm7VhqYONo
         beDvPpySAXnjPFCBUhLYDttMU7OMcGpS2vi3QMQ03QJ52Xtjlwe52SK27sOtHD5O1Abs
         1xScddCxpvcLYleG6qNbQJK4nRHVTSg2KUvChHl2+kQ+INoX25une5ukbOtk09Wvy8G2
         Akj3IsqoqBGHbZZr8Epl9RZTeaEx5PYPs+tnjYaEAgIc9iD2safsRPmNuTiz0rgAlUbo
         QLXg==
X-Gm-Message-State: APjAAAUtMkWWKAUIuB7ZugzLulETPF2HJbS+5Eytb3F0Vz6MOA33VhON
        tEjmQtgN6YL2gm9GYc7x1H5H5dqwrm0=
X-Google-Smtp-Source: APXvYqxvwEq7GgqxXcrrTzkO4wvLdmjk+3DH/4Ln4BikZpyOFogYSQ9s3A7KhZsmgUq+kV1vCwAyQg==
X-Received: by 2002:a63:9a11:: with SMTP id o17mr3335385pge.434.1568804756380;
        Wed, 18 Sep 2019 04:05:56 -0700 (PDT)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id 8sm6695461pjt.14.2019.09.18.04.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 04:05:55 -0700 (PDT)
From:   roman.stratiienko@globallogic.com
To:     linux-kernel@vger.kernel.org, mripard@kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH] drm/sun4i: Add missing pixel formats to the vi layer
Date:   Wed, 18 Sep 2019 14:05:41 +0300
Message-Id: <20190918110541.38124-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

According to Allwinner DE2.0 Specification REV 1.0, vi layer supports the
following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index bd0e6a52d1d8..07c27e6a4b77 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -404,17 +404,21 @@ static const struct drm_plane_funcs sun8i_vi_layer_funcs = {
 static const u32 sun8i_vi_layer_formats[] = {
 	DRM_FORMAT_ABGR1555,
 	DRM_FORMAT_ABGR4444,
+	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_BGR565,
 	DRM_FORMAT_BGR888,
 	DRM_FORMAT_BGRA5551,
 	DRM_FORMAT_BGRA4444,
+	DRM_FORMAT_BGRA8888,
 	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_RGBX8888,
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_XRGB8888,
-- 
2.17.1

