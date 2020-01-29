Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5014C594
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgA2FRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:35 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:31 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDp3hCcz9sSG; Wed, 29 Jan 2020 16:17:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bfbe37f0ce994e7a9945653d7624fadc5c500a9f
In-Reply-To: <1577900990-8588-6-git-send-email-Julia.Lawall@inria.fr>
To:     Julia Lawall <Julia.Lawall@inria.fr>, Scott Wood <oss@buserror.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/10] powerpc/83xx: use resource_size
Message-Id: <486sDp3hCcz9sSG@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-01 at 17:49:45 UTC, Julia Lawall wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes this change is as follows:
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

https://git.kernel.org/powerpc/c/bfbe37f0ce994e7a9945653d7624fadc5c500a9f

cheers
