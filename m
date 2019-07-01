Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38374EB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfFUO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:57:08 -0400
Received: from foss.arm.com ([217.140.110.172]:33970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUO5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:57:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C31028;
        Fri, 21 Jun 2019 07:57:07 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFCF83F575;
        Fri, 21 Jun 2019 07:57:06 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:57:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: linux-next: Fixes tags need some work in the arm64 tree
Message-ID: <20190621145704.GH18954@arrakis.emea.arm.com>
References: <20190621213615.0efd4fa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621213615.0efd4fa4@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:36:15PM +1000, Stephen Rothwell wrote:
> In commit
> 
>   86fc32fee888 ("arm64: Fix incorrect irqflag restore for priority masking")
> 
> Fixes tag
> 
>   Fixes: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Thanks Stephen. Updated (and I should probably update my patch applying
script to rewrite the fixes lines with something like
git show -s --pretty=format:"Fixes: %h (\"%s\")" <commit>)

-- 
Catalin
