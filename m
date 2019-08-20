Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFD95B16
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfHTJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 05:37:13 -0400
Received: from foss.arm.com ([217.140.110.172]:37356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbfHTJhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:37:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAEAA344;
        Tue, 20 Aug 2019 02:37:12 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2F13F706;
        Tue, 20 Aug 2019 02:37:11 -0700 (PDT)
Date:   Tue, 20 Aug 2019 10:37:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [GIT PULL] arm64: Second round of fixes for -rc2
Message-ID: <20190820093709.GD14085@fuggles.cambridge.arm.com>
References: <20190524174357.GC9120@fuggles.cambridge.arm.com>
 <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:14:02AM -0700, Linus Torvalds wrote:
> Only tangentially relevant to this pull request:
> 
> On Fri, May 24, 2019 at 10:44 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > - Add workaround for Cortex-A76 CPU erratum #1463225
> > - Handle Cortex-A76/Neoverse-N1 erratum #1418040 w/ existing workaround
> 
> could you perhaps talk to somebody inside ARM about making the errata
> documentation publicly available?
> 
> I'm not sure why it seems to want an account at arm.com, and as a
> result some pretty fundamental development tools ("let me google
> that") don't work.

Thanks to the tech comms folks at Arm, this should now be available and
work is ongoing to open up more of the documentation too.

For example, the A76 SDEN is here:

	https://static.docs.arm.com/sden885749/d/Arm_Cortex-A76_MP052_Software_Developer_Errata_Notice_v16.0.pdf

and if you hammer "cortex a76 1463225" into google, then it shows up
after the Linux hits.

Will
