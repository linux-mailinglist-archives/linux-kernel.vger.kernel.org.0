Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6399191C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 22:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgCXVwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 17:52:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35091 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCXVwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:52:38 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id F1EC920003;
        Tue, 24 Mar 2020 21:52:26 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, bbrezillon@kernel.org
Cc:     juliensu@mxic.com.tw, s.hauer@pengutronix.de,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        stefan@agner.ch, linux-mtd@lists.infradead.org,
        frieder.schrempf@kontron.de, tglx@linutronix.de,
        allison@lohutok.net
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add support for manufacturer specific suspend/resume operation
Date:   Tue, 24 Mar 2020 22:52:25 +0100
Message-Id: <20200324215225.14249-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1584517348-14486-2-git-send-email-masonccyang@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: adc6162b9a0c60a81cf6a107196924526cd186f6
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 07:42:27 UTC, Mason Yang wrote:
> Patch nand_suspend() & nand_resume() to let manufacturers overwrite
> suspend/resume operations.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
