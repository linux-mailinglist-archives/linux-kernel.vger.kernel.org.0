Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF06A8ED32
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbfHONo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 09:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732183AbfHONo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:44:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D6F2206C1;
        Thu, 15 Aug 2019 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565876696;
        bh=xHL7U8LXby2GE5m/PlxhS+xac8sl0iPOcUeQV/Pjz8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PC8WAXp92zjaBty293YVJecMMUweIDE44Ugt7uH6Ok00/bCvU/kaX/egbrfVo8Y2G
         TqmCpDRcVrh9mwsSxAK7qiKnJos1VQeqo+G79BDcXQvLGfRXaM51eImoxPckfn/E28
         ayIZtg3YeTpUm6x8H+7AC3z8TQ5SScTNPBO6leqc=
Date:   Thu, 15 Aug 2019 15:44:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 5/8] clk: mediatek: Add MT6765 clock support
Message-ID: <20190815134453.GB3372@kroah.com>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
 <1562924653-10056-6-git-send-email-macpaul.lin@mediatek.com>
 <20190815002721.A71C72083B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815002721.A71C72083B@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:27:20PM -0700, Stephen Boyd wrote:
> Quoting Macpaul Lin (2019-07-12 02:43:41)
> > diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
> > new file mode 100644
> > index 000000000000..41f19343dfb9
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt6765-audio.c
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: Owen Chen <owen.chen@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> Please use SPDX tags.

To be specific, _only_ the SPDX tag.  There is an SPDX tag on this file,
and the others, it's just that the license text is no longer needed with
that.

thanks,

greg k-h
