Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285EDD93F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394112AbfJPOc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 10:32:58 -0400
Received: from foss.arm.com ([217.140.110.172]:41494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392232AbfJPOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:32:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2492D142F;
        Wed, 16 Oct 2019 07:32:57 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5453F68E;
        Wed, 16 Oct 2019 07:32:54 -0700 (PDT)
Date:   Wed, 16 Oct 2019 15:32:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v12 0/4] fix double page fault in cow_user_page for pfn
 mapping
Message-ID: <20191016143252.GJ49619@arrakis.emea.arm.com>
References: <20191011140939.6115-1-justin.he@arm.com>
 <20191015001834.wwkd46t6dwicta7n@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015001834.wwkd46t6dwicta7n@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:18:34AM +0100, Will Deacon wrote:
> On Fri, Oct 11, 2019 at 10:09:35PM +0800, Jia He wrote:
> > When we tested pmdk unit test vmmalloc_fork TEST1 in arm64 guest, there
> > will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> > 
> > As told by Catalin: "On arm64 without hardware Access Flag, copying from
> > user will fail because the pte is old and cannot be marked young. So we
> > always end up with zeroed page after fork() + CoW for pfn mappings. we
> > don't always have a hardware-managed access flag on arm64."
> > 
> > -Changes
> > v12:
> >     refine PATCH 01, remove the !! since C languages can convert unsigned
> >     to bool (Catalin)
> 
> Thanks. I think it's a bit late to take something like this for 5.4 now,
> especially as the current behaviour has always been there. Hopefully
> somebody can queue it for 5.5 instead.

I can queue this through the arm64 tree for 5.5 if I get an ack on the
x86 patch (3/4) or I don't hear any complaints.

-- 
Catalin
