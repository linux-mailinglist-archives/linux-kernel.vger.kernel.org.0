Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C009064A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfGJPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 11:49:27 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:34144 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfGJPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:49:27 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 02FEB80444;
        Wed, 10 Jul 2019 17:49:17 +0200 (CEST)
Date:   Wed, 10 Jul 2019 17:49:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 0/4] Panel rotation patches
Message-ID: <20190710154916.GA13810@ravnborg.org>
References: <20190710021659.177950-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710021659.177950-1-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=CF2rFHbX0Lz1B-FzuQEA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek.

On Tue, Jul 09, 2019 at 07:16:55PM -0700, Derek Basehore wrote:
> This adds the plumbing for reading panel rotation from the devicetree
> and sets up adding a panel property for the panel orientation on
> Mediatek SoCs when a rotation is present.
> 
> v7 changes:
> -forgot to add static inline
> 
> v6 changes:
> -added enum declaration to drm_panel.h header
> 
> v5 changes:
> -rebased
> 
> v4 changes:
> -fixed some changes made to the i915 driver
> -clarified comments on of orientation helper
> 
> v3 changes:
> -changed from attach/detach callbacks to directly setting fixed panel
>  values in drm_panel_attach
> -removed update to Documentation
> -added separate function for quirked panel orientation property init
> 
> v2 changes:
> fixed build errors in i915
> 
> Derek Basehore (4):
>   drm/panel: Add helper for reading DT rotation
>   drm/panel: set display info in panel attach
>   drm/connector: Split out orientation quirk detection
>   drm/mtk: add panel orientation property

First two patches are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Last two patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
