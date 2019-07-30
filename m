Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A276C7B5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 00:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfG3WuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 18:50:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfG3WuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:50:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45ysFx2Nxqz9sMr; Wed, 31 Jul 2019 08:50:12 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cee3536d24a1d5db66b9f68c3ece0af128187ab4
In-Reply-To: <20190724140259.23554-1-mpe@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     asolokha@kb.kras.ru, linux-kernel@vger.kernel.org,
        christian@brauner.io
Subject: Re: [PATCH v2] powerpc: Wire up clone3 syscall
Message-Id: <45ysFx2Nxqz9sMr@ozlabs.org>
Date:   Wed, 31 Jul 2019 08:50:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-24 at 14:02:59 UTC, Michael Ellerman wrote:
> Wire up the new clone3 syscall added in commit 7f192e3cd316 ("fork:
> add clone3").
> 
> This requires a ppc_clone3 wrapper, in order to save the non-volatile
> GPRs before calling into the generic syscall code. Otherwise we hit
> the BUG_ON in CHECK_FULL_REGS in copy_thread().
> 
> Lightly tested using Christian's test code on a Power8 LE VM.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/cee3536d24a1d5db66b9f68c3ece0af128187ab4

cheers
