Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187CF12851
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfECHAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 03:00:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfECG7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:24 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKR0HMbz9sPG; Fri,  3 May 2019 16:59:22 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 33dda8c32714c1a8f318450af4d1f9f123e2ed24
X-Patchwork-Hint: ignore
In-Reply-To: <20190423211116.261111-1-ndesaulniers@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        clang-built-linux@googlegroups.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] powerpc: vdso: drop unnecessary cc-ldoption
Message-Id: <44wNKR0HMbz9sPG@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:22 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-23 at 21:11:14 UTC, Nick Desaulniers wrote:
> Towards the goal of removing cc-ldoption, it seems that --hash-style=
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
> 
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/33dda8c32714c1a8f318450af4d1f9f1

cheers
