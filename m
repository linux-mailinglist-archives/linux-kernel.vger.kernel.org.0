Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72671D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 19:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbfGWRQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 13:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388267AbfGWRQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:16:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498D42239F;
        Tue, 23 Jul 2019 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563902203;
        bh=AhMUEigBVGgjkqk8XoCkrqk5l7DyuxEw5bsGofwzDS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLAPoQsrnIFw77o74ZsbhCw4KtI2HqtBvNitEL1VmCvwG8NgOzm9Id6zBXjGjaXeS
         ++wNyjzYU/pU8eLqFn/syaPLNa/5pKL50YOvuDR95bGwn0ZM+phDaf782oHzqTvLf4
         fgq+RrbpVtl6uEFlmuMW3MjnInL03S8uZyhfhbTM=
Date:   Tue, 23 Jul 2019 18:16:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove unneeded uapi/asm/stat.h
Message-ID: <20190723171638.ctzz6jt3442zvg2d@willie-the-truck>
References: <20190723112922.14315-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723112922.14315-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:29:22PM +0900, Masahiro Yamada wrote:
> stat.h is listed in include/uapi/asm-generic/Kbuild, so Kbuild will
> automatically generate it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/include/uapi/asm/stat.h | 17 -----------------
>  1 file changed, 17 deletions(-)
>  delete mode 100644 arch/arm64/include/uapi/asm/stat.h

Thanks, I'll pick this up for 5.4.

Will
