Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1092A14E633
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 00:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgA3XuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 18:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgA3XuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 18:50:18 -0500
Subject: Re: [GIT PULL] f2fs for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580428218;
        bh=SX4dd91lUe1tOyO4Sif0XUIJozxIpAwzV+9mPvfm39M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yVexK8+KmAARoH5F2UkYD+kvV6XUATWC3fMYpaKVMHYzQfLx3pQoDXzAGyumsQ+Tm
         En8+qyZGo9s4dKjdxEF0CI+bVy7BzEQYSBdujUQAROI/Phlob0RI/WTlzUl8swDDj8
         AUHAG2IOQMAkG4rFIFFHNfUwc2/zk7UT3HbC/n2k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130185335.GA225399@google.com>
References: <20200130185335.GA225399@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130185335.GA225399@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.6
X-PR-Tracked-Commit-Id: 80f2388afa6ef985f9c5c228e36705c4d4db4756
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e135baed8e70b00b88f7608f6b041461a5270bc
Message-Id: <158042821807.30792.10663230485770061389.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 23:50:18 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 10:53:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e135baed8e70b00b88f7608f6b041461a5270bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
