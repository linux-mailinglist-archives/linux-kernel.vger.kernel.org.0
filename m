Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502EF37BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfFFSGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 14:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfFFSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:06:02 -0400
Received: from linux-8ccs (ip5f5ade8c.dynamic.kabel-deutschland.de [95.90.222.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475B920868;
        Thu,  6 Jun 2019 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559844362;
        bh=bMlplyiH+PKr+bX7ZgbQvU1nviSGlkJZkRJ8OqOqy/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceO0L12vc87mtQrwEEUDdAGEHtNt3f5ie5LUMzPUn/paO6ytZXNyCfaNl7OdHSAdS
         mgojHde4I0uhLmkXypwuy8LC4MA8MpkW2dIJAIwyTju20Q1pNgWll0C3QTynwiw6YO
         ywCud39RrIz3zfYK8JwrS0evskkxT0qBxkL+6Dh4=
Date:   Thu, 6 Jun 2019 20:05:57 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: module: Use struct_size() helper
Message-ID: <20190606180557.GA4690@linux-8ccs>
References: <20190604232343.GA2475@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190604232343.GA2475@embeddedor>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Gustavo A. R. Silva [04/06/19 18:23 -0500]:
>Make use of the struct_size() helper instead of an open-coded version
>in order to avoid any potential type mistakes, in particular in the
>context in which this code is being used.
>
>So, replace the following form:
>
>sizeof(*sect_attrs) + nloaded * sizeof(sect_attrs->attrs[0]
>
>with:
>
>struct_size(sect_attrs, attrs, nloaded)
>
>This code was detected with the help of Coccinelle.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Hi Gustavo!

I see you've sent similar cleanup patches elsewhere, do you think you
could reword your commit message to be more similar to your patch here
for instance:

	https://lkml.org/lkml/2019/6/5/856

It does a *much* better job of explaining the motivation and usage of
struct_size().

Thank you!

Jessica

>---
> kernel/module.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 80c7c09584cf..3f3bb090fbf4 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -1492,8 +1492,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
> 	for (i = 0; i < info->hdr->e_shnum; i++)
> 		if (!sect_empty(&info->sechdrs[i]))
> 			nloaded++;
>-	size[0] = ALIGN(sizeof(*sect_attrs)
>-			+ nloaded * sizeof(sect_attrs->attrs[0]),
>+	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
> 			sizeof(sect_attrs->grp.attrs[0]));
> 	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.attrs[0]);
> 	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
>-- 
>2.21.0
>
