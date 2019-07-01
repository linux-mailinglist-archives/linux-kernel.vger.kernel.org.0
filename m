Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640AD14B52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEFNyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:54:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfEFNyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:54:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44yPNc6Bxmz9sBb; Mon,  6 May 2019 23:54:08 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c4e31847a5490d52ddd44440a524e8355be11ec1
X-Patchwork-Hint: ignore
In-Reply-To: <c37bcf93f1e661ba2a5ee69d67786d9ae6520ccd.1557125247.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: fix redundant inclusion of pgtable-frag.o in Makefile
Message-Id: <44yPNc6Bxmz9sBb@ozlabs.org>
Date:   Mon,  6 May 2019 23:54:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 06:47:55 UTC, Christophe Leroy wrote:
> The patch identified below added pgtable-frag.o to obj-y
> but some merge witchery kept it also for obj-CONFIG_PPC_BOOK3S_64
> 
> This patch clears the duplication.
> 
> Fixes: 737b434d3d55 ("powerpc/mm: convert Book3E 64 to pte_fragment")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c4e31847a5490d52ddd44440a524e835

cheers
