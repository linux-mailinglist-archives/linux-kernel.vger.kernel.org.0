Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC62CC006
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfJDQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 12:04:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44217 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390091AbfJDQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:04:40 -0400
X-Originating-IP: 93.23.105.117
Received: from xps13.stephanxp.local (117.105.23.93.rev.sfr.net [93.23.105.117])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E50C36000F;
        Fri,  4 Oct 2019 16:04:35 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Liang Yang <liang.yang@amlogic.com>,
        linux-mtd@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [v8 1/2] mtd: rawnand: Add new Cadence NAND driver to MTD subsystem
Date:   Fri,  4 Oct 2019 18:04:31 +0200
Message-Id: <20191004160431.6196-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926081219.22375-1-piotrs@cadence.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ec4ba01e894d3165e4d1ccbef782ef5593b708b4
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-26 at 08:11:36 UTC, Piotr Sroka wrote:
> Add new Cadence NAND driver to MTD subsystem
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
