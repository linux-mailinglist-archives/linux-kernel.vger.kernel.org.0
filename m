Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D8F5AF6C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF3IhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 04:37:22 -0400
Received: from ozlabs.org ([203.11.71.1]:39209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfF3IhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:37:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45c3lg68Lrz9sBr; Sun, 30 Jun 2019 18:37:19 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9c4e4c90ec24652921e31e9551fcaedc26eec86d
X-Patchwork-Hint: ignore
In-Reply-To: <7b15f4a18ab2d9fb54559acbadf2cd83a7d147f7.1557469839.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64: mark start_here_multiplatform as __ref
Message-Id: <45c3lg68Lrz9sBr@ozlabs.org>
Date:   Sun, 30 Jun 2019 18:37:19 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 06:31:28 UTC, Christophe Leroy wrote:
> Otherwise, the following warning is encountered:
> 
> WARNING: vmlinux.o(.text+0x3dc6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup()
> The function start_here_multiplatform() references
> the function __init .early_setup().
> This is often because start_here_multiplatform lacks a __init
> annotation or the annotation of .early_setup is wrong.
> 
> Fixes: 56c46bba9bbf ("powerpc/64: Fix booting large kernels with STRICT_KERNEL_RWX")
> Cc: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c4e4c90ec24652921e31e9551fcaedc26eec86d

cheers
