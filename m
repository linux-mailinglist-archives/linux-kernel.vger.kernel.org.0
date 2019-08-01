Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674F17DD7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfHAOKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 10:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731620AbfHAOKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:10:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D0020679;
        Thu,  1 Aug 2019 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564668613;
        bh=aTQgjcwnlFP9R0XuBVgdEzfyH25m29QufiYDNE5ngdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDX4xAksYbtR2hl+kD3gWwwg9YL0fEHnijkOWgjt8paEPQ4/srbpTdfQtjKvuChs6
         FbFeAjYi4RTMZOZMSONSFZQ+IfLq1um6mVcaAbCUi0JtR+o0hvdJhMLJ/+2UMeFRAP
         5jrS7r6HXoYJRAbw9YGfs2JilMmDU7QScT+kn/Ko=
Date:   Thu, 1 Aug 2019 15:10:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm64-fixes
 tree
Message-ID: <20190801141009.iksa5pc25vxlydak@willie-the-truck>
References: <20190801235614.4318ce1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801235614.4318ce1a@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:56:14PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   23fb9748a46d ("arm64: Lower priority mask for GIC_PRIO_IRQON")
> 
> is missing a Signed-off-by from its committer.

Urgh, I just can't get this one right, can I? Let's see if I managed it
this time. Otherwise I'm reverting the thing and we'll just have to live
with broken priority masking forever!

Will
