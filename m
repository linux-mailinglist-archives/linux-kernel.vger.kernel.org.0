Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF276375
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfGZKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 06:25:34 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:53254 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:25:34 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id DFB19803B3;
        Fri, 26 Jul 2019 12:25:30 +0200 (CEST)
Date:   Fri, 26 Jul 2019 12:25:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/panel: jh057n00900: Move dsi init sequence to
 prepare
Message-ID: <20190726102529.GB15658@ravnborg.org>
References: <cover.1564132646.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1564132646.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8
        a=6BhD04cj4S09DCeAZc4A:9 a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Fri, Jul 26, 2019 at 11:21:40AM +0200, Guido G�nther wrote:
> If the panel is wrapped in a panel_bridge it gets prepar()ed before the
> upstream DSI bridge which can cause hangs (e.g. with imx-nwl since clocks
> are not enabled yet). To avoid this move the panel's first DSI access to
> enable() so the upstream bridge can prepare the DSI host controller in
> it's pre_enable().
> 
> The second patch makes the disable() call symmetric to the above and the third
> one just eases debugging.
> 
> Guido G�nther (3):
>   drm/panel: jh057n00900: Move panel DSI init to enable()
>   drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
>   drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s

Patch 1 + 3 are both:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

See comment on patch 2.

While you are touching this driver can you make an extra patch?

Today the driver calls the internal prepare,enable,disable,unprepare
functions.
The right way to do it is to use the
drm_panel_(prepare,enable,disable,unprepare) variants.

The benefit is that we can move a little logic to these functions
and the drivers will then benefit from this.

Two things I have in my local queue:
- Move bool for prepared/enabled
  (to protect that we do not prepare/enable twice)
- backlight support

This driver will benefit form both and this little modification will
make it simpler to introduce.
I can also prepare the patch if you prefer.

	Sam
