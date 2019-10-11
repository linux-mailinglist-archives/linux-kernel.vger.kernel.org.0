Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F7D3D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfJKKjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 06:39:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfJKKjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:39:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4536F28;
        Fri, 11 Oct 2019 03:39:03 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26D63F703;
        Fri, 11 Oct 2019 03:39:00 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:38:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v11 1/4] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20191011103857.GB54842@arrakis.emea.arm.com>
References: <20191009084246.123354-1-justin.he@arm.com>
 <20191009084246.123354-2-justin.he@arm.com>
 <20191010164312.GB40923@arrakis.emea.arm.com>
 <DB7PR08MB3082E71F1FF5FE8462F88B8BF7970@DB7PR08MB3082.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3082E71F1FF5FE8462F88B8BF7970@DB7PR08MB3082.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 01:16:36AM +0000, Justin He (Arm Technology China) wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> > On Wed, Oct 09, 2019 at 04:42:43PM +0800, Jia He wrote:
> > > +		u64 mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
> > > +
> > > +		return !!cpuid_feature_extract_unsigned_field(mmfr1,
> > > +
> > 	ID_AA64MMFR1_HADBS_SHIFT);
> > 
> > No need for !!, the return type is a bool already.
> 
> But cpuid_feature_extract_unsigned_field has the return type "unsigned int" [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/cpufeature.h#n444

And the C language gives you the automatic conversion from unsigned int
to bool without the need for !!. The reason we use !! in some places is
for converting long to int (not bool) and losing the top 32-bit. See
commit 84fe6826c28f ("arm64: mm: Add double logical invert to pte
accessors") for an explanation.

-- 
Catalin
