Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3657EC39DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfJAQFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:05:23 -0400
Received: from foss.arm.com ([217.140.110.172]:53014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfJAQFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:05:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35D91000;
        Tue,  1 Oct 2019 09:05:22 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC543F71A;
        Tue,  1 Oct 2019 09:05:20 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:05:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, f.fainelli@gmail.com, will@kernel.org,
        linux-mm@kvack.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [PATCH v6 0/4] Raspberry Pi 4 DMA addressing support
Message-ID: <20191001160518.GQ41399@arrakis.emea.arm.com>
References: <20190911182546.17094-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911182546.17094-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:25:42PM +0200, Nicolas Saenz Julienne wrote:
> Nicolas Saenz Julienne (4):
>   arm64: mm: use arm64_dma_phys_limit instead of calling
>     max_zone_dma_phys()
>   arm64: rename variables used to calculate ZONE_DMA32's size
>   arm64: use both ZONE_DMA and ZONE_DMA32
>   mm: refresh ZONE_DMA and ZONE_DMA32 comments in 'enum zone_type'

I queued these patches for 5.5 (though they'll appear in -next around
-rc3).

Thanks.

-- 
Catalin
