Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F74191C59
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 22:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgCXV5q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Mar 2020 17:57:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:16497 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgCXV5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:57:46 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 34630240006;
        Tue, 24 Mar 2020 21:57:40 +0000 (UTC)
Date:   Tue, 24 Mar 2020 22:57:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, bbrezillon@kernel.org,
        frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, allison@lohutok.net,
        linux-mtd@lists.infradead.org, yuehaibing@huawei.com
Subject: Re: [PATCH v4 2/2] mtd: rawnand: macronix: Add support for deep
 power down mode
Message-ID: <20200324225739.11538d08@xps13>
In-Reply-To: <1584517348-14486-3-git-send-email-masonccyang@mxic.com.tw>
References: <1584517348-14486-1-git-send-email-masonccyang@mxic.com.tw>
        <1584517348-14486-3-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Wed, 18 Mar 2020 15:42:28
+0800:

> Macronix AD series support deep power down mode for a minimum
> power consumption state.
> 
> Overload nand_suspend() & nand_resume() in Macronix specific code to
> support deep power down mode.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

This was not based on nand/next so as I applied changes in this files
(patches 1 and 2 of the original series) this patch did not apply. I
manually merged it.


Thanks,
Miquèl
