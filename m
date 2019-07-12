Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999A666386
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 03:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfGLBzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 21:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbfGLBzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:55:12 -0400
Subject: Re: [GIT PULL] chrome-platform changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562896511;
        bh=TwWp5zYU5+HxQiHnMykxJkUaHFc+mZqXb5CSFDjaSos=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o4ZJj6JMDN2YL3WNWqDGpvlRHv09LnGIqHiwWh7loLbXH0/M0F37bCooiZIerxMfW
         4KzfOlnyV0WpDhIU0a/2CuUj1Ro7EGVAlfhJxbdLZ8FNwkvpZ8hp0YXF5Aqf0Brino
         nQripTcQAhhiMxvB37c1kGNt3zeWYZ1IXIGbKZL4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711152501.GA190607@google.com>
References: <20190711152501.GA190607@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711152501.GA190607@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.3
X-PR-Tracked-Commit-Id: 8c3166e17cf10161d2871dfb1d017287c7b79ff1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7d170a8e357bd9926cc6bfea5c2385c2eac65b2
Message-Id: <156289651166.2089.8023333713755865605.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 01:55:11 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        gwendal@chromium.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 08:25:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7d170a8e357bd9926cc6bfea5c2385c2eac65b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
