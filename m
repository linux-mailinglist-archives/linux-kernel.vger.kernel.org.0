Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF85133D11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 09:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgAHI0m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Jan 2020 03:26:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:50471 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgAHI0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:26:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 00:26:42 -0800
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="215883541"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.84.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 00:26:39 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b79ee0f6efbf8358cbb4f2e163fa6b5bb04db794.1578409433.git.wambui.karugax@gmail.com>
References: <cover.1578409433.git.wambui.karugax@gmail.com> <b79ee0f6efbf8358cbb4f2e163fa6b5bb04db794.1578409433.git.wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/5] drm/i915: convert to using the drm_dbg_kms() macro.
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     seanpaul@chromium.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Wambui Karuga <wambui.karugax@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        rodrigo.vivi@intel.com
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date:   Wed, 08 Jan 2020 10:26:36 +0200
Message-ID: <157847199686.4725.87481257304852182@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wambui Karuga (2020-01-07 17:13:29)
> Convert the use of the DRM_DEBUG_KMS() logging macro to the new struct
> drm_device based drm_dbg_kms() logging macro in i915/intel_pch.c.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/i915/intel_pch.c | 46 +++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_pch.c b/drivers/gpu/drm/i915/intel_pch.c
> index 43b68b5fc562..4ed60e1f01db 100644
> --- a/drivers/gpu/drm/i915/intel_pch.c
> +++ b/drivers/gpu/drm/i915/intel_pch.c
> @@ -12,90 +12,91 @@ intel_pch_type(const struct drm_i915_private *dev_priv, unsigned short id)
>  {
>         switch (id) {
>         case INTEL_PCH_IBX_DEVICE_ID_TYPE:
> -               DRM_DEBUG_KMS("Found Ibex Peak PCH\n");
> +               drm_dbg_kms(&dev_priv->drm, "Found Ibex Peak PCH\n");

Did we at some point consider i915_dbg_kms alias? That would just take
dev_priv (or i915, as it's called in newer code). It would shorten many
of the statements.

i915_dbg_kms(dev_priv, ...) or i915_dbg_kms(i915, ...)

Regards, Joonas
