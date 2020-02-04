Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538AA151A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 13:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBDMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 07:01:41 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgBDMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:01:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48BjwK1mspzB3x2; Tue,  4 Feb 2020 23:01:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 41196224883a64e56e0ef237c19eb837058df071
In-Reply-To: <fc8390a33c2a470105f01abbcbdc7916c30c0a54.1580301269.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Fix kasan_early_hash_table() for CONFIG_VMAP_STACK
Message-Id: <48BjwK1mspzB3x2@ozlabs.org>
Date:   Tue,  4 Feb 2020 23:01:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-29 at 12:34:36 UTC, Christophe Leroy wrote:
> On book3s/32 CPUs that are handling MMU through a hash table,
> MMU_init_hw() function was adapted for VMAP_STACK in order to
> handle virtual addresses instead of physical addresses in the
> low level hash functions.
> 
> When using KASAN, the same adaptations are required for the
> early hash table set up by kasan_early_hash_table() function.
> 
> Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/41196224883a64e56e0ef237c19eb837058df071

cheers
