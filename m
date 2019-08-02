Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A417EA4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 04:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfHBC20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 22:28:26 -0400
Received: from ozlabs.org ([203.11.71.1]:42535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfHBC2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:28:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 460B0k6y1Hz9sDB; Fri,  2 Aug 2019 12:28:22 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7440ea8b2a4430eef5120d0a7faac6c39304ae6d
In-Reply-To: <20190730143704.060a2606@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Linux kernel Mailing List <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch fall-through
Message-Id: <460B0k6y1Hz9sDB@ozlabs.org>
Date:   Fri,  2 Aug 2019 12:28:22 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-30 at 04:37:04 UTC, Stephen Rothwell wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: powerpc):
> 
> drivers/macintosh/smu.c: In function 'smu_queue_i2c':
> drivers/macintosh/smu.c:854:21: warning: this statement may fall through [-=
> Wimplicit-fallthrough=3D]
>    cmd->info.devaddr &=3D 0xfe;
>    ~~~~~~~~~~~~~~~~~~^~~~~~~
> drivers/macintosh/smu.c:855:2: note: here
>   case SMU_I2C_TRANSFER_STDSUB:
>   ^~~~
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7440ea8b2a4430eef5120d0a7faac6c39304ae6d

cheers
