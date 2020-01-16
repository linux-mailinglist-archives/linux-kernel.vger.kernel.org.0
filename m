Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10D213D829
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgAPKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgAPKrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:47:52 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B05E205F4;
        Thu, 16 Jan 2020 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579171671;
        bh=UdGMbdry9FO+CwnA8duoUtdCiqKW74vOro3QldKWGEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y36CublJYdb+gAUpr1THN6gtFzA+rYFet1+/+lybPdjg6sLMXpBBL6D3u6KwwNEyM
         Ty1MZot+GXFlhVjv0StXKTYDaTI0MCSBXpgiY25epD02ZX4JtS46YkvuFR1CDQSq84
         Ev3zkc60gd+jqw8BGBDcuH7pHwVmB8/64mcreyL0=
Date:   Thu, 16 Jan 2020 10:47:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v5 0/3] arm64: Workaround for Cortex-A55 erratum 1530923
Message-ID: <20200116104746.GB14761@willie-the-truck>
References: <20191216115631.17804-1-steven.price@arm.com>
 <20200114164543.GD2579@willie-the-truck>
 <3292551ef07b2c5354d48faedad849ff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3292551ef07b2c5354d48faedad849ff@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 07:28:49AM +0000, Marc Zyngier wrote:
> On 2020-01-14 16:45, Will Deacon wrote:
> > On Mon, Dec 16, 2019 at 11:56:28AM +0000, Steven Price wrote:
> > > Version 5 is a rebasing of version 4 (no changes).
> > > 
> > > This series enables a workaround for Cortex-A55 erratum 1530923. The
> > > erratum potentially allows TLB entries to be allocated as a result
> > > of a
> > > speculative AT instruction. This may happen in the middle of a guest
> > > world switch while the relevant VMSA configuration is in an
> > > inconsistent
> > > state, leading to erroneous content being allocated into TLBs.
> > > 
> > > There are existing workarounds for similar issues, 1165522 is
> > > effectively the same, and 1319367/1319537 is similar but without VHE
> > > support.  Rather than add to the selection of errata, the first patch
> > > renames 1165522 to WORKAROUND_SPECULATIVE_AT which can be reused (in
> > > the
> > > final patch) for 1530923.
> > > 
> > > The workaround for errata 1319367 and 1319537 although similar cannot
> > > use VHE (not available on those CPUs) so cannot share the workaround.
> > > However, to keep some sense of symmetry the workaround is renamed to
> > > SPECULATIVE_AT_NVHE.
> > > 
> > > Changes since v4:
> > >  * Rebased to v5.5-rc1
> > 
> > Looks fine to me. Marc, are you ok with me queueing this via arm64
> > (that's
> > where the existing workarounds came from), or would you prefer to take
> > them
> > via kvm-arm?
> 
> Please go ahead and take it (with my ack) via the arm64 tree.

Will do, thanks!

Will
