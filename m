Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA312841
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 09:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfECG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:30 -0400
Received: from ozlabs.org ([203.11.71.1]:40339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbfECG73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:29 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKW0jBxz9sPT; Fri,  3 May 2019 16:59:26 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7e8039795a80bdf1418964b9cabef6168bc5d9a4
X-Patchwork-Hint: ignore
In-Reply-To: <20190430010923.17092-1-tobin@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix kobject memleak
Message-Id: <44wNKW0jBxz9sPT@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:26 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-30 at 01:09:23 UTC, "Tobin C. Harding" wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7e8039795a80bdf1418964b9cabef616

cheers
