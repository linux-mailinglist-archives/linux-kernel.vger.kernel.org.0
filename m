Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9AC18D57A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCTRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgCTRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:10 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724509;
        bh=OLXAhy9OL5VK+yLwXen0926ZLYIxANWzgKtd1H11emM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S2vzAo6rjbaQT+KZE3DBuvUEF4BRhNnxKbHm2E5t/ZiNoqlYcdviuKuksDTbQAZpJ
         T/RIdQiQuEdnHnXGaegXtA0Oav5grlnXQNAXNK8KgEbXZjVpmAoFcGzlaENTBTSF80
         3nKRsFgQ44mZ+gi49ONQBOtZKrK5kjdFH/SNa1Ko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200320142818.GA760640@kroah.com>
References: <20200320142818.GA760640@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200320142818.GA760640@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.6-rc7
X-PR-Tracked-Commit-Id: add492d2e9446a77ede9bb43699ec85ca8fc1aba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f014d2b8584d0bf938e8d6761c79596e94b06f98
Message-Id: <158472450967.23492.7168121259826844822.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 15:28:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f014d2b8584d0bf938e8d6761c79596e94b06f98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
