Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6B14C595
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgA2FSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:18:05 -0500
Received: from ozlabs.org ([203.11.71.1]:54909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgA2FRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:41 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDz55YZz9sRp; Wed, 29 Jan 2020 16:17:39 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3d4247fcc938d0ab5cf6fdb752dae07fdeab9736
In-Reply-To: <031dec5487bde9b2181c8b3c9800e1879cf98c1a.1579024426.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org,
        dja@axtens.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/32: add support of KASAN_VMALLOC
Message-Id: <486sDz55YZz9sRp@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:39 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 17:54:00 UTC, Christophe Leroy wrote:
> Add support of KASAN_VMALLOC on PPC32.
> 
> To allow this, the early shadow covering the VMALLOC space
> need to be removed once high_memory var is set and before
> freeing memblock.
> 
> And the VMALLOC area need to be aligned such that boundaries
> are covered by a full shadow page.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3d4247fcc938d0ab5cf6fdb752dae07fdeab9736

cheers
