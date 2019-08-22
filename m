Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D317599490
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfHVNJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:09:06 -0400
Received: from ozlabs.org ([203.11.71.1]:59447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388916AbfHVNJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:04 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGj6tBtz9sN6; Thu, 22 Aug 2019 23:09:01 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9d6d712fbf7766f21c838940eebcd7b4d476c5e6
In-Reply-To: <b7860c5e1e784d6b96ba67edf47dd6cbc2e78ab6.1565776892.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net,
        nch@infradead.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/32s: fix boot failure with DEBUG_PAGEALLOC without KASAN.
Message-Id: <46DlGj6tBtz9sN6@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:01 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-14 at 10:02:20 UTC, Christophe Leroy wrote:
> When KASAN is selected, the definitive hash table has to be
> set up later, but there is already an early temporary one.
> 
> When KASAN is not selected, there is no early hash table,
> so the setup of the definitive hash table cannot be delayed.
> 
> Reported-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
> Fixes: 72f208c6a8f7 ("powerpc/32s: move hash code patching out of MMU_init_hw()")
> Tested-by: Jonathan Neuschafer <j.neuschaefer@gmx.net>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d6d712fbf7766f21c838940eebcd7b4d476c5e6

cheers
