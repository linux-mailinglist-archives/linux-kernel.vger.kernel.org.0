Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D677514C599
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA2FSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:18:20 -0500
Received: from ozlabs.org ([203.11.71.1]:33283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgA2FR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:29 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDm0x6Cz9sRl; Wed, 29 Jan 2020 16:17:28 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0f9aee0cb9da7db7d96f63cfa2dc5e4f1bffeb87
In-Reply-To: <0728849e826ba16f1fbd6fa7f5c6cc87bd64e097.1577087627.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: don't log user reads to 0xffffffff
Message-Id: <486sDm0x6Cz9sRl@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:28 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-23 at 07:54:22 UTC, Christophe Leroy wrote:
> Running vdsotest leaves many times the following log:
> 
> [   79.629901] vdsotest[396]: User access of kernel address (ffffffff) - exploit attempt? (uid: 0)
> 
> A pointer set to (-1) is likely a programming error similar to
> a NULL pointer and is not worth logging as an exploit attempt.
> 
> Don't log user accesses to 0xffffffff.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f9aee0cb9da7db7d96f63cfa2dc5e4f1bffeb87

cheers
