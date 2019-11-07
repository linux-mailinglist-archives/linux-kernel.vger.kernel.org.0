Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CEDF261D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 04:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfKGDpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 22:45:38 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43831 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfKGDpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:45:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 477q730DhKz9sR3; Thu,  7 Nov 2019 14:45:35 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5c74f79958682fccd82a6029c53859d1dab3b239
In-Reply-To: <20181208154624.6504-1-malat@debian.org>
To:     Mathieu Malaterre <malat@debian.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
Message-Id: <477q730DhKz9sR3@ozlabs.org>
Date:   Thu,  7 Nov 2019 14:45:35 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-08 at 15:46:23 UTC, Mathieu Malaterre wrote:
> `pt_regs_check` is a dummy function, its purpose is to break the build
> if struct pt_regs and struct user_pt_regs don't match.
> 
> This function has no functionnal purpose, and will get eliminated at
> link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> 
> This commit adds a prototype to fix warning at W=1:
> 
>   arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for ‘pt_regs_check’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5c74f79958682fccd82a6029c53859d1dab3b239

cheers
