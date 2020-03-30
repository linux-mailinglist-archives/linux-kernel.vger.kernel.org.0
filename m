Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569A51981B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgC3QxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 12:53:14 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51870 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgC3QxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:53:14 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 036CF72CCED;
        Mon, 30 Mar 2020 19:53:12 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D39317CCB1F; Mon, 30 Mar 2020 19:53:11 +0300 (MSK)
Date:   Mon, 30 Mar 2020 19:53:11 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 5/5] ALSA: uapi: Drop asound.h inclusion
 from asoc.h
Message-ID: <20200330165311.GA11372@altlinux.org>
References: <20191220153415.2740-1-tiwai@suse.de>
 <20191220153415.2740-6-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220153415.2740-6-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 04:34:15PM +0100, Takashi Iwai wrote:
> The asound.h isn't always available while asoc.h itself is distributed
> in alsa-lib package.  So we need to avoid the unnecessary inclusion of
> asound.h from there.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/uapi/sound/asoc.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index a74ca232f1fc..6048553c119d 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -17,7 +17,6 @@
>  #define __LINUX_UAPI_SND_ASOC_H
>  
>  #include <linux/types.h>
> -#include <sound/asound.h>
>  
>  /*
>   * Maximum number of channels topology kcontrol can represent.

This has reached v5.6 and caused the following regression:

sound/asoc.h:214:14: error: 'SNDRV_CTL_ELEM_ID_NAME_MAXLEN' undeclared here (not in a function)
  214 |  char string[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];

Please revert or fix in some way to make the uapi header compileable again.

Thanks,


-- 
ldv
