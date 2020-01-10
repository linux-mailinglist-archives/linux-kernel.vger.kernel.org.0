Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C92136F25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgAJORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 09:17:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:22303 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgAJORl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:17:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 06:17:41 -0800
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="212276227"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 06:17:38 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/i915: conversion to new drm logging macros.
In-Reply-To: <cover.1578409433.git.wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1578409433.git.wambui.karugax@gmail.com>
Date:   Fri, 10 Jan 2020 16:17:35 +0200
Message-ID: <8736cno0ow.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> This series begins the conversion to using the new struct drm_device
> based logging macros in drm/i915.
>
> Wambui Karuga (5):
>   drm/i915: convert to using the drm_dbg_kms() macro.
>   drm/i915: use new struct drm_device logging macros.
>   drm/i915: use new struct drm_device based logging macros.
>   drm/i915: convert to using new struct drm_device logging macros
>   drm/i915: use new struct drm_device based macros.

Thanks for the patches, pushed to drm-intel-next-queued.

As it's impossible to distinguish the commits from each other by the
subject line alone, I've amended the prefix while pushing as follows:

drm/i915/pch: convert to using the drm_dbg_kms() macro.
drm/i915/pm: use new struct drm_device logging macros.
drm/i915/lmem: use new struct drm_device based logging macros.
drm/i915/sideband: convert to using new struct drm_device logging macros
drm/i915/uncore: use new struct drm_device based macros.

Please pay attention to this in future work. It's not always obvious
what the prefix should be, but 'git log -- path/to/file.c' will go a
long way.

BR,
Jani.


>
>  drivers/gpu/drm/i915/intel_pch.c         |  46 +--
>  drivers/gpu/drm/i915/intel_pm.c          | 351 +++++++++++++----------
>  drivers/gpu/drm/i915/intel_region_lmem.c |  10 +-
>  drivers/gpu/drm/i915/intel_sideband.c    |  29 +-
>  drivers/gpu/drm/i915/intel_uncore.c      |  25 +-
>  5 files changed, 254 insertions(+), 207 deletions(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
