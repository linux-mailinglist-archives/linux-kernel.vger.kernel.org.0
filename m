Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD42A337
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfEYGzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 02:55:05 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49325 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 02:55:05 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8CD3120096;
        Sat, 25 May 2019 08:55:03 +0200 (CEST)
Date:   Sat, 25 May 2019 08:55:02 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] drm/panel: simple: Add KOE tx14d24vm1bpa display
 support (320x240)
Message-ID: <20190525065502.GB9586@ravnborg.org>
References: <20180412143715.6828-1-lukma@denx.de>
 <20190515160612.6529-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515160612.6529-1-lukma@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
        a=8OUv0a95HpZqKKHEGkIA:9 a=CjuIK1q_8ugA:10 a=2oGYGDbRtGoA:10
        a=egZzndLFD_8A:10 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 06:06:12PM +0200, Lukasz Majewski wrote:
> This commit adds support for KOE's 5.7" display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, applied.

	Sam
