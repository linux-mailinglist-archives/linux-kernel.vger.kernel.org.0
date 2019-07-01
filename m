Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A775B585
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfGAHL7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Jul 2019 03:11:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44023 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfGAHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:11:59 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 95BAEC0009;
        Mon,  1 Jul 2019 07:11:53 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:11:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: stm32_fmc2: avoid warnings when building
 with W=1 option
Message-ID: <20190701091152.189ab62e@xps13>
In-Reply-To: <1561128189-14411-1-git-send-email-christophe.kerello@st.com>
References: <1561128189-14411-1-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Fri, 21 Jun
2019 16:43:09 +0200:

> This patch solves warnings detected by setting W=1 when building.
> 
> Warnings type detected:
> drivers/mtd/nand/raw/stm32_fmc2_nand.c: In function ‘stm32_fmc2_calc_timings’:
> drivers/mtd/nand/raw/stm32_fmc2_nand.c:1417:23: warning: comparison is
> always false due to limited range of data type [-Wtype-limits]
>   else if (tims->twait > FMC2_PMEM_PATT_TIMING_MASK)
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---

Applied to nand/next, thanks.

Miquèl
