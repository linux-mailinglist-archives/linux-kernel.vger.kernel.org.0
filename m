Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21C3BDCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404106AbfIYLFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 07:05:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390979AbfIYLFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:05:18 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46dZwF0gtJz9sPJ; Wed, 25 Sep 2019 21:05:17 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4c0f5d1eb4072871c34530358df45f05ab80edd6
In-Reply-To: <9f33f44b9cd741c4a02b3dce7b8ef9438fe2cd2a.1566382750.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/mm: Add a helper to select PAGE_KERNEL_RO or PAGE_READONLY
Message-Id: <46dZwF0gtJz9sPJ@ozlabs.org>
Date:   Wed, 25 Sep 2019 21:05:17 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 10:20:00 UTC, Christophe Leroy wrote:
> In a couple of places there is a need to select whether read-only
> protection of shadow pages is performed with PAGE_KERNEL_RO or with
> PAGE_READONLY.
> 
> Add a helper to avoid duplicating the choice.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: stable@vger.kernel.org

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4c0f5d1eb4072871c34530358df45f05ab80edd6

cheers
