Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8583111D024
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfLLOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 09:46:38 -0500
Received: from foss.arm.com ([217.140.110.172]:49290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbfLLOqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:46:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33238DA7;
        Thu, 12 Dec 2019 06:46:37 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09C13F6CF;
        Thu, 12 Dec 2019 06:46:35 -0800 (PST)
Date:   Thu, 12 Dec 2019 14:46:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64: Introduce ISAR6 CPU ID register
Message-ID: <20191212144633.GE46910@lakrids.cambridge.arm.com>
References: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:44:23PM +0530, Anshuman Khandual wrote:
> +#define ID_ISAR6_JSCVT_SHIFT		0
> +#define ID_ISAR6_DP_SHIFT		4
> +#define ID_ISAR6_FHM_SHIFT		8
> +#define ID_ISAR6_SB_SHIFT		12
> +#define ID_ISAR6_SPECRES_SHIFT		16
> +#define ID_ISAR6_BF16_SHIFT		20
> +#define ID_ISAR6_I8MM_SHIFT		24

> @@ -399,6 +399,7 @@ static const struct __ftr_reg_entry {
>  	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
>  	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
>  	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),

> +	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_generic_32bits),

Using ftr_generic_32bits exposes the lowest-common-denominator for all
4-bit fields in the register, and I don't think that's the right thing
to do here, because:

* We have no idea what ID_ISAR6 bits [31:28] may mean in future.

* AFAICT, the instructions described by ID_ISAR6.SPECRES (from the
  ARMv8.0-PredInv extension) operate on the local PE and are not
  broadcast. To make those work as a guest expects, the host will need
  to do additional things (e.g. to preserve that illusion when a vCPU is
  migrated from one pCPU to another and back).

Given that, think we should add an explicit ftr_id_isar6 which only
exposes the fields that we're certain are safe to expose to a guest
(i.e. without SPECRES).

Thanks,
Mark.
