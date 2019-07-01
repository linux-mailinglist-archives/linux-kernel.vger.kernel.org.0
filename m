Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9782722F13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfETIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:37:26 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:54071 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfETIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:37:26 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1FCF52800BC20;
        Mon, 20 May 2019 10:37:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BE197AEB34; Mon, 20 May 2019 10:37:23 +0200 (CEST)
Date:   Mon, 20 May 2019 10:37:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 30/33] vgaswitcheroo: call fbcon_remap_all directly
Message-ID: <20190520083723.xgjrocuuhwq4mcms@wunner.de>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-31-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520082216.26273-31-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:22:13AM +0200, Daniel Vetter wrote:
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3146,16 +3146,16 @@ void fbcon_fb_unregistered(struct fb_info *info)
>  }
>  
>  /* called with console_lock held */
> -static void fbcon_remap_all(int idx)

That comment needs to be removed as well.

Not an expert on fbcon code but this looks sane to me, so in case it helps:
Acked-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
