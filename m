Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF57213A8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 12:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgANL4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 06:56:22 -0500
Received: from foss.arm.com ([217.140.110.172]:51304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:56:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A25AA1435;
        Tue, 14 Jan 2020 03:56:20 -0800 (PST)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3433F6C4;
        Tue, 14 Jan 2020 03:56:18 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:56:14 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v3 2/7] arm64: fpsimd: Make sure SVE setup is complete
 before SIMD is used
Message-ID: <20200114115613.GC2289@mbp>
References: <20200113233023.928028-1-suzuki.poulose@arm.com>
 <20200113233023.928028-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113233023.928028-3-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:30:18PM +0000, Suzuki K Poulose wrote:
> In-kernel users of NEON rely on may_use_simd() to check if the SIMD
> can be used. However, we must initialize the SVE before SIMD can
> be used. Add a sanity check to make sure that we have completed the
> SVE setup before anyone uses the SIMD.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
