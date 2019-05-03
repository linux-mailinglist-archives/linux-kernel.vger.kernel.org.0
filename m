Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3A12838
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfECG7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:11 -0400
Received: from ozlabs.org ([203.11.71.1]:36331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfECG7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNK76clXz9sNl; Fri,  3 May 2019 16:59:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 90437bffa5f9b1440ba03e023f4875d1814b9360
X-Patchwork-Hint: ignore
In-Reply-To: <20190311224752.8337-9-valentin.schneider@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/14] powerpc: entry: Remove unneeded need_resched() loop
Message-Id: <44wNK76clXz9sNl@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 22:47:46 UTC, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/90437bffa5f9b1440ba03e023f4875d1

cheers
