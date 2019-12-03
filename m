Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10847112013
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfLCXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 18:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfLCWkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:20 -0500
Subject: Re: [GIT PULL] chrome-platform changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412820;
        bh=zcBoHdTzslytluIyMkSAscVTPEWGrZX874Uz8T73zmw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KQZHdc2eMh32kons3IgcN7k2SNhSxgsqYVSwGRHVUPYnw4MX59JCMoMU3+vyQgv4f
         VXVLxhAsMjL2xTPZITLLBll/ml6hkAUV2cf9Yn49o6g0xlpymXFJOfzMA7589h/O7N
         1y7RypFwS9AqFfLCI7iCFSG8+UP9eCLf36MydcNE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203215800.GA34130@google.com>
References: <20191203215800.GA34130@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203215800.GA34130@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.5
X-PR-Tracked-Commit-Id: 856a0a6e2d09d31fd8f00cc1fc6645196a509d56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63de37476ebd1e9bab6a9e17186dc5aa1da9ea99
Message-Id: <157541282048.26485.8115653042206857597.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 22:40:20 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        gwendal@chromium.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 13:58:00 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63de37476ebd1e9bab6a9e17186dc5aa1da9ea99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
