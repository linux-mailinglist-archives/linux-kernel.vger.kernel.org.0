Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909D46F05A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfGTSki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 14:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfGTSk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:29 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648028;
        bh=D8CxufH+ZLCxOcmkYjiiBFGD4DaPIRsv2t52bC0YZLU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D2HKySVPhM3FL4EqVHtfzT7nAj149BQBpKx33SsagPtq+zSdiEGeCqZIHptHTQpNI
         ZkRiSOwpqCXUIbnTcXV4oJvY4ArhXo4xmEPbMx1YDeHjkfE8JNdCia4y/XO495MsUG
         Z4pKJXn911eMlYKNkFWygcANbHlzYckXlGvyHW8M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
 <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 6879298bd0673840cadd1fb36d7225485504ceb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6dd78fcb8eefa15dd861889e0f59d301cb5230c
Message-Id: <156364802893.20023.15834093863755103206.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 12:50:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6dd78fcb8eefa15dd861889e0f59d301cb5230c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
