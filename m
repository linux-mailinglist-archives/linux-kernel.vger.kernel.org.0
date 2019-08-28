Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4AF9F92D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 06:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfH1EYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 00:24:50 -0400
Received: from ozlabs.org ([203.11.71.1]:53079 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfH1EYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:24:50 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46JCM34MCJz9sNF; Wed, 28 Aug 2019 14:24:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 56347074c5307d7bca5db38eb2c764c64ae57514
In-Reply-To: <20190713032106.8509-1-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
Message-Id: <46JCM34MCJz9sNF@ozlabs.org>
Date:   Wed, 28 Aug 2019 14:24:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-13 at 03:21:06 UTC, Masahiro Yamada wrote:
> The KBUILD_ARFLAGS addition in arch/powerpc/Makefile has never worked
> in a useful way because it is always overridden by the following code
> in the top Makefile:
> 
>   # use the deterministic mode of AR if available
>   KBUILD_ARFLAGS := $(call ar-option,D)
> 
> The code in the top Makefile was added in 2011, by commit 40df759e2b9e
> ("kbuild: Fix build with binutils <= 2.19").
> 
> The KBUILD_ARFLAGS addition for ppc has always been dead code from the
> beginning.
> 
> Nobody has reported a problem since 43c9127d94d6 ("powerpc: Add option
> to use thin archives"), so this code was unneeded.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/56347074c5307d7bca5db38eb2c764c64ae57514

cheers
