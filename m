Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951D6C1A48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfI3DFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 23:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbfI3DFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 23:05:24 -0400
Subject: Re: [GIT PULL] Documentation/process/embargoed-hardware-issues patches
 for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569812723;
        bh=uOqmAe3UCe4Te6AnCbW6JSQ/mNXwA9DVLLzaRIYNEoA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b6dnYtFemI47QVedqerihDVr7JMjkv84e3z7gHwcdBg9Y6NuhH1bAABR2Vgr2UfFX
         gAyd6DDkiIg4OrQ8Y3dF7EvbB95ovPPUy4VsZKfSv/qFoKZwpMYtxJ99LfNdfCFz7v
         2+ca5MBUN90Z/PAKJ8tJ0JLnVVe8pBZeXQItrpQQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190929105347.GA1949165@kroah.com>
References: <20190929105347.GA1949165@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190929105347.GA1949165@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.4-rc1
X-PR-Tracked-Commit-Id: dc925a36060e8cef050a9d05c64dae1c30dc5027
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97f9a3c4eee55b0178b518ae7114a6a53372913d
Message-Id: <156981272393.21310.8181959440661829859.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 03:05:23 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Sep 2019 12:53:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97f9a3c4eee55b0178b518ae7114a6a53372913d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
