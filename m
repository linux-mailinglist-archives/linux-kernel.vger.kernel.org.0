Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAF12837
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfECG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfECG7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNK71r4Fz9s9y; Fri,  3 May 2019 16:59:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 502523fd1d2ac559b41d8302dc9f826f578ec54d
X-Patchwork-Hint: ignore
In-Reply-To: <20190309174727.186371051B7@localhost.localdomain>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/irq: drop __irq_offset_value
Message-Id: <44wNK71r4Fz9s9y@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-09 at 17:47:27 UTC, Christophe Leroy wrote:
> This patch drops__irq_offset_value which has not been used since
> commit 9c4cb8251513 ("powerpc: Remove use of CONFIG_PPC_MERGE")
> 
> This removes a sparse warning.
> 
> Fixes: 9c4cb8251513 ("powerpc: Remove use of CONFIG_PPC_MERGE")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/502523fd1d2ac559b41d8302dc9f826f

cheers
