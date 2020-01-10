Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B2136C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 12:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgAJLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 06:51:37 -0500
Received: from foss.arm.com ([217.140.110.172]:42992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgAJLvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:51:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F0301063;
        Fri, 10 Jan 2020 03:51:36 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F4573F534;
        Fri, 10 Jan 2020 03:51:34 -0800 (PST)
Date:   Fri, 10 Jan 2020 11:51:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        dave.martin@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/7] arm64: fpsimd: Make sure SVE setup is complete
 before SIMD is used
Message-ID: <20200110115132.GA8786@arrakis.emea.arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217183402.2259904-3-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:33:57PM +0000, Suzuki K Poulose wrote:
> In-kernel users of NEON rely on may_use_simd() to check if the SIMD
> can be used. However, we must initialize the SVE before SIMD can
> be used. Add a sanity check to make sure that we have completed the
> SVE setup before anyone uses the SIMD.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Discussion here : https://lkml.kernel.org/r/20191014145204.GS27757@arm.com

Re-reading this thread, I think the conclusion was more towards having a
WARN_ON in system_supports_fpsimd() (or may_use_simd()). We don't expect
code to start using neon before the SMP is initialised (other than
early_initcall(), the rest run after the secondary CPUs are brought up).

-- 
Catalin
