Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243971284F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfECG7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:20 -0400
Received: from ozlabs.org ([203.11.71.1]:36331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfECG7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKF4yxqz9sB8; Fri,  3 May 2019 16:59:13 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 32eeb5614d3bf166e84fe69bb5f3a51a48cac7a1
X-Patchwork-Hint: ignore
In-Reply-To: <20190329154456.27152-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>, <fbarrat@linux.ibm.com>,
        <andrew.donnellan@au1.ibm.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ocxl: remove set but not used variables 'tid' and 'lpid'
Message-Id: <44wNKF4yxqz9sB8@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:13 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 15:44:56 UTC, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/misc/ocxl/link.c: In function 'xsl_fault_handler':
> drivers/misc/ocxl/link.c:187:17: warning: variable 'tid' set but not used [-Wunused-but-set-variable]
> drivers/misc/ocxl/link.c:187:6: warning: variable 'lpid' set but not used [-Wunused-but-set-variable]
> 
> They are never used and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/32eeb5614d3bf166e84fe69bb5f3a51a

cheers
