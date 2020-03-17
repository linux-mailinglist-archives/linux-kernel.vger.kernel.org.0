Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44A188512
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCQNOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:14:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgCQNOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:14:51 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48hYYP2Xwpz9sSW; Wed, 18 Mar 2020 00:14:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a4037d1f1fc4e92b69d7196d4568c33078d465ea
In-Reply-To: <20200303085604.24952-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <christophe.leroy@c-s.fr>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] powerpc/pmac/smp: drop unnecessary volatile qualifier
Message-Id: <48hYYP2Xwpz9sSW@ozlabs.org>
Date:   Wed, 18 Mar 2020 00:14:49 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-03 at 08:56:04 UTC, YueHaibing wrote:
> core99_l2_cache/core99_l3_cache no need to mark as volatile,
> just remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a4037d1f1fc4e92b69d7196d4568c33078d465ea

cheers
