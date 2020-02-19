Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CC164473
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBSMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 07:40:11 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48433 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgBSMkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:40:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3k49Kkz9sSg; Wed, 19 Feb 2020 23:40:01 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5a528eb67908bcf493f3583cb4726fbd8e129605
In-Reply-To: <d2330584f8c42d3039896e2b56f5d39676dc919c.1581669558.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND with Fixes: tag] powerpc/chrp: Fix enter_rtas() with CONFIG_VMAP_STACK
Message-Id: <48My3k49Kkz9sSg@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:40:01 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 08:39:50 UTC, Christophe Leroy wrote:
> With CONFIG_VMAP_STACK, data MMU has to be enabled
> to read data on the stack.
> 
> Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5a528eb67908bcf493f3583cb4726fbd8e129605

cheers
