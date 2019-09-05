Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85293AA9A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbfIERFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 13:05:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387843AbfIERFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:05:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8748228;
        Thu,  5 Sep 2019 10:05:44 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 868103F718;
        Thu,  5 Sep 2019 10:05:42 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:05:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        will@kernel.org, robin.murphy@arm.com, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, phill@raspberrypi.org,
        m.szyprowski@samsung.com
Subject: Re: [PATCH v3 2/4] arm64: rename variables used to calculate
 ZONE_DMA32's size
Message-ID: <20190905170540.GE31268@arrakis.emea.arm.com>
References: <20190902141043.27210-1-nsaenzjulienne@suse.de>
 <20190902141043.27210-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902141043.27210-3-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:10:40PM +0200, Nicolas Saenz Julienne wrote:
> Let the name indicate that they are used to calculate ZONE_DMA32's size
> as opposed to ZONE_DMA.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
