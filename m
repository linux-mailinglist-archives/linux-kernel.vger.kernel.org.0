Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190E4108C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfKYKrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 05:47:03 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfKYKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3cz3vTsz9sR5; Mon, 25 Nov 2019 21:46:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b06174345f6e70200916136695514e0b6b95ac17
In-Reply-To: <ac19713826fa55e9e7bfe3100c5a7b1712ab9526.1566999711.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/reg: use ASM_FTR_IFSET() instead of opencoding fixup.
Message-Id: <47M3cz3vTsz9sR5@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:46:59 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 13:42:01 UTC, Christophe Leroy wrote:
> mftb() includes a feature fixup for CELL ppc.
> 
> Use ASM_FTR_IFSET() macro instead of opencoding the setup
> of the fixup sections.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b06174345f6e70200916136695514e0b6b95ac17

cheers
