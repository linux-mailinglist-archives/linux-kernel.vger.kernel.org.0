Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38C2B6A61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfIRSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 14:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbfIRSU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:20:27 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568830827;
        bh=Gg1zfagf4CLpIVL7mWt/alpWvCIg8cI5k/6SQryf+sg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fBLtEZIWxQ50t1XJZ1T2MaCIgIN1if/xmgvdVTrCcsnzMlHAE9LLPisXZW2YdC7LV
         elH7zJOtq87sXNgurmP3pJ0uhWuvloN8vSocYKdxH83g5g1SwRYwO6tWeBNy8COEtq
         hg0WoRdT/t25A6DKRfIyvkd+QKB7ec15EcvUdEG0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918114855.GA1899676@kroah.com>
References: <20190918114855.GA1899676@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918114855.GA1899676@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.4-rc1
X-PR-Tracked-Commit-Id: 16a0f687cac70301f49d6f99c4115824e6aad42b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cfae0c26b21dce323fe8799b66cf4bc996e3565
Message-Id: <156883082730.23903.5810935080917444089.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 18:20:27 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 13:48:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cfae0c26b21dce323fe8799b66cf4bc996e3565

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
