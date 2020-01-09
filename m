Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C1136114
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgAITa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:30:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgAITa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:30:59 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 19D4E2934E8;
        Thu,  9 Jan 2020 19:30:58 +0000 (GMT)
Date:   Thu, 9 Jan 2020 20:30:55 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operatoin
Message-ID: <20200109203055.2370a358@collabora.com>
In-Reply-To: <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>
        <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 17:55:24 +0800
Mason Yang <masonccyang@mxic.com.tw> wrote:

>  /* Set default functions */
>  static void nand_set_defaults(struct nand_chip *chip)
>  {
> @@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip *chip)
>  	mtd->_read_oob = nand_read_oob;
>  	mtd->_write_oob = nand_write_oob;
>  	mtd->_sync = nand_sync;
> -	mtd->_lock = NULL;
> -	mtd->_unlock = NULL;
> +	mtd->_lock = nand_lock;
> +	mtd->_unlock = nand_unlock;
>  	mtd->_suspend = nand_suspend;
>  	mtd->_resume = nand_resume;
>  	mtd->_reboot = nand_shutdown;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 4ab9bcc..2430ecd 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1136,6 +1136,9 @@ struct nand_chip {
>  		const struct nand_manufacturer *desc;
>  		void *priv;
>  	} manufacturer;
> +
> +	int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> +	int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);

Please drop this _ prefix.

>  };
