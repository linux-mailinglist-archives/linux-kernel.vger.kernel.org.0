Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335C418432F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 10:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCMJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 05:03:44 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:38446 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCMJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:03:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id A633C804D0;
        Fri, 13 Mar 2020 10:03:39 +0100 (CET)
Date:   Fri, 13 Mar 2020 10:03:38 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Message-ID: <20200313090338.GA31815@ravnborg.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200313084152.2734-1-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=vkfgAjWNAAAA:8
        a=20KFwNOVAAAA:8 a=7gkXJVJtAAAA:8 a=XvIV5Jx4ir0DwZFBozwA:9
        a=wPNLvfGTeEIA:10 a=s88AYcEWOXMFsoP9cgP2:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gred.

On Fri, Mar 13, 2020 at 09:41:52AM +0100, Gerd Hoffmann wrote:
> Shutdown of firmware framebuffer has a bunch of problems.  Because
> of this the framebuffer region might still be reserved even after
> drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> 
> Don't consider pci_request_region() failure for the framebuffer
> region as fatal error to workaround this issue.
> 
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index 952199cc0462..dce4672e3fc8 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -157,10 +157,8 @@ int bochs_hw_init(struct drm_device *dev)

There is a drm_device avilable.

>  		size = min(size, mem);
>  	}
>  
> -	if (pci_request_region(pdev, 0, "bochs-drm") != 0) {
> -		DRM_ERROR("Cannot request framebuffer\n");
> -		return -EBUSY;
> -	}
> +	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> +		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
So you could use drm_WARN() which is what is preferred these days.
With this fixed:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
