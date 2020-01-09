Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2113616D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbgAITuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:50:16 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:42444 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbgAITuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:50:15 -0500
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 7701D3AC1F4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 19:14:59 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 777C320008;
        Thu,  9 Jan 2020 19:14:58 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        kyungmin.park@samsung.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: checkpatch.pl cleanup - fix errors and checks
Date:   Thu,  9 Jan 2020 20:14:56 +0100
Message-Id: <20200109191456.10838-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102171008.GA15268@user-ThinkPad-X230>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 44f45994f438b4f4e0ba977b173980268983c60f
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-02 at 17:10:08 UTC, Amir Mahdi Ghorbanian wrote:
> Correct mispelling, spacing, and coding style flaws caught by
> checkpatch.pl script.
> 
> Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
