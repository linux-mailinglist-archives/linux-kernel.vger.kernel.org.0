Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52CE1804AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgCJRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:23:59 -0400
Received: from ms.lwn.net ([45.79.88.28]:44122 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJRX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:23:58 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C1AA82E4;
        Tue, 10 Mar 2020 17:23:57 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:23:56 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Clean up fall-through details
Message-ID: <20200310112356.1b5b32f2@lwn.net>
In-Reply-To: <202003041102.47A4E4B62@keescook>
References: <202003041102.47A4E4B62@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 11:03:24 -0800
Kees Cook <keescook@chromium.org> wrote:

> Add example of fall-through, list-ify the case ending statements, and
> adjust the markup for links and readability. While here, adjust
> strscpy() details to mention strscpy_pad().
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks.  But ...

> ---
>  Documentation/process/deprecated.rst | 48 +++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 179f2a5625a0..f9f196d3a69b 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -94,8 +94,8 @@ and other misbehavior due to the missing termination. It also NUL-pads the
>  destination buffer if the source contents are shorter than the destination
>  buffer size, which may be a needless performance penalty for callers using
>  only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
> -(Users of :c:func:`strscpy` still needing NUL-padding will need an
> -explicit :c:func:`memset` added.)
> +(Users of :c:func:`strscpy` still needing NUL-padding should instead
> +use strscpy_pad().)

:c:func: usage should really be stomped on when we encounter it.  There's
a few in this file; I'll tack on a quick patch making them go away.

jon
