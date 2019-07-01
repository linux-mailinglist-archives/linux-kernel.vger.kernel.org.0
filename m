Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC22F3D14E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405443AbfFKPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 11:47:50 -0400
Received: from foss.arm.com ([217.140.110.172]:36418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405425AbfFKPru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:47:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71FB8337;
        Tue, 11 Jun 2019 08:47:49 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BED713F246;
        Tue, 11 Jun 2019 08:47:48 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:47:46 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/2] linux/bits.h: make BIT(), GENMASK(), and friends
 available in assembly
Message-ID: <20190611154746.GF4324@fuggles.cambridge.arm.com>
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
 <20190527083412.26651-2-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527083412.26651-2-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:34:11PM +0900, Masahiro Yamada wrote:
> BIT(), GENMASK(), etc. are useful to define register bits of hardware.
> However, low-level code is often written in assembly, where they are
> not available due to the hard-coded 1UL, 0UL.
> 
> In fact, in-kernel headers such as arch/arm64/include/asm/sysreg.h
> use _BITUL() instead of BIT() so that the register bit macros are
> available in assembly.
> 
> Using macros in include/uapi/linux/const.h have two reasons:
> 
> [1] For use in uapi headers
>   We should use underscore-prefixed variants for user-space.
> 
> [2] For use in assembly code
>   Since _BITUL() does not use hard-coded 1UL, it can be used as an
>   alternative of BIT().
> 
> For [2], it is pretty easy to change BIT() etc. for use in assembly.
> 
> This allows to replace _BUTUL() in kernel headers with BIT().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  include/linux/bits.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
