Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906B0182250
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgCKTa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:30:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:52692 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731187AbgCKTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:30:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57C1F2E4;
        Wed, 11 Mar 2020 19:30:28 +0000 (UTC)
Date:   Wed, 11 Mar 2020 13:30:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     peter@bikeshed.quignogs.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] Added double colons and blank lines within
 kerneldoc to format code snippets as ReST literal blocks.
Message-ID: <20200311133027.2c77f348@lwn.net>
In-Reply-To: <20200311192256.15911-2-peter@bikeshed.quignogs.org.uk>
References: <20200311192256.15911-1-peter@bikeshed.quignogs.org.uk>
        <20200311192256.15911-2-peter@bikeshed.quignogs.org.uk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 19:22:56 +0000
peter@bikeshed.quignogs.org.uk wrote:

> From: Peter Lister <peter@bikeshed.quignogs.org.uk>
> 
> This removes the following warnings from the kernel doc build...
> ./drivers/base/platform.c:134: WARNING: Unexpected indentation.
> ./drivers/base/platform.c:213: WARNING: Unexpected indentation.
> 
> Signed-off-by: Peter Lister <peter@bikeshed.quignogs.org.uk>
> ---
>  drivers/base/platform.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..7fb5cf847253 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -128,7 +128,8 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
>   * request_irq() APIs. This is the same as platform_get_irq(), except that it
>   * does not print an error message if an IRQ can not be obtained.
>   *
> - * Example:
> + * Example: ::
> + *

The change seems good, but you can make it just:

 * Example::

...and keep it a bit more readable.

Thanks,

jon
