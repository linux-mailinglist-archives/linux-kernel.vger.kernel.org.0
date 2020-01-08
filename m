Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5B134427
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgAHNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 08:44:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:14326 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgAHNoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:44:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 05:44:24 -0800
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="222934967"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 05:44:22 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chen Zhou <chenzhou10@huawei.com>, airlied@linux.ie,
        chris@chris-wilson.co.uk
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, chenzhou10@huawei.com
Subject: Re: [PATCH next] drm/i915/gtt: add missing include file asm/smp.h
In-Reply-To: <20200108133610.92714-1-chenzhou10@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200108133610.92714-1-chenzhou10@huawei.com>
Date:   Wed, 08 Jan 2020 15:44:19 +0200
Message-ID: <877e22qczw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Chen Zhou <chenzhou10@huawei.com> wrote:
> Fix build error:
> lib/crypto/chacha.c: In function chacha_permute:
> lib/crypto/chacha.c:65:1: warning: the frame size of 3384 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  }
>   ^

IMO this needs a better explanation of why not having the include leads
to the above failure.

BR,
Jani.

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_ggtt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> index 1a2b5dc..9ef8ed8 100644
> --- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
> @@ -6,6 +6,7 @@
>  #include <linux/stop_machine.h>
>  
>  #include <asm/set_memory.h>
> +#include <asm/smp.h>
>  
>  #include "intel_gt.h"
>  #include "i915_drv.h"

-- 
Jani Nikula, Intel Open Source Graphics Center
