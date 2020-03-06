Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61A17B2E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCFA1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:37 -0500
Received: from ozlabs.org ([203.11.71.1]:43561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCFA1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:35 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT396mMRz9sSR; Fri,  6 Mar 2020 11:27:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0b1c524caaae2428b20e714297243e5551251eb5
In-Reply-To: <7b065c5be35726af4066cab238ee35cabceda1fa.1578558199.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mike Rapoport <rppt@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc/32: refactor pmd_offset(pud_offset(pgd_offset...
Message-Id: <48YT396mMRz9sSR@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-09 at 08:25:25 UTC, Christophe Leroy wrote:
> At several places pmd pointer is retrieved through the same action:
> 
> 	pmd = pmd_offset(pud_offset(pgd_offset(mm, addr), addr), addr);
> 
> or
> 
> 	pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> 
> Refactor this by implementing two helpers pmd_ptr() and pmd_ptr_k()
> 
> This will help when adding the p4d level.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0b1c524caaae2428b20e714297243e5551251eb5

cheers
