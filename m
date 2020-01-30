Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2414D78C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 09:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA3Iav convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jan 2020 03:30:51 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39951 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3Iav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:30:51 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0C80B1BF219;
        Thu, 30 Jan 2020 08:30:48 +0000 (UTC)
Date:   Thu, 30 Jan 2020 09:30:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH 1/4] mtd: spinand: Generalize the OOB layout structure
 and function names
Message-ID: <20200130093048.5f196495@xps13>
In-Reply-To: <20200119145432.10405-2-sshivamurthy@micron.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
        <20200119145432.10405-2-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Sun, 19 Jan 2020 15:54:29 +0100:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 

I would also prefix the commit with "mtd: spinand: micron:".

> In order to add new Micron SPI NAND devices, we generalized the OOB
> layout structure and function names.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>

Thanks,
Miquèl
