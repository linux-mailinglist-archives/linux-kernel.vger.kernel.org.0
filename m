Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA017FDF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfEHSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbfEHSaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:30:16 -0400
Subject: Re: [GIT PULL] USB/PHY patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557340215;
        bh=xq1QVbEQdOHpNdUBEc+7njxlaGTmDKJmqL93lR1OX8U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ROfDuZkQWKnj9+YdDOlJ80X8Zux1YM/lLARzbGl4G9fhLstJF1OA3W5gVgdNBOGbH
         3lXxoCa1dDMaROUur5YHWawUUG4XpBtFkZetB+wFhtmGyMAHqL06okApwBkk9aamMA
         EeAIi7unqn+bmg0og3oTgH/dq78SiHo2/rUjbMIE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190508103055.GA14454@kroah.com>
References: <20190508103055.GA14454@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190508103055.GA14454@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc1
X-PR-Tracked-Commit-Id: 3515468a87a47781f6af818773650513ff14656a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 132d68d37d33f1d0b9c1f507c8b4d64c27ecec8a
Message-Id: <155734021587.8790.8822547293607613730.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 18:30:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 May 2019 12:30:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/132d68d37d33f1d0b9c1f507c8b4d64c27ecec8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
