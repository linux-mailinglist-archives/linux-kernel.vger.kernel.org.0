Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A4EB56BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfIQUPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfIQUPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:18 -0400
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751318;
        bh=MTGjywujn4jBUeC9tJYg5XHoTzUvDzUa5mjDoWKOkXc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H9JzpeoT4KjPNjt1zdEs5hYk+LrWm3ImqQIeSpmKhRA5LxLAanYfTWzlQZ8wvSIVU
         QWzCV5DVwZ7wYvU4ybadEXSe0NsFTgk9+NG7vSFHJVtfk/HwoSUOl8zluw1OUOoH66
         Q6YSov0oQ0MLj/aYKDg1qF/HHo/j6Y5hI1Ahtw8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus
X-PR-Tracked-Commit-Id: 990784b57731192b7d90c8d4049e6318d81e887d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fb7f3a6ed8666f45ff45124988173758cc7b011
Message-Id: <156875131805.8483.13756585942900572653.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fb7f3a6ed8666f45ff45124988173758cc7b011

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
