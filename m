Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86765BDCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbfIYLF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 07:05:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbfIYLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:05:27 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46dZwP4hpLz9sPl; Wed, 25 Sep 2019 21:05:25 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1211ee61b4a8e60d6dc77211cdcf01906915bfba
In-Reply-To: <20190920130523.20441-2-ldufour@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3 1/2] powperc/mm: read TLB Block Invalidate Characteristics
Message-Id: <46dZwP4hpLz9sPl@ozlabs.org>
Date:   Wed, 25 Sep 2019 21:05:25 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-20 at 13:05:22 UTC, Laurent Dufour wrote:
> The PAPR document specifies the TLB Block Invalidate Characteristics which
> tells for each pair of segment base page size, actual page size, the size
> of the block the hcall H_BLOCK_REMOVE supports.
> 
> These characteristics are loaded at boot time in a new table hblkr_size.
> The table is separate from the mmu_psize_def because this is specific to
> the pseries platform.
> 
> A new init function, pseries_lpar_read_hblkrm_characteristics() is added to
> read the characteristics. It is called from pSeries_setup_arch().
> 
> Fixes: ba2dd8a26baa ("powerpc/pseries/mm: call H_BLOCK_REMOVE")
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1211ee61b4a8e60d6dc77211cdcf01906915bfba

cheers
