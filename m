Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8336612848
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfECG76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:58 -0400
Received: from ozlabs.org ([203.11.71.1]:40339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfECG7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:25 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKR4m2Pz9sNC; Fri,  3 May 2019 16:59:23 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5ba666d56c4ff9b011c1b029dcc689cff8b176fb
X-Patchwork-Hint: ignore
In-Reply-To: <3814377306ac3acdd404e2f23ff05dcf7e6bee26.1556202029.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] powerpc/mm: fix erroneous duplicate slb_addr_limit init
Message-Id: <44wNKR4m2Pz9sNC@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-25 at 14:29:27 UTC, Christophe Leroy wrote:
> Commit 67fda38f0d68 ("powerpc/mm: Move slb_addr_linit to
> early_init_mmu") moved slb_addr_limit init out of setup_arch().
> 
> Commit 701101865f5d ("powerpc/mm: Reduce memory usage for mm_context_t
> for radix") brought it back into setup_arch() by error.
> 
> This patch reverts that erroneous regress.
> 
> Fixes: 701101865f5d ("powerpc/mm: Reduce memory usage for mm_context_t for radix")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Patches 1-10 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5ba666d56c4ff9b011c1b029dcc689cf

cheers
