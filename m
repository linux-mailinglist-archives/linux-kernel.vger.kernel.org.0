Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC517DF0B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCILwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Mar 2020 07:52:42 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56437 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:52:42 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4492A1C0013;
        Mon,  9 Mar 2020 11:52:40 +0000 (UTC)
Date:   Mon, 9 Mar 2020 12:52:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 0/2] mtd: spinand: toshiba: Support for new Kioxia
 Serial NAND
Message-ID: <20200309125239.39879af3@xps13>
In-Reply-To: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1583371913.git.ytc-mb-yfuruyama7@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Fri,  6 Mar
2020 12:08:21 +0900:

> First patch is to rename function name becase of add new device.
> Second patch is to supprot for new device.
> 
> Yoshio Furuyama (2):
>   mtd: spinand: toshiba: Rename function name to change suffix and
>     prefix (8Gbit)
>   mtd: spinand: toshiba: Support for new Kioxia Serial NAND
> 
>  drivers/mtd/nand/spi/toshiba.c | 173 +++++++++++++++++++++++++++++++----------
>  1 file changed, 130 insertions(+), 43 deletions(-)
> 

Please be careful when sending your series: I received the cover
letter, then twice patch 2/2 then patch 1/2.

Also, I cannot apply this series as-is, please rebase on top of the
last -rc.

I'll apply these patches as soon as you resend.

Thanks,
Miquèl
