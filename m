Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD62156C6E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgBIUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 15:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbgBIUk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:28 -0500
Subject: Re: [GIT pull] EFI fix for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280827;
        bh=0iQxGUDWikGlxnwZllQ2wjFkeyrvhbZws16v1y1Gjfc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ESaEkGkXrr1XggshfODirxdLEMm8UlT55Y0U2dhKoABibaMU8nmzqMan6SybVH4No
         mdtnzbjvl08RRAKtPajt9AWm+rJ1k6RjzHOvtTbHh87Kyr2Dh3TLAJKvtfDvfg9u7Z
         WEyDEkKc3ZnBeCrNWCUlJzX6ucKlG5WOPTtEQRTQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-2020-02-09
X-PR-Tracked-Commit-Id: 59365cadfbcd299b8cdbe0c165faf15767c5f166
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ff90aa2cfddb1bce5450cb711069315ad17bd14
Message-Id: <158128082770.31187.13888483914173343032.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:27 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ff90aa2cfddb1bce5450cb711069315ad17bd14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
