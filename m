Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFD1283A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 08:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfECG7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 02:59:17 -0400
Received: from ozlabs.org ([203.11.71.1]:50723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfECG7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:13 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKD4ZS9z9sBb; Fri,  3 May 2019 16:59:12 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 71faf8145cdc20f22aa398eb7b206b33826cf2bd
X-Patchwork-Hint: ignore
In-Reply-To: <a048e3619ef2c378d075f46119ff5b7091320ecc.1553779159.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/nohash64: clean pgtable.h
Message-Id: <44wNKD4ZS9z9sBb@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 13:19:47 UTC, Christophe Leroy wrote:
> TRANSPARENT_HUGEPAGE is only supported by book3s
> 
> VMEMMAP_REGION_ID is never used
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/71faf8145cdc20f22aa398eb7b206b33

cheers
