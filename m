Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE91329B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgAGPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 10:13:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52638 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgAGPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:13:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so19346763wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQTaLBi6j7EgaoJz5qobsvGq1YHqHDB8qwtSQ4J8zF0=;
        b=atcxLIBg/X241bRTSOHHcqILNV70RVqHeLsTcSB3LmtonMWDV2RLzh6oPntcbyyojo
         hCJuZa6/DhXqTmWwQc8/EnqRuieFNMMoo8kaK0y+mKkxDDNQTUyo57zRrm9WR+NSfF6e
         vil0ho48k0k1QVC6wksg7Lu2rrlr636d4pC+4nRO7Emq/HLrtQ9GygmpriJRfrr9Fw7q
         u4kY81Uq5Cxr7eZw5qNQhymAut3xV0Sn83p0BFZjwuzLvbSj1Lyl4xfE358CUxlvigSa
         a/39Qr9hnxiDANkqIYDW4usgpWei98Hh4h2TMnOwTbA+0/Bbu8ttvNDHsfAfHSwBB002
         NfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQTaLBi6j7EgaoJz5qobsvGq1YHqHDB8qwtSQ4J8zF0=;
        b=aZkIUKgpBnKpLFQgUyNU6xMP/I3sP5r7CDM+Y+bCI6utLGHEDfOMdXTwP3oy4fap1u
         4P9mdWVlUQsRIkMMABq8DXCMb8/kGCDQXDw5lqxdcD7/kNbmEd45DJ+1iPYuaJq0pLgf
         lYJ67rIQkNfLJkF5G1rS9wyEMcNmghWG8iLjqjt2VCUbbvwKkV/CedgQfUg4wr9vSUoG
         9qg4upQahwtJCy1fMumTes+oURDx+Z83fhEPJljuqgjNNaJrxqiIjmAL2+o+n7A9oVx4
         bfmcGgO+DibihRUy2O1+k5IH3yqS1pqqMJ0POCjGSWVxcie+dTQEhQkfRAUvxDJGwEmL
         e/cA==
X-Gm-Message-State: APjAAAW7Xrvfj09vsDJIpMBQ4CZ74AsRMT7emQcHipRPdf3zwAAREUrL
        AizG2WW2EMOCN6meh5/pFQg=
X-Google-Smtp-Source: APXvYqyOqZvqLcqbZ32d6g02T/B0eS7dqxb9+bjRh/TuMWGi6Kd0t/LvRAzX44WDosZS2jY4MML7tw==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr41252316wmg.110.1578410019088;
        Tue, 07 Jan 2020 07:13:39 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id c4sm27076664wml.7.2020.01.07.07.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:13:38 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/i915: conversion to new drm logging macros.
Date:   Tue,  7 Jan 2020 18:13:28 +0300
Message-Id: <cover.1578409433.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series begins the conversion to using the new struct drm_device
based logging macros in drm/i915.

Wambui Karuga (5):
  drm/i915: convert to using the drm_dbg_kms() macro.
  drm/i915: use new struct drm_device logging macros.
  drm/i915: use new struct drm_device based logging macros.
  drm/i915: convert to using new struct drm_device logging macros
  drm/i915: use new struct drm_device based macros.

 drivers/gpu/drm/i915/intel_pch.c         |  46 +--
 drivers/gpu/drm/i915/intel_pm.c          | 351 +++++++++++++----------
 drivers/gpu/drm/i915/intel_region_lmem.c |  10 +-
 drivers/gpu/drm/i915/intel_sideband.c    |  29 +-
 drivers/gpu/drm/i915/intel_uncore.c      |  25 +-
 5 files changed, 254 insertions(+), 207 deletions(-)

-- 
2.24.1

