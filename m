Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A659BA38A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbfIVRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 13:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfIVRzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:55:25 -0400
Subject: Re: [GIT PULL] Modules updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569174924;
        bh=xeocLIKAnE7G1EeT5VKuX7zoKU9+S+YrVhVFe2P8x6g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oDFyKxwL1ZR/XcG7uwDwSQ68cRK8NoSW7RvNgCHnVkXDwVy+0f/fM7EavZ+eCDDCR
         1YGPOYT8o1aK5kNOjopV18W7CZrOk5L2thHbWfNnLCySjA5oVlZIRUgK4ezxnZCyxN
         NAvc2vFZXAl3E1J3igJ1Y2KUxA6CXRyBUxEvBUjM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190922152809.GA27554@linux-8ccs>
References: <20190922152809.GA27554@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190922152809.GA27554@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.4
X-PR-Tracked-Commit-Id: 2e6fcfeb9df6048a63fe0d5f7dfa39274bacbb71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0703556644a531e50b5dc61b9f6ea83af5f6604
Message-Id: <156917492433.22511.7725238151168356068.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Sep 2019 17:55:24 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Sep 2019 17:28:09 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0703556644a531e50b5dc61b9f6ea83af5f6604

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
