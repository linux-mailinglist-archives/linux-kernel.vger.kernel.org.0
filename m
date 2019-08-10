Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2C888AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfHJKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 06:20:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfHJKUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 06:20:36 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 465J5t6lLxz9sNx; Sat, 10 Aug 2019 20:20:34 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 461cef2a676e7c578d0ef62969dbcb8237c8631d
In-Reply-To: <a682a2f9db308c5cfe77e45aa3352e41bc9f4e33.1564554634.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/32: activate ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE
Message-Id: <465J5t6lLxz9sNx@ozlabs.org>
Date:   Sat, 10 Aug 2019 20:20:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 06:31:41 UTC, Christophe Leroy wrote:
> PPC32 also have flush_dcache_range() so it can also support
> ARCH_HAS_PMEM_API and ARCH_HAS_UACCESS_FLUSHCACHE without changes.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/461cef2a676e7c578d0ef62969dbcb8237c8631d

cheers
