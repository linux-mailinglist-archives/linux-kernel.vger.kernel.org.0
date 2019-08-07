Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45C85590
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfHGWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 18:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGWPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:15:09 -0400
Subject: Re: [GIT PULL] hwmon fixes for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565216108;
        bh=MXsB0r5Yi1Cpk4u7iPJOhQGMZAoHZlu1b5/yfSuk4fg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zJltm0ehm4qUldbk5K2v+3KSZye+tHo3kCc5HbtzDP3jXKKg7e2k2KfV+UpjYHLzI
         zho/gV93ageepgYx0sXnmJsZ3Dz1KzQylXAgN/1WEpUhtRmMT3+6rLhpVt8jqtt8FM
         lwNNtp2f4qQ523C6HyQ8l3hSIjTq2JP5sQMhIEHY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1565215115-11064-1-git-send-email-linux@roeck-us.net>
References: <1565215115-11064-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1565215115-11064-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.3-rc4
X-PR-Tracked-Commit-Id: a95a4f3f2702b55a89393bf0f1b2b3d79e0f7da2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecb095bff5d4b8711a81968625b3b4a235d3e477
Message-Id: <156521610873.10652.16733860959491286296.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Aug 2019 22:15:08 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  7 Aug 2019 14:58:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecb095bff5d4b8711a81968625b3b4a235d3e477

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
