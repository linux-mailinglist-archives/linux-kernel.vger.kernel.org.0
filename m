Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEF99489
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbfHVNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:09:10 -0400
Received: from ozlabs.org ([203.11.71.1]:59447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388929AbfHVNJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:06 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGn0WwZz9sPX; Thu, 22 Aug 2019 23:09:04 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ad628a34ec4e3558bf838195f60bbaa4c2b68f2a
In-Reply-To: <f6267226038cb25a839b567319e240576e3f8565.1565793287.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: don't display empty early ioremap area
Message-Id: <46DlGn0WwZz9sPX@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:04 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-14 at 14:36:10 UTC, Christophe Leroy wrote:
> On the 8xx, the layout displayed at boot is:
> 
> [    0.000000] Memory: 121856K/131072K available (5728K kernel code, 592K rwdata, 1248K rodata, 560K init, 448K bss, 9216K reserved, 0K cma-reserved)
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xffefc000..0xffffc000  : fixmap
> [    0.000000]   * 0xffefc000..0xffefc000  : early ioremap
> [    0.000000]   * 0xc9000000..0xffefc000  : vmalloc & ioremap
> [    0.000000] SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> 
> Remove display of an empty early ioremap.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ad628a34ec4e3558bf838195f60bbaa4c2b68f2a

cheers
