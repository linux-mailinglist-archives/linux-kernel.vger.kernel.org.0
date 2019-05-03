Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74AB12885
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfECHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 03:14:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECHOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:14:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKS0PfWz9s9y; Fri,  3 May 2019 16:59:23 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a521c44c3ded9fe184c5de3eed3a442af2d26f00
X-Patchwork-Hint: ignore
In-Reply-To: <11addb677de7449523fd0023a9ca43b8898c207a.1556258135.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/17] powerpc/book3e: drop mmu_get_tsize()
Message-Id: <44wNKS0PfWz9s9y@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 05:59:38 UTC, Christophe Leroy wrote:
> This function is not used anymore, drop it.
> 
> Fixes: b42279f0165c ("powerpc/mm/nohash: MM_SLICE is only used by book3s 64")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patches 3-17 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a521c44c3ded9fe184c5de3eed3a442a

cheers
