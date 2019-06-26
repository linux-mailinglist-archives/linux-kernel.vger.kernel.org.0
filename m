Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4F567A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfFZLdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 07:33:13 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:46876 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfFZLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:33:12 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 7EC2380349;
        Wed, 26 Jun 2019 13:33:08 +0200 (CEST)
Date:   Wed, 26 Jun 2019 13:33:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v5 2/2] drm/panel: Add support for Raydium RM67191 panel
 driver
Message-ID: <20190626113306.GA24921@ravnborg.org>
References: <1561544420-15572-1-git-send-email-robert.chiras@nxp.com>
 <1561544420-15572-3-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561544420-15572-3-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10
        a=R-vzCapntemROrW6nt8A:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert.

On Wed, Jun 26, 2019 at 01:20:20PM +0300, Robert Chiras wrote:
> This patch adds Raydium RM67191 TFT LCD panel driver (MIPI-DSI
> protocol).

I was about to apply these - but I get following warnings during build:
  CC      drivers/gpu/drm/panel/panel-raydium-rm67191.o
/home/sam/drm/linux.git/drivers/gpu/drm/panel/panel-raydium-rm67191.c: In function ‘rad_bl_get_brightness’:
/home/sam/drm/linux.git/drivers/gpu/drm/panel/panel-raydium-rm67191.c:470:17: warning: unused variable ‘dev’ [-Wunused-variable]
  struct device *dev = &dsi->dev;
                 ^~~
/home/sam/drm/linux.git/drivers/gpu/drm/panel/panel-raydium-rm67191.c: In function ‘rad_bl_update_status’:
/home/sam/drm/linux.git/drivers/gpu/drm/panel/panel-raydium-rm67191.c:492:17: warning: unused variable ‘dev’ [-Wunused-variable]
  struct device *dev = &dsi->dev;
                 ^~~

Please fix and update your scripts to catch this in the future.

	Sam
