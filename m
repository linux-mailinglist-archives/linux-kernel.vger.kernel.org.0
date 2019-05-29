Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59B02D600
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE2HMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 03:12:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10586 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbfE2HMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:12:51 -0400
X-UUID: 73955fc45ed844b99226497a96ed2407-20190529
X-UUID: 73955fc45ed844b99226497a96ed2407-20190529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1270081599; Wed, 29 May 2019 15:12:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 15:12:35 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 15:12:35 +0800
Message-ID: <1559113955.4226.1.camel@mtksdaap41>
Subject: Re: [PATCH 2/3] drm: mediatek: remove clk_unprepare() in
 mtk_drm_crtc_destroy()
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 29 May 2019 15:12:35 +0800
In-Reply-To: <CAJMQK-gQ_j4ma_EjGbFJOz6WGXy3UZA0F9JZYnFHPZ0F08rXog@mail.gmail.com>
References: <20190527045054.113259-1-hsinyi@chromium.org>
         <20190527045054.113259-3-hsinyi@chromium.org>
         <1559109490.15592.6.camel@mtksdaap41>
         <CAJMQK-gQ_j4ma_EjGbFJOz6WGXy3UZA0F9JZYnFHPZ0F08rXog@mail.gmail.com>
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

On Wed, 2019-05-29 at 14:08 +0800, Hsin-Yi Wang wrote:
> On Wed, May 29, 2019 at 1:58 PM CK Hu <ck.hu@mediatek.com> wrote:
> >
> > Hi, Hsin-Yi:
> >
> > On Mon, 2019-05-27 at 12:50 +0800, Hsin-Yi Wang wrote:
> > > There is no clk_prepare() called in mtk_drm_crtc_reset(), when unbinding
> > > drm device, mtk_drm_crtc_destroy() will be triggered, and the clocks will
> > > be disabled and unprepared in mtk_crtc_ddp_clk_disable. If clk_unprepare()
> > > is called here, we'll get warnings[1], so remove clk_unprepare() here.
> >
> > In original code, clk_prepare() is called in mtk_drm_crtc_create() and
> > clk_unprepare() is called in mtk_drm_crtc_destroy(). This looks correct.
> 
> clk_prepare() is removed in https://patchwork.kernel.org/patch/10872777/.
> 

I think this patch is a fix of that patch, and I've already applied that
patch, so I merge this patch with that patch in my tree [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commit/937f861def1a1d49abb92e041efaa5c259281fbf

Regards,
CK

> > I don't know why we should do any thing about clock in
> > mtk_drm_crtc_reset(). To debug this, the first step is to print message
> > when mediatek drm call clk_prepare() and clk_unprepare(). If these two
> > interface is called in pair, I think we should not modify mediatek drm
> > driver, the bug maybe in clock driver.
> >


