Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3914B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfEFNyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:54:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfEFNyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:54:09 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44yPNc02JSz9s5c; Mon,  6 May 2019 23:54:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 305d60012304684bd59ea1f67703e51662e4906a
X-Patchwork-Hint: ignore
In-Reply-To: <421c0ebaf1287af30cc89389c9de57387b8a1a6f.1557123375.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kasan: add missing/lost Makefile
Message-Id: <44yPNc02JSz9s5c@ozlabs.org>
Date:   Mon,  6 May 2019 23:54:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 06:21:00 UTC, Christophe Leroy wrote:
> For unknown reason, the new Makefile added via the KASAN suppot patch
> didn't land into arch/powerpc/mm/kasan/
> 
> This patch restores it.
> 
> Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/305d60012304684bd59ea1f67703e516

cheers
