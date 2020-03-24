Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FD191C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 22:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgCXVwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 17:52:22 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49579 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCXVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:52:22 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D7597FF808;
        Tue, 24 Mar 2020 21:52:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] mtd: spinand: toshiba: Rename function name to change suffix and prefix (8Gbit)
Date:   Tue, 24 Mar 2020 22:52:18 +0100
Message-Id: <20200324215218.14182-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0dedd9869569a17625822dba87878254d253ba0e.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 6b49e58d6d9dab031a16af2af5439f28a37c4cd9
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 06:49:44 UTC, Yoshio Furuyama wrote:
> The suffix was changed from "G" to "J" to classify between 1st generation
> and 2nd generation serial NAND devices (which now belong to the Kioxia
> brand).
> As reference that's
> 1st generation device of 1Gbit product is "TC58CVG0S3HRAIG"
> 2nd generation device of 1Gbit product is "TC58CVG0S3HRAIJ".
> 
> The 8Gbit type "TH58CxG3S0HRAIJ" is new to Kioxia's serial NAND lineup and
> the prefix was changed from "TC58" to "TH58".
> 
> Thus the functions were renamed from tc58cxgxsx_*() to tx58cxgxsxraix_*().
> 
> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
