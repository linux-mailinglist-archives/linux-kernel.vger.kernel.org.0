Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AEFC221
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKNJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:08:02 -0500
Received: from ozlabs.org ([203.11.71.1]:50789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfKNJH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:59 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxn47blz9sS9; Thu, 14 Nov 2019 20:07:56 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 35a5c328fcf3493c5adf333d34c1ca6953fe372d
In-Reply-To: <20191023134423.15052-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <jk@ozlabs.org>,
        <arnd@arndb.de>, <benh@kernel.crashing.org>, <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/spufs: remove set but not used variable 'ctx'
Message-Id: <47DFxn47blz9sS9@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:56 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 13:44:23 UTC, YueHaibing wrote:
> arch/powerpc/platforms/cell/spufs/inode.c:201:22:
>  warning: variable ctx set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 67cba9fd6456 ("move
> spu_forget() into spufs_rmdir()")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/35a5c328fcf3493c5adf333d34c1ca6953fe372d

cheers
