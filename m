Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F2180648
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCJS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:29:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35601 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:29:42 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 726D360009;
        Tue, 10 Mar 2020 18:29:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [PATCH 4/4] mtd: rawnand: cadence: reinit complete before execute command
Date:   Tue, 10 Mar 2020 19:29:36 +0100
Message-Id: <20200310182936.17670-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1581328530-29966-4-git-send-email-piotrs@cadence.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 335e1ad05264d4ec4727b2832f42be5f299651ff
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 09:55:28 UTC, Piotr Sroka wrote:
> Reinitilaize complete object before executing CDMA command to make sure
> that done flag is ok.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
