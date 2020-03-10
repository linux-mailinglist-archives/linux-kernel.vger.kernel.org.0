Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A718049C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCJRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:17:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:44048 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgCJRR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:17:57 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 851432E4;
        Tue, 10 Mar 2020 17:17:56 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:17:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: it_IT: netdev-FAQ: Fix link to original document
Message-ID: <20200310111755.31b5c0a3@lwn.net>
In-Reply-To: <20200305205123.8569-1-j.neuschaefer@gmx.net>
References: <20200305205123.8569-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Mar 2020 21:51:21 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/translations/it_IT/networking/netdev-FAQ.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/it_IT/networking/netdev-FAQ.rst b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
> index 8489ead7cff1..7e2456bb7d92 100644
> --- a/Documentation/translations/it_IT/networking/netdev-FAQ.rst
> +++ b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
> 
> -:Original: :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
> +:Original: :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
> 
>  .. _it_netdev-FAQ:
> 
> --
> 2.20.1
> 
Applied, thanks.

jon
