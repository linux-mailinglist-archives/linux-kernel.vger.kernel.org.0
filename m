Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F0EC86D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 19:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKASYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 14:24:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:11995 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfKASYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:24:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 11:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="203931779"
Received: from labuser-z97x-ud5h.jf.intel.com (HELO intel.com) ([10.54.75.49])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2019 11:24:33 -0700
Date:   Fri, 1 Nov 2019 11:27:10 -0700
From:   Manasi Navare <manasi.d.navare@intel.com>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, rodrigosiqueiramelo@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Subject: Re: [PATCH] drm/vkms: Fix typo in function documentation
Message-ID: <20191101182709.GA32264@intel.com>
References: <20191101182102.30358-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101182102.30358-1-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:21:02PM -0300, Gabriela Bittencourt wrote:
> Fix typo in word 'blend' in function 'compute_crc' documentation.
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>

Manasi

> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index d5585695c64d..15efccdcce1b 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -43,7 +43,7 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
>  }
>  
>  /**
> - * blend - belnd value at vaddr_src with value at vaddr_dst
> + * blend - blend value at vaddr_src with value at vaddr_dst
>   * @vaddr_dst: destination address
>   * @vaddr_src: source address
>   * @dest_composer: destination framebuffer's metadata
> -- 
> 2.20.1
> 
