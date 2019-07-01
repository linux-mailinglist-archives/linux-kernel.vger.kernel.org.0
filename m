Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C069DD65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfD2II6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Apr 2019 04:08:58 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37961 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfD2II5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:08:57 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 421F71C0003;
        Mon, 29 Apr 2019 08:08:54 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:08:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>
Cc:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Message-ID: <20190429100853.028815d6@xps13>
In-Reply-To: <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut,

Helmut Grohne <helmut.grohne@intenta.de> wrote on Thu, 25 Apr 2019
13:23:39 +0200:

> Without much knowledge of the nand framework, I attempted reviewing the
> code. Hope this helps.

It does help a lot, thanks for your time!

Miquèl
