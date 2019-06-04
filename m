Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC453488A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFDNWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:22:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43696 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFDNWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:22:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06C8A78;
        Tue,  4 Jun 2019 06:22:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4F03F690;
        Tue,  4 Jun 2019 06:22:02 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:21:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] arm64: mm: make CONFIG_ZONE_DMA32 configurable
Message-ID: <20190604132159.GD6610@arrakis.emea.arm.com>
References: <1559059700-19078-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559059700-19078-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:08:20AM +0800, Miles Chen wrote:
> This change makes CONFIG_ZONE_DMA32 defuly y and allows users
> to overwrite it only when CONFIG_EXPERT=y.
> 
> For the SoCs that do not need CONFIG_ZONE_DMA32, this is the
> first step to manage all available memory by a single
> zone(normal zone) to reduce the overhead of multiple zones.
> 
> The change also fixes a build error when CONFIG_NUMA=y and
> CONFIG_ZONE_DMA32=n.
> 
> arch/arm64/mm/init.c:195:17: error: use of undeclared identifier 'ZONE_DMA32'
>                 max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
> 
> Change since v1:
> 1. only expose CONFIG_ZONE_DMA32 when CONFIG_EXPERT=y
> 2. remove redundant IS_ENABLED(CONFIG_ZONE_DMA32)
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Queued for 5.3. Thanks.

-- 
Catalin
