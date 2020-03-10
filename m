Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A746180650
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCJSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:30:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39003 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:30:23 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id EAFD9240007;
        Tue, 10 Mar 2020 18:30:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ingenic: Add dependency on MIPS || COMPILE_TEST
Date:   Tue, 10 Mar 2020 19:30:20 +0100
Message-Id: <20200310183020.18057-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302184509.10666-1-paul@crapouillou.net>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: fa157c99d96e284726ba5ea800798f5a858f8c9a
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 18:45:09 UTC, Paul Cercueil wrote:
> This driver has no arch-specific instructions but is only ever useful
> on MIPS; so disable this driver if we're not compiling for MIPS, unless
> the driver is compile-tested.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
