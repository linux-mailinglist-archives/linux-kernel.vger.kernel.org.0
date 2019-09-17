Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647AFB58A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfIQXka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 19:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbfIQXk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:26 -0400
Subject: Re: [PULL 0/4] xtensa updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763625;
        bh=0dQ3Mxckole0QFeSqkKZX4qoGTtor3aebYbLFiLtiIs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i9JBhpFlirC69+tL+FdIvdEdKlOc7a7ozmKBP4nfGWnFd1MgCJTjjrPqhySNwvByW
         uTRyIri6kKrs50I7DBnJYzDSdvK0jt9YFbP6vQsyK9wxcS36+P9TgG5aCc4lx8F9JI
         cI1/k4K70bwyBNOIu8tYvQrdvzLsjebHegkoHJ/g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917185905.2761-1-jcmvbkbc@gmail.com>
References: <20190917185905.2761-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917185905.2761-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190917
X-PR-Tracked-Commit-Id: 982792f45894878b9ec13df81e6e02209b34cb11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dec8c15e5faa2a3c02d2e1d1b03b926b545ec0a
Message-Id: <156876362567.26432.6236780901231216387.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:25 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 11:59:05 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190917

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dec8c15e5faa2a3c02d2e1d1b03b926b545ec0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
