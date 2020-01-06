Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38ED130CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 06:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFFX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 00:23:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41821 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFFX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:23:26 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47rkSD0mxYz9sR4; Mon,  6 Jan 2020 16:23:23 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6da3eced8c5f3b03340b0c395bacd552c4d52411
In-Reply-To: <20191223133147.129983-1-Jason@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, pauld@redhat.com,
        longman@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/shared: include correct header for static key
Message-Id: <47rkSD0mxYz9sR4@ozlabs.org>
Date:   Mon,  6 Jan 2020 16:23:23 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-23 at 13:31:47 UTC, "Jason A. Donenfeld" wrote:
> Recently, the spinlock implementation grew a static key optimization,
> but the jump_label.h header include was left out, leading to build
> errors:
> 
> linux/arch/powerpc/include/asm/spinlock.h:44:7: error: implicit declaration of function ‘static_branch_unlikely’ [-Werror=implicit-function-declaration]
>    44 |  if (!static_branch_unlikely(&shared_processor))
> 
> This commit adds the missing header.
> 
> Fixes: 656c21d6af5d ("powerpc/shared: Use static key to detect shared processor")
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6da3eced8c5f3b03340b0c395bacd552c4d52411

cheers
