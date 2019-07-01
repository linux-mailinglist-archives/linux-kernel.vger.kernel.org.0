Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E95989D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfF1KmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 06:42:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53208 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF1KmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:42:00 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0571827EA8A;
        Fri, 28 Jun 2019 11:41:57 +0100 (BST)
Date:   Fri, 28 Jun 2019 12:41:54 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: connector: remove bogus NULL check
Message-ID: <20190628124154.5245f629@collabora.com>
In-Reply-To: <20190628103925.2686249-1-arnd@arndb.de>
References: <20190628103925.2686249-1-arnd@arndb.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 12:39:05 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> mode->name is a character array in a structure, checking it's
> address is pointless and causes a warning with some compilers:
> 
> drivers/gpu/drm/drm_connector.c:144:15: error: address of array 'mode->name' will always evaluate to 'true'
>       [-Werror,-Wpointer-bool-conversion]
>                       mode->name ? mode->name : "",
>                       ~~~~~~^~~~ ~
> include/drm/drm_print.h:366:29: note: expanded from macro 'DRM_DEBUG_KMS'
>         drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
>                                    ^~~~~~~~~~~
> 
> Remove the check here.
> 
> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 3afed5677946..b3f2cf7eae9c 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -141,7 +141,7 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
>  
>  	DRM_DEBUG_KMS("cmdline mode for connector %s %s %dx%d@%dHz%s%s%s\n",
>  		      connector->name,
> -		      mode->name ? mode->name : "",
> +		      mode->name,
>  		      mode->xres, mode->yres,
>  		      mode->refresh_specified ? mode->refresh : 60,
>  		      mode->rb ? " reduced blanking" : "",

