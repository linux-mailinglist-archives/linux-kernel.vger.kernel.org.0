Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 306E813D090
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 00:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgAOXLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 18:11:03 -0500
Received: from mailoutvs55.siol.net ([185.57.226.246]:57398 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729394AbgAOXLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 18:11:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 7ECF95229C0;
        Thu, 16 Jan 2020 00:10:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G8KZ7vYm0PJ9; Thu, 16 Jan 2020 00:10:59 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 2E8355229D0;
        Thu, 16 Jan 2020 00:10:59 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id C0A525229C0;
        Thu, 16 Jan 2020 00:10:58 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
Date:   Thu, 16 Jan 2020 00:10:58 +0100
Message-ID: <4200557.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <CAL_JsqK-KBd9PF7nKK976vVYjRwfm-ZxJSnEbhiWC=X3AnvpeA@mail.gmail.com>
References: <20200115194216.173117-1-jernej.skrabec@siol.net> <20200115194216.173117-2-jernej.skrabec@siol.net> <CAL_JsqK-KBd9PF7nKK976vVYjRwfm-ZxJSnEbhiWC=X3AnvpeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sreda, 15. januar 2020 ob 22:57:31 CET je Rob Herring napisal(a):
> On Wed, Jan 15, 2020 at 1:42 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > OrangePi 3 can optionally have eMMC. Add a compatible for it.
> 
> Is this just a population option or a different board layout? If the
> former, I don't think you need a new compatible, just add/enable a
> node for the eMMC.

I have only board with eMMC but I imagine it's the former. Even so, current 
approach with Allwinner boards is to have two different board DT files, one for 
each variant. This can be seen from Documentation/devicetree/bindings/arm/
sunxi.yaml which has a lot of compatibles ending with "-emmc". I guess reason 
for that is to avoid having MMC controller being powered on for no reason.

Best regards,
Jernej




