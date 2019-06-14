Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F9945CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfFNMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 08:31:11 -0400
Received: from verein.lst.de ([213.95.11.211]:46592 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfFNMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:31:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3289D68AFE; Fri, 14 Jun 2019 14:30:42 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:30:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, akpm@linux-foundation.org,
        alexey.skidanov@intel.com, olof@lixom.net, sjhuang@iluvatar.ai,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] dma-remap: Avoid de-referencing NULL atomic_pool
Message-ID: <20190614123041.GB31052@lst.de>
References: <20190607234333.9776-1-f.fainelli@gmail.com> <20190610225437.10912-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610225437.10912-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next branch.
