Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400815AF6D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF3Ihc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 04:37:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfF3Ihb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:37:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45c3ls4ssQz9sNl; Sun, 30 Jun 2019 18:37:29 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 46c2478af610efb3212b8b08f74389d69899ef70
X-Patchwork-Hint: ignore
In-Reply-To: <87muif52lv.fsf_-_@igel.home>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/32s: fix condition that is always true
Message-Id: <45c3ls4ssQz9sNl@ozlabs.org>
Date:   Sun, 30 Jun 2019 18:37:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 21:22:20 UTC, Andreas Schwab wrote:
> Move a misplaced paren that makes the condition always true.
> 
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/46c2478af610efb3212b8b08f74389d69899ef70

cheers
