Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE75EC4B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfJBKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 06:36:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfJBKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F58voIL+IhUZVPadXrmnJLj6xw67FhutsLiNdI4zmjg=; b=dGPjuXQHrOalPLSCe1bSDd6pI
        Y/yuT9St2uyJSPKuBNFF5twIZPFbacZPrP56EnCVTQzvGdjjiysVbebmE312MvFiCag41ocNiD+ZQ
        mmGQSuZag2thweEaosI+tG4S3KvRjfM0x7FEhlGkdREnyg0L4hmGx6URFB0+zjhIF2bnLOuB9NVWf
        tdm9vBml1+MXZKiSX3195z5x/UQP9VxXtoggymVFslnEFv/wAhQSebvsxBl5eZk1jWXsVRnjJPMzs
        8WPPsqnbLXHAZbKha3QmpASSFwIHwZyfWyI9wkw64rPKLw2hkFat+3HQDdxuwZ7jfox4H2PQekNhm
        PomIT1qqQ==;
Received: from 177.157.127.95.dynamic.adsl.gvt.net.br ([177.157.127.95] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFbzs-0002ez-50; Wed, 02 Oct 2019 10:36:42 +0000
Date:   Wed, 2 Oct 2019 07:36:36 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jeremy MAURO <jeremy.mauro@gmail.com>
Cc:     j.mauro@criteo.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 2/2] scripts/sphinx-pre-install: Add a new path for the
 debian package "fonts-noto-cjk"
Message-ID: <20191002073636.68ad85de@coco.lan>
In-Reply-To: <20191002095406.9918-1-j.mauro@criteo.com>
References: <j.mauro@criteo.com>
        <20191002095406.9918-1-j.mauro@criteo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  2 Oct 2019 11:54:06 +0200
Jeremy MAURO <jeremy.mauro@gmail.com> escreveu:

> The latest debian version "bullseye/sid" has changed the path of the file
> "notoserifcjk-regular.ttc", with the previous change and this change we
> keep the backward compatibility and add the latest debian version
> 
> Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>
> ---
>  scripts/sphinx-pre-install | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index b5077ae63a4b..b5da4202155b 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -348,7 +348,8 @@ sub give_debian_hints()
>  		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
>  				   "fonts-dejavu", 2);
>  
> -		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
> +			"/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
>  				   "fonts-noto-cjk", 2);

Please align the second line, e. g:

		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
				    "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
 				   "fonts-noto-cjk", 2);



>  	}
>  



Thanks,
Mauro
