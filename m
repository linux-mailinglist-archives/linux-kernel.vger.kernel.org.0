Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020121560DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 22:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBGVzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 16:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgBGVzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:16 -0500
Subject: Re: [PULL 00/11] xtensa updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112515;
        bh=QrDmgzN6HBBYGH/yuWtiDjfySyzevCWjKqhuZ8g/Vxk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TxyxSEY0uhp51i7XmNsiK2GL9kIGMZRfIUdDepI7UjpmderbJghQyjqOu5YAhc6sE
         fQysDKkgEzXzYwAdGUmZCrgS0ZQsQKgOrFGUf+3unnCbW/sMgtkBuPJ46JiY1PCKgf
         Yf9BupMK41W5QwfMojAZNrudjT4ske+8hOeUfG98=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200206184224.25833-1-jcmvbkbc@gmail.com>
References: <20200206184224.25833-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200206184224.25833-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20200206
X-PR-Tracked-Commit-Id: c74c0fd2282e0e3ce891cb571f325b9412cbaa3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b7fa2880fe716a30d2359d40d12ec4bc69ec7b5
Message-Id: <158111251576.9631.15062083091089576130.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:15 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Feb 2020 10:42:24 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20200206

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b7fa2880fe716a30d2359d40d12ec4bc69ec7b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
