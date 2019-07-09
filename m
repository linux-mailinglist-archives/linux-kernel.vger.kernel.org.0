Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A518862DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfGIBps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfGIBpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:10 -0400
Subject: Re: [GIT PULL] x86/core changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636709;
        bh=rIpnmtX8HActYSUh1XktIVvEwGvA9AH6AIFVaAfJlro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jZysw/R97v4BFDrKgbqxSci5WuYnrREaz/vlvEMePb7GURIPGlUBJC3Q//EtYkAng
         MFwFOTyfw715MQ7Mwo7Kd8UyFwa8xMdNkR7Wg+QtJ++nqSf7waw/JytB50m3XTAodx
         9QQIAVds8wXx4WRmkJ6HzVvuMrbT1Cyr1xuybJPo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708161142.GA107326@gmail.com>
References: <20190708161142.GA107326@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708161142.GA107326@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus
X-PR-Tracked-Commit-Id: 711486fd18596315d42cebaac3dba8c408f60a3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3431a940bb6c3969240d91314d654ebac7e12b09
Message-Id: <156263670924.17382.13396713079553352690.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 18:11:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3431a940bb6c3969240d91314d654ebac7e12b09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
