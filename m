Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14737EA4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 04:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfHBC2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 22:28:25 -0400
Received: from ozlabs.org ([203.11.71.1]:43835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730344AbfHBC2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:28:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 460B0l2PCPz9sML; Fri,  2 Aug 2019 12:28:23 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d7e23b887f67178c4f840781be7a6aa6aeb52ab1
In-Reply-To: <da89670093651437f27d2975224712e0a130b055.1564552796.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kasan: fix early boot failure on PPC32
Message-Id: <460B0l2PCPz9sML@ozlabs.org>
Date:   Fri,  2 Aug 2019 12:28:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 06:01:42 UTC, Christophe Leroy wrote:
> Due to commit 4a6d8cf90017 ("powerpc/mm: don't use pte_alloc_kernel()
> until slab is available on PPC32"), pte_alloc_kernel() cannot be used
> during early KASAN init.
> 
> Fix it by using memblock_alloc() instead.
> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d7e23b887f67178c4f840781be7a6aa6aeb52ab1

cheers
