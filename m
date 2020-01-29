Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4825014C593
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgA2FRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:35 -0500
Received: from ozlabs.org ([203.11.71.1]:42489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgA2FRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDn1mr8z9sSD; Wed, 29 Jan 2020 16:17:29 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 30e813cf46ccaeea6508607632e49b4a1d743d2a
In-Reply-To: <1577634178-22530-2-git-send-email-Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Frederic Barrat <fbarrat@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] misc: cxl: use mmgrab
Message-Id: <486sDn1mr8z9sSD@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:29 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-12-29 at 15:42:55 UTC, Julia Lawall wrote:
> Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
> helper") and most of the kernel was updated to use it. Update a
> remaining file.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ expression e; @@
> - atomic_inc(&e->mm_count);
> + mmgrab(e);
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/30e813cf46ccaeea6508607632e49b4a1d743d2a

cheers
