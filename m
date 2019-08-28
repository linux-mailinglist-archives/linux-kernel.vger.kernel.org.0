Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5345A9F95B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 06:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH1EYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 00:24:54 -0400
Received: from ozlabs.org ([203.11.71.1]:51451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfH1EYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:24:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46JCM570Xkz9sP6; Wed, 28 Aug 2019 14:24:49 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c691b4b83b6a348f7b9d13c36916e73c2e1d85e4
In-Reply-To: <d60ce8dd3a383c7adbfc322bf1d53d81724a6000.1566311636.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] powerpc: rewrite LOAD_REG_IMMEDIATE() as an intelligent macro
Message-Id: <46JCM570Xkz9sP6@ozlabs.org>
Date:   Wed, 28 Aug 2019 14:24:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 14:34:12 UTC, Christophe Leroy wrote:
> Today LOAD_REG_IMMEDIATE() is a basic #define which loads all
> parts on a value into a register, including the parts that are NUL.
> 
> This means always 2 instructions on PPC32 and always 5 instructions
> on PPC64. And those instructions cannot run in parallele as they are
> updating the same register.
> 
> Ex: LOAD_REG_IMMEDIATE(r1,THREAD_SIZE) in head_64.S results in:
> 
> 3c 20 00 00     lis     r1,0
> 60 21 00 00     ori     r1,r1,0
> 78 21 07 c6     rldicr  r1,r1,32,31
> 64 21 00 00     oris    r1,r1,0
> 60 21 40 00     ori     r1,r1,16384
> 
> Rewrite LOAD_REG_IMMEDIATE() with GAS macro in order to skip
> the parts that are NUL.
> 
> Rename existing LOAD_REG_IMMEDIATE() as LOAD_REG_IMMEDIATE_SYM()
> and use that one for loading value of symbols which are not known
> at compile time.
> 
> Now LOAD_REG_IMMEDIATE(r1,THREAD_SIZE) in head_64.S results in:
> 
> 38 20 40 00     li      r1,16384
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c691b4b83b6a348f7b9d13c36916e73c2e1d85e4

cheers
