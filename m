Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD421A25C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfEJRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 13:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfEJRfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:18 -0400
Subject: Re: [GIT PULL] Some more documentation work for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509717;
        bh=4S8UDvw4YhLpJKgWIYD8kT0JvXt8ejqkuOEft4+91YA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fT3af7ZDkD6+icqpdva9AWtHno8ADHjmSK8kOasxDjoN/N5APCILLa+c7HGyb+tyV
         o+7kpcyZG6de9v0VbsnXlmEFTClztE8ASCaQNfvu5eLxQ/EerpFk/AFx/PZPKaBDB5
         c32ePHR6qhPGGzeQ5QGY1T+uE9mxAhM9zwJ7agtg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510092837.09b2a4f5@lwn.net>
References: <20190510092837.09b2a4f5@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510092837.09b2a4f5@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.2a
X-PR-Tracked-Commit-Id: afbd4d42470e91470bc59040094b89cd717530bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fb3b526df3bd7647e7854915ae6b22299408baf
Message-Id: <155750971763.27249.11792938489315728183.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:17 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 09:28:37 -0600:

> git://git.lwn.net/linux.git tags/docs-5.2a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fb3b526df3bd7647e7854915ae6b22299408baf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
