Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF02235C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfERLPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 07:15:06 -0400
Received: from ozlabs.org ([203.11.71.1]:41647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERLPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 07:15:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 455jHW4zv1z9s9y; Sat, 18 May 2019 21:15:03 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 672eaf37db9f99fd794eed2c68a8b3b05d484081
X-Patchwork-Hint: ignore
In-Reply-To: <20190515090750.30647-1-tobin@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Remove double free
Message-Id: <455jHW4zv1z9s9y@ozlabs.org>
Date:   Sat, 18 May 2019 21:15:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 09:07:50 UTC, "Tobin C. Harding" wrote:
> kfree() after kobject_put().  Who ever wrote this was on crack.
> 
> Fixes: 7e8039795a80 ("powerpc/cacheinfo: Fix kobject memleak")
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/672eaf37db9f99fd794eed2c68a8b3b0

cheers
