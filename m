Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3BC12856
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfECHAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 03:00:42 -0400
Received: from ozlabs.org ([203.11.71.1]:50723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfECG7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNK86wm5z9sNC; Fri,  3 May 2019 16:59:08 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a5ae043de7678f189303559782f6057078459a41
X-Patchwork-Hint: ignore
In-Reply-To: <20190313200030.19145-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/64s: Remove 'dummy_copy_buffer'
Message-Id: <44wNK86wm5z9sNC@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 20:00:30 UTC, Mathieu Malaterre wrote:
> In commit 2bf1071a8d50 ("powerpc/64s: Remove POWER9 DD1 support") the
> function __switch_to remove usage for 'dummy_copy_buffer'. Since it is
> not used anywhere else, remove it completely.
> 
> This remove the following warning:
> 
>   arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a5ae043de7678f189303559782f60570

cheers
