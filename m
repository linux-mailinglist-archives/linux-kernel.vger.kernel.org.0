Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2213213690
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 02:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEDA1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 20:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfEDA1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:27:38 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D72B2075C;
        Sat,  4 May 2019 00:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556929657;
        bh=khpHJXJyePxHxqjcbb/bixCjMWGObu2ArDNoVY/Nty8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7XkEWV2vjJNbDEsLW0NtVXECUbk5ovIcZzmySxXPPA0c4XhSPF4oJf3uV6mVjE0B
         4Oon05InP3j69i34Z8R8yBxK7L8ShAupRMHHD6eHKfcRmvDxgg7T2/7HFLya7kNIbh
         q4zjPm/bPUmyCoyNHQviV4YwhowaQfLBQWpbsbO0=
Date:   Sat, 4 May 2019 02:27:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        npiggin@gmail.com, fweisbec@gmail.com, peterz@infradead.org,
        torvalds@linux-foundation.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/isolation: Require a present CPU in
 housekeeping mask
Message-ID: <20190504002733.GB19076@lenoir>
References: <20190411033448.20842-5-npiggin@gmail.com>
 <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-9219565aa89033a9cfdae788c1940473a1253d6c@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:47:37AM -0700, tip-bot for Nicholas Piggin wrote:
> Commit-ID:  9219565aa89033a9cfdae788c1940473a1253d6c
> Gitweb:     https://git.kernel.org/tip/9219565aa89033a9cfdae788c1940473a1253d6c
> Author:     Nicholas Piggin <npiggin@gmail.com>
> AuthorDate: Thu, 11 Apr 2019 13:34:47 +1000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri, 3 May 2019 19:42:58 +0200
> 
> sched/isolation: Require a present CPU in housekeeping mask
> 
> During housekeeping mask setup, currently a possible CPU is required.
> That does not guarantee the CPU would be available at boot time, so
> check to ensure that at least one present CPU is in the mask.

I have a doubt about the requirements and semantics of cpu_present_mask.
IIUC a present CPU means that it is physically plugged in (from ACPI
perspective) but might not be logically plugged in (set on cpu_online_mask).

But do we have the guarantee that a present CPU _will_ be online at least once
right after the boot? After all, kernel parameters such as "maxcpus=" can prevent
from turning some CPUs on. I guess there are even more creative ways to achieve
that.

In any case we really require the housekeeper to be forced online. Perhaps
I missed that enforcement somewhere in the patchset?

Thanks.
