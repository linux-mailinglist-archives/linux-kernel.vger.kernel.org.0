Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A81110647
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 22:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLCVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 16:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfLCVFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:05:20 -0500
Subject: Re: [PULL 00/30] xtensa updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575407119;
        bh=bO/wUQj/ApgR18JevbNfkW0kH+8RYPF9kioW/cDfXpw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dIDsk4TlKgo5Ej4DO43457J2bamZXb8l4BOsSb2muObwPvWUdaj069GkTjyg0qkJZ
         7qFIHowh8pOKNTcoinFLxCr+/asskF69ze1F/j+eZJ+UoNsizQGJGBjrYu+KxTRUD1
         CvTvsPKAWx/4kaFVdmwZtbGKBCxaG820MSfQzvQw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203074629.17278-1-jcmvbkbc@gmail.com>
References: <20191203074629.17278-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203074629.17278-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20191201-mainline-merge
X-PR-Tracked-Commit-Id: 9d9043f6a81713248d82d88983c06b1eaedda287
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d7048f55104434ec64fe0b5196cbc89a8f99548
Message-Id: <157540711988.31207.190056347960201284.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 21:05:19 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  2 Dec 2019 23:46:29 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20191201-mainline-merge

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d7048f55104434ec64fe0b5196cbc89a8f99548

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
