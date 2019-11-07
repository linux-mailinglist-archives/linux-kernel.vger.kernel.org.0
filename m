Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4DF2EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbfKGNBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfKGNBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:01:04 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD7F214D8;
        Thu,  7 Nov 2019 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573131664;
        bh=/kIrVp51INVnGZ+Kk+9uLG4BcqnGFSk3GAAMx/W7RMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxZCcssfCiTaRAKMEOUnkgtiTRHB4bbqIqoNZpP85tMzpkdc8VAqfE/32Z3BcKNJF
         iC36aS4dgYQ5JOx3qptAq5ybyNWVKzqf3bXtyDLXp3oe/U2Di2jurqlSJXsEv/Ny08
         GeDJfWnkdOUPudA1G4JqC0nw8mqGdckwvJPkbvzs=
Date:   Thu, 7 Nov 2019 13:00:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v4 00/10] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <20191107130059.GB12705@willie-the-truck>
References: <20191030143035.19440-1-will@kernel.org>
 <201910301139.ED3551BB14@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910301139.ED3551BB14@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:40:56AM -0700, Kees Cook wrote:
> On Wed, Oct 30, 2019 at 02:30:25PM +0000, Will Deacon wrote:
> > Hi all,
> > 
> > This is version four of the patches I previously posted here:
> > 
> >   v1: https://lkml.kernel.org/r/20190802101000.12958-1-will@kernel.org
> >   v2: https://lkml.kernel.org/r/20190827163204.29903-1-will@kernel.org
> >   v3: https://lkml.kernel.org/r/20191007154703.5574-1-will@kernel.org
> > 
> > Changes since v3 include:
> > 
> >   - Add description of racy behaviour include/linux/refcount.h
> >   - Fix saturation behaviour in refcount_sub_and_test()
> >   - Added Acks and Tested-bys
> 
> Thanks again for this! I think this series is in good shape; I'm glad we
> can sanely expand these protections.

Cheers, Kees.

Peter -- are you ok with this version? I think I've addressed all of your
concerns from v3, including the addition of ASCII-art to explain the
saturation behaviour (I can use .rst instead if you prefer).

Will
