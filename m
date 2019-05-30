Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430042F7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfE3HKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:10:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9799 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbfE3HKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:10:33 -0400
X-UUID: 4e95dbfb47c6469ab5ffd272f063cf7b-20190530
X-UUID: 4e95dbfb47c6469ab5ffd272f063cf7b-20190530
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1579835748; Thu, 30 May 2019 15:10:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 30 May 2019 15:10:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 May 2019 15:10:26 +0800
Message-ID: <1559200226.23119.4.camel@mtksdaap41>
Subject: Re: [PATCH v3] gpu/drm: mediatek: call mtk_dsi_stop() after
 mtk_drm_crtc_atomic_disable()
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 30 May 2019 15:10:26 +0800
In-Reply-To: <CAJMQK-ir9J-JN9DDZPBA1nVkJUZ_6A+fY4fA6jx6zOh_9q5a-w@mail.gmail.com>
References: <20190528073908.633-1-hsinyi@chromium.org>
         <1559033586.5141.3.camel@mtksdaap41>
         <CAJMQK-ir9J-JN9DDZPBA1nVkJUZ_6A+fY4fA6jx6zOh_9q5a-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 21091E5AA1B68CD54EA112FEDEABEE38DDE2401439AE716AE08C1FA05B4F42452000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

On Thu, 2019-05-30 at 10:55 +0800, Hsin-Yi Wang wrote:
> On Tue, May 28, 2019 at 4:53 PM CK Hu <ck.hu@mediatek.com> wrote:
> 
> > I think we've already discussed in [1]. I need a reason to understand
> > this is hardware behavior or software bug. If this is a software bug, we
> > need to fix the bug and code could be symmetric.
> >
> > [1]
> > http://lists.infradead.org/pipermail/linux-mediatek/2019-March/018423.html
> >
> Hi CK,
> 
> Jitao has replied in v2[1]
> "
> mtk_dsi_start must after dsi full setting.
> If you put it in mtk_dsi_ddp_start, mtk_dsi_set_mode won't work. DSI
> will keep cmd mode. So you see no irq.
> ...
> "
> 
> [1] https://lore.kernel.org/patchwork/patch/1052505/#1276270
> 
> Thanks

OK, this looks the hardware behavior, so I would like you to add comment
in the code to describe why we need this asymmetric behavior. The
description should be clear so that we could know how to modify the code
flow in future.

Regards,
CK

