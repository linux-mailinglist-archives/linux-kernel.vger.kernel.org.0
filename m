Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C518F14C589
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgA2FRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:42 -0500
Received: from ozlabs.org ([203.11.71.1]:59577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgA2FRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:38 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDw3HcXz9sRR; Wed, 29 Jan 2020 16:17:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d80ae83f1f932ab7af47b54d0d3bef4f4dba489f
In-Reply-To: <0d894839fdbb19070f0e1e4140363be4f2bb62fc.1578989540.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptdump: fix W+X verification
Message-Id: <486sDw3HcXz9sRR@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 08:13:09 UTC, Christophe Leroy wrote:
> Verification cannot rely on simple bit checking because on some
> platforms PAGE_RW is 0, checking that a page is not W means
> checking that PAGE_RO is set instead of checking that PAGE_RW
> is not set.
> 
> Use pte helpers instead of checking bits.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d80ae83f1f932ab7af47b54d0d3bef4f4dba489f

cheers
