Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D1B56BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfIQUPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfIQUPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:19 -0400
Subject: Re: [GIT pull] x86/irq for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751318;
        bh=OTS1bCLEm2TpFTbnHsx6j0FhRR5NXj3Vhs3QtBRcSX0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QU8TyIWcKXjL7p5WKhiSHTZ5gTmVnHVGa/ONGJSSqbPNpGuvb3unMRMm938bRjwE0
         IQqEjwSZq86qo1Uv+0Rq/tLtftAmCPIkGIvAIr6Bstb0TOpe6GnW6YVTH16ygXErq5
         l1ezrW92/RDoG0sa9Cxbm7Lrp8Dma66GJG4NjE/4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062019.3407.15459445078519188901.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.15459445078519188901.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062019.3407.15459445078519188901.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus
X-PR-Tracked-Commit-Id: 8725fcd99a3084a7a15a6e70882bfa3fe7925f52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 258b16ec9a542d57e78f82e0af0e600bb4aec7fa
Message-Id: <156875131888.8483.16838319346099744167.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/258b16ec9a542d57e78f82e0af0e600bb4aec7fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
