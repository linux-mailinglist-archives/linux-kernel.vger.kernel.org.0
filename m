Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E414B51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEFNyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:54:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEFNyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:54:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44yPNZ30mBz9s9N; Mon,  6 May 2019 23:54:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 471e475c69a1689e059b5e57e893a7da75d2831a
X-Patchwork-Hint: ignore
In-Reply-To: <502da34ded576b9869b0f49146d465207fbd98ac.1557123466.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Fix makefile for KASAN
Message-Id: <44yPNZ30mBz9s9N@ozlabs.org>
Date:   Mon,  6 May 2019 23:54:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 06:21:01 UTC, Christophe Leroy wrote:
> In commit 17312f258cf6 ("powerpc/mm: Move book3s32 specifics in
> subdirectory mm/book3s64"), ppc_mmu_32.c was moved and renamed.
> 
> This patch fixes Makefiles to disable KASAN instrumentation on
> the new name and location.
> 
> Fixes: f072015c7b74 ("powerpc: disable KASAN instrumentation on early/critical files.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/471e475c69a1689e059b5e57e893a7da

cheers
