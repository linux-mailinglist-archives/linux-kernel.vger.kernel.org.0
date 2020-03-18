Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC318A388
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCRUNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 16:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRUNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:13:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EEF2071C;
        Wed, 18 Mar 2020 20:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584562385;
        bh=pe4t1TUdWt373Ez1EnHNV+7ooE3eThnbOn1Mljp2GuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJfc1ht/bYxSxn6MowvslrLRwT9YTkQYplJpTElDcJogHBcmdK0MT1NWSEncYrRFw
         5+Fl9RF+m9QrQZoPXmFeB64y1NrjrT8m40A/WV2rYnfZVte49RVauotNPueT+RwzQR
         W8fAahaG7Zx3ewn3MZDnu8JgRwY9AqocH74w51lg=
Date:   Wed, 18 Mar 2020 20:13:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200318201259.GA7463@willie-the-truck>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
 <20200317135719.GH3971@sirena.org.uk>
 <20200317151813.GA16579@willie-the-truck>
 <20200317163638.GI3971@sirena.org.uk>
 <20200317210154.GA19752@willie-the-truck>
 <20200318113217.GA4553@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318113217.GA4553@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:32:17AM +0000, Mark Brown wrote:
> On Tue, Mar 17, 2020 at 09:01:54PM +0000, Will Deacon wrote:
> > On Tue, Mar 17, 2020 at 04:36:38PM +0000, Mark Brown wrote:
> 
> > > I'd need to go back and retest to confirm but it looks like always had
> > > the issue that we'd install some nG mappings early even with KPTI
> > > disabled on the command line so your change is just restoring the
> > > previous behaviour and we're no worse than we were before.
> 
> > Urgh, this code brings back really bad memories :( :( :(
> 
> Tell me about it.
> 
> > So I've hacked the following, which appears to work but damn I'd like
> > somebody else to look at this. I also have a nagging feeling that you
> > implemented it like this at some point, but we tried to consolidate things
> > during review.
> 
> > Thoughts?
> 
> I don't think I did *exactly* this but it's familiar yeah.  It looks
> sensible and I can't think of any problems but that doesn't mean there
> aren't any.

Well, thanks for having a look!

Hongbo -- please can you confirm that this fixes the problem that you are
seeing?

Will
