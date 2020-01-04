Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C3130363
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgADPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 10:49:35 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40398 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgADPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:49:35 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CA39D8060A;
        Sat,  4 Jan 2020 16:49:32 +0100 (CET)
Date:   Sat, 4 Jan 2020 16:49:31 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, maxime@cerno.tech,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 3/3] drm/panel: add panel driver for Leadtek
 LTK500HD1829
Message-ID: <20200104154931.GH17768@ravnborg.org>
References: <20191224112641.30647-1-heiko@sntech.de>
 <20191224112641.30647-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224112641.30647-3-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=NXpJzYs8AAAA:8
        a=BbrnQlLR1J-O-DZvGPAA:9 a=CjuIK1q_8ugA:10 a=cwV61pgf2j4Cq8VD9hE_:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 12:26:41PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The LTK500HD1829 is 5.5" DSI display.
> 
> changes in v4:
> - drop error message if backlight not found, no other panel
>   does that and if needed it should live in drm_panel_of_backlight
> changes in v3:
> - drop one more overlooked panel->drm access
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Applied to drm-misc-next.
Updated to fix a few trivial checkpatch warnings when I applied.

	Sam
