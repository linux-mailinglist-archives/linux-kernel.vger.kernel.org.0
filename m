Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAE6968CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfHTSzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 14:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbfHTSzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:55:09 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566327306;
        bh=t8bwgrNXWSSu/+2ZFhD3z+inj2oQDfk7dSBq1CDPCK8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RVggVs6DP1Cfz5VTdQF/OUwT88HK2DtiZBLK4AntI+AM/uwqyBuPOb5TjfCNnt/je
         7wU9D1fyS5LXhDSeh3pFvgXAybHGajEFy89Obpqc8yzrGDGZ3AMwTy4R/KqIe9U36R
         0B6f4Ui/qcd+fTRROiWh8BpV3otJ5qaEsFwcOy2g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1908201449220.27147@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1908201449220.27147@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1908201449220.27147@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: fcf887e7caaa813eea821d11bf2b7619a37df37a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15d90b242290f228166ea79ee1cc2db6b31a2143
Message-Id: <156632730681.28320.4919390066953345207.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Aug 2019 18:55:06 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Aug 2019 14:53:48 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15d90b242290f228166ea79ee1cc2db6b31a2143

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
