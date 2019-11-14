Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4EFC23B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKNJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:08:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfKNJIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyW0zdDz9sSK; Thu, 14 Nov 2019 20:08:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 11dd34f3eae5a468013bb161a1dcf1fecd2ca321
In-Reply-To: <20190218125644.87448-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/pseries: Drop pointless static qualifier in vpa_debugfs_init()
Message-Id: <47DFyW0zdDz9sSK@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:34 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 12:56:44 UTC, YueHaibing wrote:
> There is no need to have the 'struct dentry *vpa_dir' variable static
> since new value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11dd34f3eae5a468013bb161a1dcf1fecd2ca321

cheers
