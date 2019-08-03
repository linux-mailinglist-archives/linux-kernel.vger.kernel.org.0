Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0A805AD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbfHCKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 06:15:40 -0400
Received: from foss.arm.com ([217.140.110.172]:59946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388371AbfHCKPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 06:15:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A69E344;
        Sat,  3 Aug 2019 03:15:37 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD373F71F;
        Sat,  3 Aug 2019 03:15:36 -0700 (PDT)
Date:   Sat, 3 Aug 2019 11:15:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the arm64-fixes tree
Message-ID: <20190803101533.GA58477@iMac.local>
References: <20190802074813.73b82a14@canb.auug.org.au>
 <20190803094212.3ff4b1ba33c50c63173c8d31@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803094212.3ff4b1ba33c50c63173c8d31@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2019 at 09:42:12AM +0900, Masami Hiramatsu wrote:
> On Fri, 2 Aug 2019 07:48:13 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > In commit
> > 
> >   72de4a283cb1 ("arm64: kprobes: Recover pstate.D in single-step exception handler")
> > 
> > Fixes tag
> > 
> >   Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
> > 
> > has these problem(s):
> > 
> >   - leading word 'commit' unexpected
> 
> Oops, sorry. It was my mistake to add "commit", it should be removed.
> Will, should I remove it? or could you modify on your tree?

No need to. Will fixed it already.

-- 
Catalin
