Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B7160DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 10:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgBQJEd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Feb 2020 04:04:33 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47779 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgBQJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:04:32 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C25D3FF805;
        Mon, 17 Feb 2020 09:04:30 +0000 (UTC)
Date:   Mon, 17 Feb 2020 10:04:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spinand: toshiba: Support for new Kioxia Serial
 NAND
Message-ID: <20200217100430.420142a3@xps13>
In-Reply-To: <1581907305-3606-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
References: <1581907305-3606-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
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

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Mon, 17 Feb
2020 11:41:45 +0900:

> From: Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
> 
> Add support for new Kioxia products.
> The new Kioxia products support program load x4 command, and have HOLD_D bit
> which is equivalent to QE bit.
> Also, generalize prefix names of structures and functions.

Would you mind splitting this patch?

1/ Rename the current functions (and explain why)
2/ Add new Kioxia parts support.

Thanks,
Miquèl
