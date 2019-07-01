Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C2F41B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 07:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfFLE7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 00:59:13 -0400
Received: from ozlabs.org ([203.11.71.1]:40361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbfFLE7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:59:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45NvmH0kL6z9sBr; Wed, 12 Jun 2019 14:59:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c21f5a9ed85ca3e914ca11f421677ae9ae0d04b0
X-Patchwork-Hint: ignore
In-Reply-To: <90d30adb0943a11ab127808c03229ba657478df4.1559566521.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix booting with CONFIG_PPC_EARLY_DEBUG_BOOTX
Message-Id: <45NvmH0kL6z9sBr@ozlabs.org>
Date:   Wed, 12 Jun 2019 14:59:10 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 13:00:51 UTC, Christophe Leroy wrote:
> When booting through OF, setup_disp_bat() does nothing because
> disp_BAT are not set. By change, it used to work because BOOTX
> buffer is mapped 1:1 at address 0x81000000 by the bootloader, and
> btext_setup_display() sets virt addr same as phys addr.
> 
> But since commit 215b823707ce ("powerpc/32s: set up an early static
> hash table for KASAN."), a temporary page table overrides the
> bootloader mapping.
> 
> This 0x81000000 is also problematic with the newly implemented
> Kernel Userspace Access Protection (KUAP) because it is within user
> address space.
> 
> This patch fixes those issues by properly setting disp_BAT through
> a call to btext_prepare_BAT(), allowing setup_disp_bat() to
> properly setup BAT3 for early bootx screen buffer access.
> 
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for KASAN.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c21f5a9ed85ca3e914ca11f421677ae9

cheers
