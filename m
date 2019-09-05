Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197BDAA9E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 19:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbfIERVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 13:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:47924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389544AbfIERVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7537A337;
        Thu,  5 Sep 2019 10:21:32 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EFA83F718;
        Thu,  5 Sep 2019 10:21:30 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:21:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, f.fainelli@gmail.com,
        will@kernel.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 4/4] mm: refresh ZONE_DMA and ZONE_DMA32 comments in
 'enum zone_type'
Message-ID: <20190905172126.GG31268@arrakis.emea.arm.com>
References: <20190902141043.27210-1-nsaenzjulienne@suse.de>
 <20190902141043.27210-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902141043.27210-5-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:10:42PM +0200, Nicolas Saenz Julienne wrote:
> These zones usage has evolved with time and the comments were outdated.
> This joins both ZONE_DMA and ZONE_DMA32 explanation and gives up to date
> examples on how they are used on different architectures.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
