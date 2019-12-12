Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFC11C6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 09:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfLLIOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 03:14:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:54992 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfLLIOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:14:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 00:14:29 -0800
X-IronPort-AV: E=Sophos;i="5.69,305,1571727600"; 
   d="scan'208";a="207991813"
Received: from lenovo-x280.ger.corp.intel.com (HELO localhost) ([10.252.35.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 00:14:26 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: add missed nv50_outp_release in nv50_msto_disable
In-Reply-To: <20191206075321.18239-1-hslester96@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191206075321.18239-1-hslester96@gmail.com>
Date:   Thu, 12 Dec 2019 10:14:25 +0200
Message-ID: <8736dq2c66.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Dec 2019, Chuhong Yuan <hslester96@gmail.com> wrote:
> nv50_msto_disable() does not call nv50_outp_release() to match
> nv50_outp_acquire() like other disable().
> Add the missed call to fix it.

The subject prefix "drm/dp_mst" implies drm core change, but this is
about nouveau. Please fix.

BR,
Jani.

>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 549486f1d937..84e1417355cc 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -862,8 +862,10 @@ nv50_msto_disable(struct drm_encoder *encoder)
>  
>  	mstm->outp->update(mstm->outp, msto->head->base.index, NULL, 0, 0);
>  	mstm->modified = true;
> -	if (!--mstm->links)
> +	if (!--mstm->links) {
>  		mstm->disabled = true;
> +		nv50_outp_release(mstm->outp);
> +	}
>  	msto->disabled = true;
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
