Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4726132A49
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 10:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfFCIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 04:02:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58111 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:02:57 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost.localdomain (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F02881C0028;
        Mon,  3 Jun 2019 08:02:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nand-ecc-step-size optional
Date:   Mon,  3 Jun 2019 10:02:51 +0200
Message-Id: <20190603080251.27710-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <1558449865-36852-1-git-send-email-kdasu.kdev@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 33cc5bd0b87aaa4d16f30fd6295830245f84c377
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 14:44:21 UTC, Kamal Dasu wrote:
> nand-ecc-strength and nand-ecc-step-size can be made optional as
> brcmnand driver can support using raw NAND layer detected values.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
