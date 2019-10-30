Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABE3E9B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 13:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJ3MOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 08:14:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:14:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4736nk4Wzwz9sPj; Wed, 30 Oct 2019 23:14:18 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 29674a1c71be710f8418468aa6a8addd6d1aba1c
In-Reply-To: <1568733750-14580-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pkeys: remove unused pkey_allows_readwrite
Message-Id: <4736nk4Wzwz9sPj@ozlabs.org>
Date:   Wed, 30 Oct 2019 23:14:18 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 15:22:30 UTC, Qian Cai wrote:
> pkey_allows_readwrite() was first introduced in the commit 5586cf61e108
> ("powerpc: introduce execute-only pkey"), but the usage was removed
> entirely in the commit a4fcc877d4e1 ("powerpc/pkeys: Preallocate
> execute-only key").
> 
> Found by the "-Wunused-function" compiler warning flag.
> 
> Fixes: a4fcc877d4e1 ("powerpc/pkeys: Preallocate execute-only key")
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/29674a1c71be710f8418468aa6a8addd6d1aba1c

cheers
