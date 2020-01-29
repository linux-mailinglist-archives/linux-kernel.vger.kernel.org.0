Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E414C588
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgA2FRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:41 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40247 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgA2FRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:37 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDw0Snbz9s1x; Wed, 29 Jan 2020 16:17:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1e1c8b2cc37afb333c1829e8e0360321813bf220
In-Reply-To: <bf34fd9dca61eadf9a134a9f89ebbc162cfd5f86.1578986011.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/ptdump: don't entirely rebuild kernel when selecting CONFIG_PPC_DEBUG_WX
Message-Id: <486sDw0Snbz9s1x@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:34 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 07:14:40 UTC, Christophe Leroy wrote:
> Selecting CONFIG_PPC_DEBUG_WX only impacts ptdump and pgtable_32/64
> init calls. Declaring related functions in asm/pgtable.h implies
> rebuilding almost everything.
> 
> Move ptdump_check_wx() declaration in mm/mmu_decl.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1e1c8b2cc37afb333c1829e8e0360321813bf220

cheers
