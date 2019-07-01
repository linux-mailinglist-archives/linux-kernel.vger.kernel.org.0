Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07FD5700A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfFZRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:53:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:41052 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZRxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:53:07 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A9A3A4BF;
        Wed, 26 Jun 2019 17:53:06 +0000 (UTC)
Date:   Wed, 26 Jun 2019 11:53:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] docs: zh_CN: submitting-drivers.rst: Remove a
 duplicated Documentation/
Message-ID: <20190626115305.2802e1e7@lwn.net>
In-Reply-To: <47f81418930438d1deab8da1307bcd89ba9afd91.1561225663.git.mchehab+samsung@kernel.org>
References: <47f81418930438d1deab8da1307bcd89ba9afd91.1561225663.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019 14:47:46 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Somehow, this file ended with Documentation/ twice.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/translations/zh_CN/process/submitting-drivers.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
> index 72c6cd935821..72f4f45c98de 100644
> --- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
> +++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
> @@ -22,7 +22,7 @@
>  兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(http://www.xfree86.org/)
>  和／或 X.org 项目 (http://x.org)。
>  
> -另请参阅 Documentation/Documentation/translations/zh_CN/process/submitting-patches.rst 文档。
> +另请参阅 Documentation/translations/zh_CN/process/submitting-patches.rst 文档。

There is such a thing as too much Documentation! :)

Applied, thanks.

jon
