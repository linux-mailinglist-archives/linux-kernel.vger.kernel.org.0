Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0770424169
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 21:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfETTo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 15:44:59 -0400
Received: from mx.allycomm.com ([138.68.30.55]:63129 "EHLO mx.allycomm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfETTo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:44:59 -0400
Received: from allycomm.com (184-23-191-215.vpn.dynamic.sonic.net [184.23.191.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx.allycomm.com (Postfix) with ESMTPSA id F2A313BCD4;
        Mon, 20 May 2019 12:44:57 -0700 (PDT)
From:   Jeff Kletsky <lede@allycomm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
Date:   Mon, 20 May 2019 12:44:51 -0700
Message-Id: <20190520194454.32175-1-lede@allycomm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the time and suggestions in review.

Commit-message wording revised as suggested.

No changes in patch content.

Supersedes series:

[v2,1/3] mtd: spinand: Add #define-s for page-read ops with three-byte addresses
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=107874


Jeff



Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org





