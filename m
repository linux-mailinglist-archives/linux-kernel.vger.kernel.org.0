Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18375AF6F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfF3Ihg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 04:37:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38107 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfF3Ihe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:37:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45c3lw0kZZz9sLt; Sun, 30 Jun 2019 18:37:31 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6ecb78ef56e08d2119d337ae23cb951a640dc52d
X-Patchwork-Hint: ignore
In-Reply-To: <97f32bd4c45ce004550b3853474b3bc7e211ae0d.1560807643.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andreas Schwab <schwab@linux-m68k.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/32s: fix suspend/resume when IBATs 4-7 are used
Message-Id: <45c3lw0kZZz9sLt@ozlabs.org>
Date:   Sun, 30 Jun 2019 18:37:31 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 21:42:14 UTC, Christophe Leroy wrote:
> Previously, only IBAT1 and IBAT2 were used to map kernel linear mem.
> Since commit 63b2bc619565 ("powerpc/mm/32s: Use BATs for
> STRICT_KERNEL_RWX"), we may have all 8 BATs used for mapping
> kernel text. But the suspend/restore functions only save/restore
> BATs 0 to 3, and clears BATs 4 to 7.
> 
> Make suspend and restore functions respectively save and reload
> the 8 BATs on CPUs having MMU_FTR_USE_HIGH_BATS feature.
> 
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6ecb78ef56e08d2119d337ae23cb951a640dc52d

cheers
