Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F99185FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 21:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgCOUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 16:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgCOUZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:07 -0400
Subject: Re: [GIT pull] timers/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303907;
        bh=8PNsk3bRtuTjOKsl7oyxEGxgquK96ZuR792GY61TH7g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FUHbZufLFkZXdJWHDcfBLIZWXNSntPk7r1o8mu3OzY66zRwvQS16jeOoGqSjUen52
         iIzx5a7XQw3j+Z9rRCYJTy3f/DdwypuniQDya9KZ7vPrcF1MzeocHDyvePvisbPhzD
         CfKfBmB79hbOrh3SotrDUieWxxdyVKTeGq6wCsxg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527863.14940.3868391100636020882.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
 <158428527863.14940.3868391100636020882.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527863.14940.3868391100636020882.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-03-15
X-PR-Tracked-Commit-Id: ecc421e05bab97cf3ff4fe456ade47ef84dba8c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffe6da91b00eb3f4b8227441ad67e2a8d8667e22
Message-Id: <158430390696.13594.5979286464176779088.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffe6da91b00eb3f4b8227441ad67e2a8d8667e22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
