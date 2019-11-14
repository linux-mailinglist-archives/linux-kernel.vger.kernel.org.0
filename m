Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289ABFCADF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 17:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfKNQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 11:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKNQjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:39:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5897206DB;
        Thu, 14 Nov 2019 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573749594;
        bh=PTKkYOF538f1BfiJH54rPCCMJM9wzIDTNfQcUOB9nNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWTFt5Rq2pveMB+L+QaMgeH7P0sOa0jN+pG8Sex7+EBw0TCWC/nLN039QkzIyPn9v
         2RVcmksBs7o0gsK52BDP5B3cFFqcVNOq2zwCpb01eo4jIZ0oysPLtiYvTlX80Oo70g
         e6EadHc1yFckWb5SJH+lyuf2CqICuueq555dKpD8=
Date:   Thu, 14 Nov 2019 16:39:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        maz@kernel.org
Subject: Re: [PATCH 0/5] arm64: Add workaround for Cortex-A77 erratum 1542418
Message-ID: <20191114163948.GA5158@willie-the-truck>
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114145918.235339-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Nov 14, 2019 at 02:59:13PM +0000, Suzuki K Poulose wrote:
> This series adds workaround for Arm erratum 1542418 which affects

Searching for that erratum number doesn't find me a description :(

> Cortex-A77 cores (r0p0 - r1p0). Affected cores may execute stale
> instructions from the L0 macro-op cache violating the
> prefetch-speculation-protection guaranteed by the architecture.
> This happens when the when the branch predictor bases its predictions
> on a branch at this address on the stale history due to ASID or VMID
> reuse.

Two immediate questions:

 1. Can we disable the L0 MOP cache?
 2. Can we invalidate the branch predictor? If Spectre-v2 taught us
    anything it's that removing those instructions was a mistake!

Moving on...

Have you reproduced this at top-level? If I recall the
prefetch-speculation-protection, it's designed to protect against the
case where you have a direct branch:

addr:	B	foo

and another CPU writes out a new function:

bar:
	insn0
	...
	insnN

before doing any necessary maintenance and then patches the original
branch to:

addr:	B	bar

The idea is that a concurrently executing CPU could mispredict the original
branch to point at 'bar', fetch the instructions before they've been written
out and then confirm the prediction by looking at the newly written branch
instruction. Even without the prefetch-speculation-protection, that's
fairly difficult to achieve in practice: you'd need to be doing something
like reusing memory to hold the instructions so that the initial
misprediction occurs.

How does A77 stop this from occurring when the ASID is not reallocated (e.g.
the example above)? Is the MOP cache flushed somehow?

With this erratum, it sounds like you have to end up reusing an ASID from
a task that had a branch at 'addr' in its address space that branched to
the address of 'bar' (again. in its address space). Is that right? That
sounds super rare to me, particularly with ASLR: not only does the aliasing
branch need to exist, but it needs to be held in the branch predictor while
we cycle through 64k ASIDs *and* the race with the writer needs to happen
so that we get stale instructions from the MOP cache.

Is there something I'm missing that makes this remotely plausible?

Will
