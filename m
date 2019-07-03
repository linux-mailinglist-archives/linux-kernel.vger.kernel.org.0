Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97475E695
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfGCO1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:27:08 -0400
Received: from ozlabs.org ([203.11.71.1]:48195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfGCO1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45f3Mr1jKVz9sBp; Thu,  4 Jul 2019 00:27:03 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 04db3ede40ae4fc23a5c4237254c4a53bbe4c1f2
In-Reply-To: <1559829493-28457-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        paulus@samba.org, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/cacheflush: fix variable set but not used
Message-Id: <45f3Mr1jKVz9sBp@ozlabs.org>
Date:   Thu,  4 Jul 2019 00:27:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 13:58:13 UTC, Qian Cai wrote:
> The powerpc's flush_cache_vmap() is defined as a macro and never use
> both of its arguments, so it will generate a compilation warning,
> 
> lib/ioremap.c: In function 'ioremap_page_range':
> lib/ioremap.c:203:16: warning: variable 'start' set but not used
> [-Wunused-but-set-variable]
> 
> Fix it by making it an inline function.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/04db3ede40ae4fc23a5c4237254c4a53bbe4c1f2

cheers
