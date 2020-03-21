Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61EB18E0B9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgCULhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 07:37:55 -0400
Received: from ozlabs.org ([203.11.71.1]:39969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgCULhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:37:54 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48kzCg4YfDz9sSg; Sat, 21 Mar 2020 22:37:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: af3d0a68698c7e5df8b72267086b23422a3954bb
In-Reply-To: <ef5248fc1f496c6b0dfdb59380f24968f25f75c5.1583513368.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/kasan: Fix shadow memory protection with CONFIG_KASAN_VMALLOC
Message-Id: <48kzCg4YfDz9sSg@ozlabs.org>
Date:   Sat, 21 Mar 2020 22:37:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 16:49:49 UTC, Christophe Leroy wrote:
> With CONFIG_KASAN_VMALLOC, new page tables are created at the time
> shadow memory for vmalloc area in unmapped. If some parts of the
> page table still has entries to the zero page shadow memory, the
> entries are wrongly marked RW.
> 
> With CONFIG_KASAN_VMALLOC, almost the entire kernel address space
> is managed by KASAN. To make it simple, just create KASAN page tables
> for the entire kernel space at kasan_init(). That doesn't use much
> more space, and that's anyway already done for hash platforms.
> 
> Fixes: 3d4247fcc938 ("powerpc/32: Add support of KASAN_VMALLOC")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/af3d0a68698c7e5df8b72267086b23422a3954bb

cheers
