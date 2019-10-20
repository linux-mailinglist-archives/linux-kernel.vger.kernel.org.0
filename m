Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69427DDE22
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfJTKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 06:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfJTKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:45:06 -0400
Subject: Re: [GIT pull] core/urgent for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571568305;
        bh=0vWc8AJC0lBWM72j6NvynD0TW2mVXHbL+H5GBNnJ440=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u4w7fsFCRcag1VibC0ayHdIrlQAR0X0b5VkiH+Nv3yLsyiM/dueTYBuE/y3ZRtplu
         GujBbMqzKuCwl2/pBnu0A/W0RYNm3ZGIxCoBhD91v7oCbZhF7IDW1zQNkqy+Zy+l5j
         i42mVVJHjuCPy4OSe7MbKbPYJE8MPXxUiBrEhySk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: b1fc5833357524d5d342737913dbe32ff3557bc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 589f1222e043ab1f5cbce558cfaed0c0fa76e7bb
Message-Id: <157156830574.17957.18403700341031345903.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Oct 2019 10:45:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Oct 2019 10:13:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/589f1222e043ab1f5cbce558cfaed0c0fa76e7bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
