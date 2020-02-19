Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04760164471
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBSMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 07:40:05 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgBSMkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:40:03 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3h6S2Rz9sSd; Wed, 19 Feb 2020 23:40:00 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 477f3488a94e35380c82a7498d46f10fa5f3edd2
In-Reply-To: <7bce32ccbab3ba3e3e0f27da6961bf6313df97ed.1581663140.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/6xx: Fix power_save_ppc32_restore() with CONFIG_VMAP_STACK
Message-Id: <48My3h6S2Rz9sSd@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:40:00 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 06:53:00 UTC, Christophe Leroy wrote:
> power_save_ppc32_restore() is called during exception entry, before
> re-enabling the MMU. It substracts KERNELBASE from the address
> of nap_save_msscr0 to access it.
> 
> With CONFIG_VMAP_STACK enabled, data MMU translation has already been
> re-enabled, so power_save_ppc32_restore() has to access
> nap_save_msscr0 by its virtual address.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/477f3488a94e35380c82a7498d46f10fa5f3edd2

cheers
