Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD77E59E65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfF1PEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:04:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:35076 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfF1PEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:04:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B96BA2B4;
        Fri, 28 Jun 2019 15:04:39 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:04:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sheriff Esseson <sheriffesseson@gmail.com>
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: Re: [linux-kernel-mentees] [PATCH v2] Doc : doc-guide : Fix a typo
Message-ID: <20190628090438.017d70a7@lwn.net>
In-Reply-To: <20190628062001.26085-1-sheriffesseson@gmail.com>
References: <20190628060648.25151-1-sheriffesseson@gmail.com>
        <20190628062001.26085-1-sheriffesseson@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 07:20:01 +0100
Sheriff Esseson <sheriffesseson@gmail.com> wrote:

> fix the disjunction by replacing "of" with "or".
> 
> Signed-off-by: Sheriff Esseson <sheriffesseson@gmail.com>
> ---
> 
> changes in v2:
> - cc-ed Corbet.
> 
>  Documentation/doc-guide/kernel-doc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index f96059767..192c36af3 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -359,7 +359,7 @@ Domain`_ references.
>    ``monospaced font``.
>  
>    Useful if you need to use special characters that would otherwise have some
> -  meaning either by kernel-doc script of by reStructuredText.
> +  meaning either by kernel-doc script or by reStructuredText.
>  
>    This is particularly useful if you need to use things like ``%ph`` inside
>    a function description.

I have applied this, thanks.

jon
