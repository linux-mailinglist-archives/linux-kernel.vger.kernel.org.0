Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056C616428E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 05:50:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:33788 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSKuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:50:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 17E0D2DC;
        Wed, 19 Feb 2020 10:49:58 +0000 (UTC)
Date:   Wed, 19 Feb 2020 03:49:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     federico.vaga@vaga.pv.it, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace dead urls with active urls for Mutt
Message-ID: <20200219034953.4e5b7ead@lwn.net>
In-Reply-To: <20200218094013.29806-1-unixbhaskar@gmail.com>
References: <20200218094013.29806-1-unixbhaskar@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 15:10:13 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> This patch replace stale/dead urls with active urls for Mutt.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/process/email-clients.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

OK, for future reference...

 - The subject should read [PATCH v2] since this is the second version of
   the patch.
 - Tell us about what changed since the first version below the "---"
   line.

> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
> index 5273d06c8ff6..c4f9dc7a0889 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
> @@ -237,9 +237,9 @@ using Mutt to send patches through Gmail::
> 
>  The Mutt docs have lots more information:
> 
> -    http://dev.mutt.org/trac/wiki/UseCases/Gmail
> +    https://gitlab.com/muttmua/mutt/-/wikis/UseCases/Gmail
> 
> -    http://dev.mutt.org/doc/manual.html
> +    http://www.mutt.org/doc/manual/
> 
>  Pine (TUI)
>  **********
> --
> 2.24.1

That said, working URLs are certainly an improvement over dead ones, so
I've applied this, thanks.

jon
