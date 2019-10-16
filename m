Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA8D9513
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392860AbfJPPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:08:51 -0400
Received: from foss.arm.com ([217.140.110.172]:42788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfJPPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:08:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F07C1570;
        Wed, 16 Oct 2019 08:08:50 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C6F13F68E;
        Wed, 16 Oct 2019 08:08:49 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:08:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] arm64: mm: Fix unused variable warning in
 zone_sizes_init
Message-ID: <20191016150846.GO49619@arrakis.emea.arm.com>
References: <20191016031107.30045-1-natechancellor@gmail.com>
 <20191016144713.23792-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016144713.23792-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 07:47:14AM -0700, Nathan Chancellor wrote:
> When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> get disabled so there is a warning about max_dma being unused.
> 
> ../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
> [-Wunused-variable]
>         unsigned long max_dma = min;
>                       ^
> 1 warning generated.
> 
> Add __maybe_unused to make this clear to the compiler.
> 
> Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks. Queued on top of Nicolas' patches for 5.5. I also added Nicolas'
reviewed-by from v2 as I suspect it still stands.

-- 
Catalin
