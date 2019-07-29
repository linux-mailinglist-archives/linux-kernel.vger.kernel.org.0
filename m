Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE77378C04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfG2MuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 08:50:22 -0400
Received: from foss.arm.com ([217.140.110.172]:43638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfG2MuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:50:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5EA528;
        Mon, 29 Jul 2019 05:50:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C2A43F71F;
        Mon, 29 Jul 2019 05:50:19 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:50:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 10/21] mm: Add generic p?d_leaf() macros
Message-ID: <20190729125013.GA33794@lakrids.cambridge.arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-11-steven.price@arm.com>
 <20190723094113.GA8085@lakrids.cambridge.arm.com>
 <ce4e21f2-020f-6677-d79c-5432e3061d6e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4e21f2-020f-6677-d79c-5432e3061d6e@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 05:14:31PM +0530, Anshuman Khandual wrote:
> On 07/23/2019 03:11 PM, Mark Rutland wrote:
> > It might also be worth pointing out the reasons for this naming, e.g.
> > p?d_large() aren't currently generic, and this name minimizes potential
> > confusion between p?d_{large,huge}().
> 
> Agreed. But these fallback also need to first check non-availability of large
> pages. 

We're deliberately not making the p?d_large() helpers generic, so this
shouldn't fall back on those.

It's up to the architecture to implement these correctly, and the
architecture-specific implementations will be added in subsequent
patches.

Thanks,
Mark.
