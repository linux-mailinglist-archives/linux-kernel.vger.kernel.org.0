Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6683D330
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405623AbfFKRBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 13:01:31 -0400
Received: from foss.arm.com ([217.140.110.172]:37774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405479AbfFKRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:01:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EE85337;
        Tue, 11 Jun 2019 10:01:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C3D3F73C;
        Tue, 11 Jun 2019 10:01:29 -0700 (PDT)
Date:   Tue, 11 Jun 2019 18:01:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH 1/7] perf: arm64: Compile tests unconditionally
Message-ID: <20190611170126.GH29008@lakrids.cambridge.arm.com>
References: <20190611125315.18736-1-raphael.gault@arm.com>
 <20190611125315.18736-2-raphael.gault@arm.com>
 <20190611140907.GF29008@lakrids.cambridge.arm.com>
 <20190611142356.GA28689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611142356.GA28689@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:23:56AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 11, 2019 at 03:09:07PM +0100, Mark Rutland escreveu:
> > On Tue, Jun 11, 2019 at 01:53:09PM +0100, Raphael Gault wrote:
> > > In order to subsequently add more tests for the arm64 architecture
> > > we compile the tests target for arm64 systematically.
> > 
> > Given prior questions regarding this commit, it's probably worth
> > spelling things out more explicitly, e.g.
> > 
> >   Currently we only build the arm64/tests directory if
> >   CONFIG_DWARF_UNWIND is selected, which is fine as the only test we
> >   have is arm64/tests/dwarf-unwind.o.
> > 
> >   So that we can add more tests to the test directory, let's
> >   unconditionally build the directory, but conditionally build
> >   dwarf-unwind.o depending on CONFIG_DWARF_UNWIND.
> > 
> >   There should be no functional change as a result of this patch.
> > 
> > > 
> > > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> > 
> > Either way, the patch looks good to me:
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> I'll update the comment, collect your Acked-by and apply the patch.

That's great, thanks!

As a heads-up, there are still open ABI discussions to be had on the
rest of the series, so while review would be appreciated, it would be
best to hold off applying the remaining userspace bits for now.

Mark.
