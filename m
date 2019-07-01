Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7C1A262
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfEJRf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 13:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfEJRfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:19 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.2-1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509719;
        bh=nJ9VbLT7J1+ENh276dhCYKa2RflG+LfBqdnmKUZuqrE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lOSz+L78DAQHaep6RIqMAq9fBhET4Hi53lcFTh4+eOKIvV/0WfxSPMQzlM1jnPvAc
         cHoK9xFLujqb0Kj+LnXr7uyXTQaZ1/s6yioF5VF7iDlHcRbXap/mhFHBokNDWgR730
         QvVlHH7GukbKV2K5RJYlOb6ch2MtmT3JlN5FSRtE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510153531.GA19723@smile.fi.intel.com>
References: <20190510153531.GA19723@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510153531.GA19723@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.2-1
X-PR-Tracked-Commit-Id: 6456fd731517f473eac033f898d40ae76b160183
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7817ffd20a0f7fbd5971643b5ef1f577703dad11
Message-Id: <155750971896.27249.4061480550533521443.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:18 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 18:35:31 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7817ffd20a0f7fbd5971643b5ef1f577703dad11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
