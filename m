Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705755E694
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGCO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:27:07 -0400
Received: from ozlabs.org ([203.11.71.1]:39609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCO1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45f3Mq1Jzfz9s8m; Thu,  4 Jul 2019 00:27:02 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3becd11dffe5d4a7467ebd841172f3e091fbcbd0
In-Reply-To: <1559767579-7151-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>, sbobroff@linux.ibm.com,
        linux-kernel@vger.kernel.org, oohall@gmail.com, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/eeh_cache: fix a W=1 kernel-doc warning
Message-Id: <45f3Mq1Jzfz9s8m@ozlabs.org>
Date:   Thu,  4 Jul 2019 00:27:02 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 20:46:19 UTC, Qian Cai wrote:
> The opening comment mark "/**" is reserved for kernel-doc comments, so
> it will generate a warning with "make W=1".
> 
> arch/powerpc/kernel/eeh_cache.c:37: warning: cannot understand function
> prototype: 'struct pci_io_addr_range
> 
> Since this is not a kernel-doc for the struct below, but rather an
> overview of this source eeh_cache.c, just use the free-form comments
> kernel-doc syntax instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3becd11dffe5d4a7467ebd841172f3e091fbcbd0

cheers
