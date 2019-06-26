Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9005688C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 14:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfFZMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 08:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:21:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F0E20663;
        Wed, 26 Jun 2019 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561551701;
        bh=bzzuAsJFpALlF09800RIXkmFifwZs/0LsYp0Xdjf7lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG5wNuPmjrSNBSjDiSSCgTZlz/8TXSmjSfBQaTeh2HpKuAucc31EfN0oweUcEWWTz
         UaVUE0sG5oMoB6F/Q9kYiwXqsgOhR5khCwluVydKxhPDnfDZ8gt0iSrFYKL9djGBt9
         HPnxRmX9CVEVhrUeI27SI6mVupT9IPj5JYfKqL2E=
Date:   Wed, 26 Jun 2019 13:21:35 +0100
From:   Will Deacon <will@kernel.org>
To:     jinho lim <jordan.lim@samsung.com>, catalin.marinas@arm.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, marc.zyngier@arm.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        seroto7@gmail.com, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: rename dump_instr as dump_kernel_instr
Message-ID: <20190626122134.fg7s6di5o3d3gim4@willie-the-truck>
References: <CGME20190626115016epcas1p455530417de86ea2e72ce1b389ae57a75@epcas1p4.samsung.com>
 <20190626115013.13044-1-jordan.lim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626115013.13044-1-jordan.lim@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:50:13PM +0900, jinho lim wrote:
> In traps.c, only __die calls dump_instr.
> However, this function has sub-function as __dump_instr.
> 
> dump_kernel_instr can replace those functions.
> By using aarch64_insn_read, it does not have to change fs to KERNEL_DS.
> 
> Signed-off-by: jinho lim <jordan.lim@samsung.com>
> ---
>  arch/arm64/kernel/traps.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)

Thanks, this looks good to me now:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this up for 5.3.

Will
