Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A275EF2F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfKGNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:23:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47611 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730980AbfKGNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:23:28 -0500
X-UUID: 28b3cb1bd4964f4eae1273d818736ca6-20191107
X-UUID: 28b3cb1bd4964f4eae1273d818736ca6-20191107
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1384943116; Thu, 07 Nov 2019 21:23:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 7 Nov 2019 21:23:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Nov 2019 21:23:16 +0800
Message-ID: <1573132996.8833.3.camel@mtksdaap41>
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped
 flash reading
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Chuanhong Guo <gch981213@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 7 Nov 2019 21:23:16 +0800
In-Reply-To: <20191106140748.13100-2-gch981213@gmail.com>
References: <20191106140748.13100-1-gch981213@gmail.com>
         <20191106140748.13100-2-gch981213@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 22:07 +0800, Chuanhong Guo wrote:
> PIO reading mode on this controller is ridiculously inefficient
> (one cmd+addr+dummy sequence reads only one byte)
> This patch adds support for reading from memory-mapped flash area
> which increases reading speed from 1MB/s to 5.6MB/s

This may not be true for all MTK SoC. Which one are you testing?

Joe.C




