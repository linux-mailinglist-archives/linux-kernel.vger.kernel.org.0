Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6FB6878
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfIRQtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 12:49:31 -0400
Received: from foss.arm.com ([217.140.110.172]:45132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfIRQtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:49:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0961337;
        Wed, 18 Sep 2019 09:49:30 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0AAA3F59C;
        Wed, 18 Sep 2019 09:49:27 -0700 (PDT)
Date:   Wed, 18 Sep 2019 17:49:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v4 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20190918164925.GB41588@arrakis.emea.arm.com>
References: <20190918131914.38081-1-justin.he@arm.com>
 <20190918131914.38081-2-justin.he@arm.com>
 <20190918142017.GC9880@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918142017.GC9880@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:20:17AM -0700, Matthew Wilcox wrote:
> On Wed, Sep 18, 2019 at 09:19:12PM +0800, Jia He wrote:
> > +/* Decouple AF from AFDBM. */
> > +bool cpu_has_hw_af(void)
> > +{
> > +	return (read_cpuid(ID_AA64MMFR1_EL1) & 0xf);
> > +}
> > +
> 
> Do you really want to call read_cpuid() every time?  I would have thought
> you'd want to use the static branch mechanism to do the right thing at
> boot time.  See Documentation/static-keys.txt.

We do have a static branch mechanism for other CPU features but mostly
because on some big.LITTLE systems, the CPUs may differ slightly so we
only advertise the common features.

I guess here the additional instructions for reading and checking the
CPUID here would be lost in the noise compared to the actual page
copying.

-- 
Catalin
