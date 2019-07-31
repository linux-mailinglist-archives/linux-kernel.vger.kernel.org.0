Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB307C83B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfGaQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfGaQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:10:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDEF5206A3;
        Wed, 31 Jul 2019 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564589453;
        bh=WCCv3Aec470dqenJ3D0yJXfNnDANp7cVqdAtXPLEgsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0oO6ADuBpn0GsCzed/V3vKsIofX8heKLLg1altER77SX8nvqgWsXXTEM1v+taPPH
         EIwclnx482U7aJLNBxzEszh8K/nBVMDE9WWJ3rSKcTQBSk8H0adilY4q0TaGfAK9h8
         GAMdp9Q3T2fvoMqUn4p9KL2EwGx5PxfqoHpuEndc=
Date:   Wed, 31 Jul 2019 17:10:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/2] mm/sparsemem: Add vmem_altmap support in
 vmemmap_populate_basepages()
Message-ID: <20190731161047.ypye54x5c5jje5sq@willie-the-truck>
References: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
 <1561697083-7329-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561697083-7329-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:14:42AM +0530, Anshuman Khandual wrote:
> Generic vmemmap_populate_basepages() is used across platforms for vmemmap
> as standard or as fallback when huge pages mapping fails. On arm64 it is
> used for configs with ARM64_SWAPPER_USES_SECTION_MAPS applicable both for
> ARM64_16K_PAGES and ARM64_64K_PAGES which cannot use huge pages because of
> alignment requirements.
> 
> This prevents those configs from allocating from device memory for vmemap
> mapping as vmemmap_populate_basepages() does not support vmem_altmap. This
> enables that required support. Each architecture should evaluate and decide
> on enabling device based base page allocation when appropriate. Hence this
> keeps it disabled for all architectures to preserve the existing semantics.

This commit message doesn't really make sense to me. There's a huge amount
of arm64-specific detail, followed by vague references to "this" and
"those" and "that" and I lost track of what you're trying to solve.

However, I puzzled through the code and I think it does make sense, so:

Acked-by: Will Deacon <will@kernel.org>

assuming you rewrite the commit message.

However, this has a dependency on your hot remove series which has open
comments from Mark Rutland afaict.

Will
