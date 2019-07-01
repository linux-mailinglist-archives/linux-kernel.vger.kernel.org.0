Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E8357E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 09:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFEHeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 03:34:11 -0400
Received: from foss.arm.com ([217.140.101.70]:54614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfFEHeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F59A78;
        Wed,  5 Jun 2019 00:34:11 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EF683F246;
        Wed,  5 Jun 2019 00:34:09 -0700 (PDT)
Date:   Wed, 5 Jun 2019 08:34:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Allow assembly code to use BIT(), GENMASK(), etc.
 and clean-up arm64 header
Message-ID: <20190605073406.geesp3rbrxajmac6@mbp>
References: <20190527083412.26651-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527083412.26651-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:34:10PM +0900, Masahiro Yamada wrote:
> Some in-kernel headers use _BITUL() instead of BIT().
> 
>  arch/arm64/include/asm/sysreg.h
>  arch/s390/include/asm/*.h
> 
> I think the reason is because BIT() is currently not available
> in assembly. It hard-codes 1UL, which is not available in assembly.
[...]
> Masahiro Yamada (2):
>   linux/bits.h: make BIT(), GENMASK(), and friends available in assembly
>   arm64: replace _BITUL() with BIT()
> 
>  arch/arm64/include/asm/sysreg.h | 82 ++++++++++++++++-----------------
>  include/linux/bits.h            | 17 ++++---

I'm not sure it's worth the hassle. It's nice to have the same BIT macro
but a quick grep shows arc, arm64, s390 and x86 using _BITUL. Maybe a
tree-wide clean-up would be more appropriate.

-- 
Catalin
