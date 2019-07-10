Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA648629AD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404663AbfGHTab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404585AbfGHTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:10 -0400
Subject: Re: [GIT pull] smp/hotplug for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614210;
        bh=sSfsqHf0xfTnHlVWxKL5frdAgG9edIqYGGtXKtf9NqI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PaGzDcT0kBkGxt59ONbEJBmEBaKfKInCxib29zovOkcxbTQp5573xzSyIZsxwYBMu
         zFs5NF8miY3K/bLoouoNuOZW/jWsbJfFkahMw/fUyTACoEL/vePItI2BccqkbrEXks
         UW/2Fy6qxu/53BOeB7bDCDSdBNb1mvoZMtCzdxNY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673794.14831.7846075415358186761.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673794.14831.7846075415358186761.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673794.14831.7846075415358186761.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-hotplug-for-linus
X-PR-Tracked-Commit-Id: caa759323c73676b3e48c8d9c86093c88b4aba97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0e86b111bca6bbf746c03ec5cf3e6a61fa3f8e9
Message-Id: <156261421019.31351.13189072693399103199.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0e86b111bca6bbf746c03ec5cf3e6a61fa3f8e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
