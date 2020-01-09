Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A5135F48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgAIR2L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jan 2020 12:28:11 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46909 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgAIR2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:11 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 974F5C0014;
        Thu,  9 Jan 2020 17:28:08 +0000 (UTC)
Date:   Thu, 9 Jan 2020 18:28:07 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kamal.dasu@broadcom.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
Message-ID: <20200109182807.04c8866a@xps13>
In-Reply-To: <CAKekbeucdjZgttQfHeiXH6S92He2qkKGsQcEqz_4_okHzDK16A@mail.gmail.com>
References: <20191021193343.41320-1-kdasu.kdev@gmail.com>
        <20191105200344.1e8c3eab@xps13>
        <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
        <20200109160352.6080e1e5@xps13>
        <CAKekbeucdjZgttQfHeiXH6S92He2qkKGsQcEqz_4_okHzDK16A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kamal.dasu@broadcom.com> wrote on Thu, 9 Jan 2020 10:25:59
-0500:

> Miquel,
> 
> Yes the issue is still open. I was trying to understand the suggestion
> and did not get a reply on the question I had
> 
> Richard wrote :
> "So the right fix would be setting the parent's oops_panic_write in
> mtd_panic_write().
> Then we don't have to touch mtdpart.c"
> 
> How do I get access to the parts parent in the core ?. Maybe I am
> missing something.

I think the solution is to set the oops_panic_write of the root parent, instead of updating the flag of the mtd device itself (which is maybe a partition).

Would this help?

https://www.spinics.net/lists/linux-mtd/msg10454.html

Thanks,
Miquèl
