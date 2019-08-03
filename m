Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B42807B5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfHCSZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 14:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfHCSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:25:12 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564856711;
        bh=xw8F47uSoCSl7AGiB3zmE17HFpP3Min33+KWOBDqVwM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MM/oiH8N4jKG1HOWEMth2BIKW/qeIwjzOzkUJu3B1NXWIyE8ivJIaDJpHH9MQrHel
         vrsV8EVXg8rPXYCtm6IOI4z18W5iT55kaZa+T45sUft6YLsiHJPbaZr9jBiVlKwWDX
         NhavmIcm+4olW6TEQKnDYUVcfnfzhRV/myrVz3VE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156485021326.28964.10885839492269973900.tglx@nanos.tec.linutronix.de>
References: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
 <156485021326.28964.10885839492269973900.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156485021326.28964.10885839492269973900.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: b3c303be4c35856945cb17ec639b94637447dae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b7fd679427c571c34f61d9eafed3562c52424ae
Message-Id: <156485671167.25774.5193083042008404509.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 18:25:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Aug 2019 16:36:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b7fd679427c571c34f61d9eafed3562c52424ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
