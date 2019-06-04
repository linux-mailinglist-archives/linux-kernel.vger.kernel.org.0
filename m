Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6815433CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfFDBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 21:33:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58632 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726033AbfFDBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 21:33:28 -0400
X-UUID: 6d75eacfb1d0483e842d953bff80b1a9-20190604
X-UUID: 6d75eacfb1d0483e842d953bff80b1a9-20190604
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1791249730; Tue, 04 Jun 2019 09:33:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Jun 2019 09:33:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Jun 2019 09:33:22 +0800
Message-ID: <1559612002.2749.2.camel@mtksdaap41>
Subject: Re: [PATCH v2 0/4] fix mediatek drm, dis, and disp-* unbind/bind
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 4 Jun 2019 09:33:22 +0800
In-Reply-To: <20190529102555.251579-1-hsinyi@chromium.org>
References: <20190529102555.251579-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

On Wed, 2019-05-29 at 18:25 +0800, Hsin-Yi Wang wrote:
> There are some errors when unbinding and rebinding mediatek drm, dsi,
> and disp-* drivers. This series is to fix those errors and warnings.
> 
> Hsin-Yi Wang (4):
>   drm: mediatek: fix unbind functions
>   drm: mediatek: unbind components in mtk_drm_unbind()
>   drm: mediatek: call drm_atomic_helper_shutdown() when unbinding driver
>   drm: mediatek: clear num_pipes when unbind driver

For this series with some title modification, applied to
mediatek-drm-fixes-5.2 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.2

Regards,
CK

> 
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 +++-----
>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 2 ++
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 


