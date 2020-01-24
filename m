Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15DE148ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgAXOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:55:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:48066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387597AbgAXOz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:55:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68062AD5C;
        Fri, 24 Jan 2020 14:55:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <86672a12-6b88-dba8-0945-b6321ccf28c3@ti.com>
Date:   Fri, 24 Jan 2020 15:47:19 +0100
Subject: Re: [PATCH for-next] arm64: defconfig: Set bcm2835-dma as built-in
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     <f.fainelli@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Message-Id: <C043QOCZ7SMB.2XXX2ESS1ZJ98@linux-9qgx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri Jan 24, 2020 at 2:05 PM, Peter Ujfalusi wrote:
> On 24/01/2020 13.51, Nicolas Saenz Julienne wrote:
> > Hi Peter,
> >=20
> > On Fri Jan 24, 2020 at 1:31 PM, Peter Ujfalusi wrote:
> >> Hi Nicolas,
> >>
> >> On 24/01/2020 13.17, Nicolas Saenz Julienne wrote:
> >>> With the introduction of 738987a1d6f1 ("mmc: bcm2835: Use
> >>> dma_request_chan() instead dma_request_slave_channel()") sdhost-bcm28=
35
> >>> now waits for its DMA channel to be available when defined in the
> >>> device-tree (it would previously default to PIO). Albeit the right
> >>> behaviour, the MMC host is needed for booting. So this makes sure the
> >>> DMA channel shows up in time.
> >>>
> >>> Fixes: 738987a1d6f1 ("mmc: bcm2835: Use dma_request_chan() instead dm=
a_request_slave_channel()")
> >>
> >> it is not a bug, it is a feature ;)
> >=20
> > Agree, I'm just afraid of your series being picked up by a stable
> > release without this patch. But maybe it's not necessary?
>
> If you need MMC rootfs then the DMA needs to be built in or have initrd
> with the modules.
> The driver expects to have DMA channel and it is going to wait for it to
> appear unless the request fails.
>
> Without moving the DMA as built in and removing the deferred probe
> handling form the MMC driver, one can just remove the DMA support from
> the mmc-bcm2835 as it is not used at all.

Oh sorry, I meant to ask if the 'Fixes:' tag was really needed. The
patch itself is very much needed since not everyone uses initrds in the
RPi world, and we want to keep being compatible as much as possible with
older device-trees.

> I wonder why this is not signaled by automated boot testing, if any
> exists for bcm2835.

Actually now that you mention it, it's failing since today here:
https://kernelci.org/boot/bcm2837-rpi-3-b/

Regards,
Nicolas
