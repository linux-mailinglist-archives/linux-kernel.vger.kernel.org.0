Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E577E123E39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 05:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLREFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 23:05:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfLREFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:05:11 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47d1cj6QD8z9sS3; Wed, 18 Dec 2019 15:05:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 099bc4812f09155da77eeb960a983470249c9ce1
In-Reply-To: <e033aa8116ab12b7ca9a9c75189ad0741e3b9b5f.1575872340.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/irq: fix stack overflow verification
Message-Id: <47d1cj6QD8z9sS3@ozlabs.org>
Date:   Wed, 18 Dec 2019 15:05:09 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 06:19:08 UTC, Christophe Leroy wrote:
> Before commit 0366a1c70b89 ("powerpc/irq: Run softirqs off the top of
> the irq stack"), check_stack_overflow() was called by do_IRQ(), before
> switching to the irq stack.
> In that commit, do_IRQ() was renamed __do_irq(), and is now executing
> on the irq stack, so check_stack_overflow() has just become almost
> useless.
> 
> Move check_stack_overflow() call in do_IRQ() to do the check while
> still on the current stack.
> 
> Fixes: 0366a1c70b89 ("powerpc/irq: Run softirqs off the top of the irq stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/099bc4812f09155da77eeb960a983470249c9ce1

cheers
