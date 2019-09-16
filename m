Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39DFB4337
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 23:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfIPVf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 17:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfIPVfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:13 -0400
Subject: Re: [GIT PULL] i3c: Changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669713;
        bh=PiNFwM0Sr3u3cER5de0oCo3OV0xuvlqxbb0g/N2345I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GK9PW7TrqDMDCT+lpfoOQ+KnC0/RUtawW6YojJsffShHqET9y72sE4+6YzYxmYTDj
         q26btHYjJfM+YwxeUJxe8Y0dI2sNLY3mcJuEFQWZ9lhvQUWJvsoPiqhqn44zJ4BAnJ
         7ualna3nlvRWkVDo9xRsT1Yg/F/EojiNrjZJ5anM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916093953.05c99b3e@collabora.com>
References: <20190916093953.05c99b3e@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916093953.05c99b3e@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.4
X-PR-Tracked-Commit-Id: 6030f42d20cedc04df019891851320f3e257038b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31dda85e49da949fdea5fd4e1fdeeabc44e59625
Message-Id: <156866971340.13102.13795117505251561651.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:13 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 09:39:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31dda85e49da949fdea5fd4e1fdeeabc44e59625

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
