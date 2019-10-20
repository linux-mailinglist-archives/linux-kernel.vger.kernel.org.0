Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7EDDD70
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 11:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfJTJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 05:09:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfJTJJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 05:09:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46wv9b25JSz9sPK; Sun, 20 Oct 2019 20:09:55 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d10f60ae27d26d811e2a1bb39ded47df96d7499f
In-Reply-To: <067a1b09f15f421d40797c2d04c22d4049a1cee8.1571071875.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix allow/prevent_user_access() when crossing segment boundaries.
Message-Id: <46wv9b25JSz9sPK@ozlabs.org>
Date:   Sun, 20 Oct 2019 20:09:55 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 16:51:28 UTC, Christophe Leroy wrote:
> Make sure starting addr is aligned to segment boundary so that when
> incrementing the segment, the starting address of the new segment is
> below the end address. Otherwise the last segment might get  missed.
> 
> Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d10f60ae27d26d811e2a1bb39ded47df96d7499f

cheers
