Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B0EB5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfJaRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 13:15:34 -0400
Received: from foss.arm.com ([217.140.110.172]:52644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbfJaRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:15:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7CBF1FB;
        Thu, 31 Oct 2019 10:15:33 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA353F6C4;
        Thu, 31 Oct 2019 10:15:32 -0700 (PDT)
Date:   Thu, 31 Oct 2019 17:15:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        "julien@xen.org" <julien@xen.org>
Subject: Re: [PATCH 4/4] docs/arm64: cpu-feature-registers: Documents missing
 visible fields
Message-ID: <20191031171530.GG39590@arrakis.emea.arm.com>
References: <20191003111211.483-1-julien.grall@arm.com>
 <20191003111211.483-5-julien.grall@arm.com>
 <9a4aa626-a16f-b01a-0254-43946de9ff6e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4aa626-a16f-b01a-0254-43946de9ff6e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 04:48:18PM +0000, Julien Grall wrote:
> On 03/10/2019 12:12, Julien Grall wrote:
> > A couple of fields visible to userspace are not described in the
> > documentation. So update it.
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > ---
> >   Documentation/arm64/cpu-feature-registers.rst | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> > index 2955287e9acc..ffcf4e2c71ef 100644
> > --- a/Documentation/arm64/cpu-feature-registers.rst
> > +++ b/Documentation/arm64/cpu-feature-registers.rst
> > @@ -193,6 +193,10 @@ infrastructure:
> >        +------------------------------+---------+---------+
> >        | Name                         |  bits   | visible |
> >        +------------------------------+---------+---------+
> > +     | SB                           | [36-39] |    y    |
> > +     +------------------------------+---------+---------+
> > +     | FRINTTS                      | [32-35] |    y    |
> > +     +------------------------------+---------+---------+
> 
> Will reported the bitfields were inconsistent (see [1]). Looking in more
> details, it seems that I messed up this patch when sending it (I honestly
> can't remember why I wrote like that :().
> 
> @Catalin, I saw you applied this patch to for-next/elf-hwcap-docs. Would you
> mind to update the content of the patch? Or do you prefer a new version?

Please send a fix on top of the elf-hwcap-docs branch. I'd prefer not to
rebase it.

-- 
Catalin
