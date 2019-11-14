Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D56CFC21B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKNJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:07:43 -0500
Received: from ozlabs.org ([203.11.71.1]:45759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfKNJHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:41 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxQ70shz9s7T; Thu, 14 Nov 2019 20:07:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c312d14e19bb7ca8214ef661d9a125cd631528cb
In-Reply-To: <20190711141818.18044-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <aik@ozlabs.ru>, <david@gibson.dropbear.id.au>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/powernv/ioda: using kfree_rcu() to simplify the code
Message-Id: <47DFxQ70shz9s7T@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 14:18:18 UTC, YueHaibing wrote:
> The callback function of call_rcu() just calls a kfree(), so we
> can use kfree_rcu() instead of call_rcu() + callback function.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c312d14e19bb7ca8214ef661d9a125cd631528cb

cheers
