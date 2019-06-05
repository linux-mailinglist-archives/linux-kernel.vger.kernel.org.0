Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399F3359B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfFEJcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 05:32:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:61614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfFEJcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:32:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 02:32:03 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jun 2019 02:31:59 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 08/22] gpu: i915.rst: Fix references to renamed files
In-Reply-To: <bd7dd29b9fb2101c954c8cfb2c3b4efc7d277045.1559656538.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1559656538.git.mchehab+samsung@kernel.org> <bd7dd29b9fb2101c954c8cfb2c3b4efc7d277045.1559656538.git.mchehab+samsung@kernel.org>
Date:   Wed, 05 Jun 2019 12:35:05 +0300
Message-ID: <87woi02x4m.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Hardware workarounds ./drivers/gpu/drm/i915/intel_workarounds.c' failed with return code 1
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Logical Rings, Logical Ring Contexts and Execlists ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 1
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 2
>
> Fixes: 112ed2d31a46 ("drm/i915: Move GraphicsTechnology files under gt/")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks for the patch, I picked this via drm-intel because the commit
being fixed is not in Linus' tree yet.

BR,
Jani.


> ---
>  Documentation/gpu/i915.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 055df45596c1..6c75380b2928 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -61,7 +61,7 @@ Intel GVT-g Host Support(vGPU device model)
>  Workarounds
>  -----------
>  
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_workarounds.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_workarounds.c
>     :doc: Hardware workarounds
>  
>  Display Hardware Handling
> @@ -379,10 +379,10 @@ User Batchbuffer Execution
>  Logical Rings, Logical Ring Contexts and Execlists
>  --------------------------------------------------
>  
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
>     :doc: Logical Rings, Logical Ring Contexts and Execlists
>  
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
>     :internal:
>  
>  Global GTT views

-- 
Jani Nikula, Intel Open Source Graphics Center
