Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DD12843
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfECG7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:33 -0400
Received: from ozlabs.org ([203.11.71.1]:53895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfECG7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKX3tkmz9sPV; Fri,  3 May 2019 16:59:27 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8a23fdec3dbdc8bfde6f806d36e773236dab6663
X-Patchwork-Hint: ignore
In-Reply-To: <1103b2c9715bab90d680dcf78303619ff49debd0.1556627571.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] powerpc/32: Refactor EXCEPTION entry macros for head_8xx.S and head_32.S
Message-Id: <44wNKX3tkmz9sPV@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:27 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-30 at 12:38:50 UTC, Christophe Leroy wrote:
> EXCEPTION_PROLOG is similar in head_8xx.S and head_32.S
> 
> This patch creates head_32.h and moves EXCEPTION_PROLOG macro
> into it. It also converts it from a GCC macro to a GAS macro
> in order to ease refactorisation with 40x later, since
> GAS macros allows the use of #ifdef/#else/#endif inside it.
> And it also has the advantage of not requiring the uggly "; \"
> at the end of each line.
> 
> This patch also moves EXCEPTION() and EXC_XFER_XXXX() macros which
> are also similar while adding START_EXCEPTION() out of EXCEPTION().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a23fdec3dbdc8bfde6f806d36e77323

cheers
