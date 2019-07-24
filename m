Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2647473050
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfGXNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 09:54:30 -0400
Received: from foss.arm.com ([217.140.110.172]:41360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfGXNy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:54:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5827928;
        Wed, 24 Jul 2019 06:54:29 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2B643F71A;
        Wed, 24 Jul 2019 06:54:27 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:54:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, m.szyprowski@samsung.com,
        hch@lst.de, phil@raspberrypi.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, mbrugger@suse.com,
        Jisheng.Zhang@synaptics.com
Subject: Re: [RFC 2/4] arm64: mm: parse dma-ranges in order to better
 estimate arm64_dma_phys_limit
Message-ID: <20190724135425.GB44864@arrakis.emea.arm.com>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
 <20190717153135.15507-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717153135.15507-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 05:31:33PM +0200, Nicolas Saenz Julienne wrote:
> The dma physical limit has so far been calculated based on the memory
> size and the assumption that dma would be at least able to address the
> first 4 GB. This turned out no to be true with the Raspberry Pi 4
> which, on it's main interconnect, can only address the first GB of
> memory, even though it might have up to 4 GB.
> 
> With the current miscalculated dma physical limit the contiguous memory
> reserve is located in an inaccessible area for most of the board's
> devices.
> 
> To solve this we now scan the device tree for the 'dma-ranges' property
> on the root or interconnect nodes, which allows us to calculate the
> lowest common denominator dma physical limit. If no dma-ranges is
> available, we'll default to the old scheme.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm64/mm/init.c | 61 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 57 insertions(+), 4 deletions(-)

I'd rather have this parsing in the core code, returning setting the
minimum DMA mask (or range, address etc.) that covers all devices/buses
described.

-- 
Catalin
