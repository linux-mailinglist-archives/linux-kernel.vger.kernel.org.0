Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5BF14C598
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgA2FSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:18:20 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgA2FRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:32 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDq0d8Qz9sS3; Wed, 29 Jan 2020 16:17:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 552aa086944a9aeabd599892007c2c7faedb894e
In-Reply-To: <1577900990-8588-11-git-send-email-Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] powerpc/powernv: use resource_size
Message-Id: <486sDq0d8Qz9sS3@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-01 at 17:49:50 UTC, Julia Lawall wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes these changes is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ struct resource ptr; @@
> - (ptr.end - ptr.start + 1)
> + resource_size(&ptr)
> </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/552aa086944a9aeabd599892007c2c7faedb894e

cheers
