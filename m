Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04843FC222
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKNJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:08:06 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57841 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfKNJIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxp4XN4z9sSK; Thu, 14 Nov 2019 20:07:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d273fa919c39223a1edd968e82ea88501b63d21a
In-Reply-To: <20191023134838.21280-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <mahesh@linux.vnet.ibm.com>,
        <ganeshgr@linux.ibm.com>, <yuehaibing@huawei.com>,
        <gregkh@linuxfoundation.org>, <npiggin@gmail.com>,
        <tglx@linutronix.de>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] powerpc/pseries: Use correct event modifier in rtas_parse_epow_errlog()
Message-Id: <47DFxp4XN4z9sSK@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:58 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 13:48:38 UTC, YueHaibing wrote:
> rtas_parse_epow_errlog() should pass 'modifier' to
> handle_system_shutdown, because event modifier only use
> bottom 4 bits.
> 
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d273fa919c39223a1edd968e82ea88501b63d21a

cheers
