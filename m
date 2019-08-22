Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAB9889D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 02:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfHVAnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 20:43:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727038AbfHVAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:43:50 -0400
X-UUID: 004f331c6dbb432bb98f59b3621e7916-20190822
X-UUID: 004f331c6dbb432bb98f59b3621e7916-20190822
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 951907247; Thu, 22 Aug 2019 08:43:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 08:43:43 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 08:43:33 +0800
Message-ID: <1566434617.14794.0.camel@mtkswgap22>
Subject: Re: [PATCH 04/11] pinctrl: mediatek: update pinmux defintions for
 mt6779
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>
Date:   Thu, 22 Aug 2019 08:43:37 +0800
In-Reply-To: <20190821185025.GA18525@bogus>
References: <1564996320-10897-1-git-send-email-mars.cheng@mediatek.com>
         <1564996320-10897-5-git-send-email-mars.cheng@mediatek.com>
         <20190821185025.GA18525@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 13:50 -0500, Rob Herring wrote:
> On Mon, Aug 05, 2019 at 05:11:53PM +0800, Mars Cheng wrote:
> > Add devicetree bindings for Mediatek mt6779 SoC Pin Controller.
> 
> checkpatch.pl reports typo in subject.
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

got it, will fix the typo in v3. Thanks for reviewing.

> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> > ---
> >  include/dt-bindings/pinctrl/mt6779-pinfunc.h | 1242 ++++++++++++++++++++++++++
> >  1 file changed, 1242 insertions(+)
> >  create mode 100644 include/dt-bindings/pinctrl/mt6779-pinfunc.h


