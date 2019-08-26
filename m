Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105CC9CFEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfHZM7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 08:59:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46919 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731197AbfHZM7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:59:45 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 133EC6000B;
        Mon, 26 Aug 2019 12:59:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, robh+dt@kernel.org, stefan@agner.ch,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, anders.roxell@linaro.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, paul.burton@mips.com, liang.yang@amlogic.com,
        linux-mtd@lists.infradead.org, christophe.kerello@st.com,
        lee.jones@linaro.org
Subject: Re: [PATCH v7 1/2] mtd: rawnand: Add Macronix raw NAND controller driver
Date:   Mon, 26 Aug 2019 14:59:40 +0200
Message-Id: <20190826125940.15113-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1566199149-5669-2-git-send-email-masonccyang@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 738b0ca55f4f6ae1035262c2a2a605d2e9085031
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 07:19:08 UTC, Mason Yang wrote:
> Add a driver for Macronix raw NAND controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
