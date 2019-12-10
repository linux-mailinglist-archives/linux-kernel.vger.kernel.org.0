Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09E119A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 22:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfLJVwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 16:52:16 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38278 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbfLJVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:52:10 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 65324DBF;
        Tue, 10 Dec 2019 22:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1576014727;
        bh=Ih8EqcfA4nD8hACm8d/yLl08r2Db3KdImZJ3njZhk8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+CNvBHvYgFhT/I85xrhtTzkQLHns7WVHJpYg3UMd4sJbpHR6Qd23yypDPmqv0757
         GVaIZwYM2MzQ5Shu5N/q/keQ5SHPHq86mwcwACrbDvIG4VRowIPbQuRgVes+Pi+7UZ
         CvHmfF8nUh6qaN5KnXOf/GZJLZ1wiHpMqXg4W3o0=
Date:   Tue, 10 Dec 2019 23:51:58 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v5 2/4] Revert "drm/tegra: Move drm_dp_link helpers to
 Tegra DRM"
Message-ID: <20191210215158.GA13051@pendragon.ideasonboard.com>
References: <1575957299-12977-1-git-send-email-allen.chen@ite.com.tw>
 <1575957299-12977-3-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1575957299-12977-3-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Allen,

Thank you for the patch.

On Tue, Dec 10, 2019 at 01:53:40PM +0800, allen wrote:
> This reverts commit 9a42c7c647a9ad0f7ebb147a52eda3dcb7c84292.

Why ?

> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 128 ++++++
>  drivers/gpu/drm/tegra/Makefile  |   1 -
>  drivers/gpu/drm/tegra/dp.c      | 876 ----------------------------------------
>  drivers/gpu/drm/tegra/dp.h      | 177 --------
>  drivers/gpu/drm/tegra/dpaux.c   |   1 -
>  drivers/gpu/drm/tegra/sor.c     |   1 -
>  include/drm/drm_dp_helper.h     |  16 +
>  7 files changed, 144 insertions(+), 1056 deletions(-)
>  delete mode 100644 drivers/gpu/drm/tegra/dp.c
>  delete mode 100644 drivers/gpu/drm/tegra/dp.h

[snip]

-- 
Regards,

Laurent Pinchart
