Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98DD16446E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBSMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 07:39:59 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgBSMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:39:56 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48My3Z3flnz9sSP; Wed, 19 Feb 2020 23:39:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 50a175dd18de7a647e72aca7daf4744e3a5a81e3
In-Reply-To: <778b1a248c4c7ca79640eeff7740044da6a220a0.1581264115.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/hugetlb: Fix 8M hugepages on 8xx
Message-Id: <48My3Z3flnz9sSP@ozlabs.org>
Date:   Wed, 19 Feb 2020 23:39:53 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 16:02:41 UTC, Christophe Leroy wrote:
> With HW assistance all page tables must be 4k aligned, the 8xx
> drops the last 12 bits during the walk.
> 
> Redefine HUGEPD_SHIFT_MASK to mask last 12 bits out.
> HUGEPD_SHIFT_MASK is used to for alignment of page table cache.
> 
> Fixes: 22569b881d37 ("powerpc/8xx: Enable 8M hugepage support with HW assistance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/50a175dd18de7a647e72aca7daf4744e3a5a81e3

cheers
