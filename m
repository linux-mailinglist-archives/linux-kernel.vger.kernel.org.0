Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2431147477
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfFPMX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 08:23:57 -0400
Received: from ozlabs.org ([203.11.71.1]:37925 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfFPMX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 08:23:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45RYRZ4swBz9sNk; Sun, 16 Jun 2019 22:23:54 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e8732ffa2e096d433c3f2349b871d43ed0d39f5c
X-Patchwork-Hint: ignore
In-Reply-To: <c0ea3c32c7ed892501ddcc7a169948c305081551.1560433897.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/booke: fix fast syscall entry on SMP
Message-Id: <45RYRZ4swBz9sNk@ozlabs.org>
Date:   Sun, 16 Jun 2019 22:23:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-13 at 13:52:30 UTC, Christophe Leroy wrote:
> Use r10 instead of r9 to calculate CPU offset as r9 contains
> the value from SRR1 which is used later.
> 
> Fixes: 1a4b739bbb4f ("powerpc/32: implement fast entry for syscalls on BOOKE")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e8732ffa2e096d433c3f2349b871d43ed0d39f5c

cheers
