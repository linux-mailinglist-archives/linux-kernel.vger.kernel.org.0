Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C428758782
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0Qpf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jun 2019 12:45:35 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37073 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0Qpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:45:34 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BE169C0004;
        Thu, 27 Jun 2019 16:45:29 +0000 (UTC)
Date:   Thu, 27 Jun 2019 18:45:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: onenand_base: Mark expected switch fall-through
Message-ID: <20190627184526.0b09d169@xps13>
In-Reply-To: <bc5e1a62-9034-f668-c694-cc6d7e69c114@embeddedor.com>
References: <20190604141737.GA1064@embeddedor>
        <201906040745.B6AE4C6@keescook>
        <bc5e1a62-9034-f668-c694-cc6d7e69c114@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Wed, 26 Jun
2019 13:16:22 -0500:

> Hi all,
> 
> Friendly ping:
> 
> Who can take this?

I am queuing it right now, please be patient.

Also for next time, the prefix should have been "mtd: onenand:" but
that's ok, I edited the title.


Thanks,
Miquèl
