Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48E14E634
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 00:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgA3Xu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 18:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbgA3XuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:21 -0500
Subject: Re: [GIT PULL] mtd: Changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428220;
        bh=byWzMdC5VzPUaMxxqzsKKy4GLzsK1n8h38uudDXjQ6A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BP1QD6LCGemSPfModyC6TC35FxMQc23KWTP9uEC+8dpQbhUJLYvy54YEZSiaVfsxc
         Nrxz18etI9uMHiwIrQdLbQWObcDr6Zt7OtCPPICfliZV6mItdOF20U3QAx0yskZViE
         jMr4kAyxjgQZd+rj/FIalPrvwUyhSS6eSoNOEg6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130212052.11ca8719@xps13>
References: <20200130212052.11ca8719@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130212052.11ca8719@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.6
X-PR-Tracked-Commit-Id: 4575243c5c173f8adbc08a5c6ea2269742ea2b47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35c222fd323629cf2e834eb8aff77058856ffdda
Message-Id: <158042822052.30792.15827763280633240047.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:20 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 21:20:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35c222fd323629cf2e834eb8aff77058856ffdda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
