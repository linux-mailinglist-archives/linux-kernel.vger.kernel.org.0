Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0575C18064F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCJSaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:30:18 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47447 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:30:18 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2640AE000A;
        Tue, 10 Mar 2020 18:30:15 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     bbrezillon@kernel.org, juliensu@mxic.com.tw,
        s.hauer@pengutronix.de, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, stefan@agner.ch, rfontana@redhat.com,
        linux-mtd@lists.infradead.org, frieder.schrempf@kontron.de,
        tglx@linutronix.de, allison@lohutok.net
Subject: Re: [PATCH v3 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock operation
Date:   Tue, 10 Mar 2020 19:30:14 +0100
Message-Id: <20200310183014.17994-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1583220084-10890-2-git-send-email-masonccyang@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ec2955374128606c26d3331dabdc4dd1db236026
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-03 at 07:21:21 UTC, Mason Yang wrote:
> Add nand_lock() & nand_unlock() for manufacturer specific lock & unlock
> operation while the device supports Block Portection function.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
