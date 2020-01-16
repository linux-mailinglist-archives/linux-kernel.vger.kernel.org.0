Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDED13F1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407087AbgAPSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436720AbgAPSaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:30:04 -0500
Subject: Re: [GIT PULL] chrome-platform fixes for v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579199404;
        bh=aF+qcS9mrjO8tbEi8YwhBFivADRMZws4q6LY/Bt7bLw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZoBbonQLXLG7OOKSs39oqVjJ0jPHR2DnBCc7IWUXU4voThjbyYS6n1QTEN+8XZCuF
         4l0YVn7T7Rr2S5kuEIaZwJzPKKkswWK0EYhOcmIOiC/M0TrOvuzGT8ahTyWs0Rn9W/
         Tg5OGyTGTnuP3DexfCSKKl2fEi6p2OoTsd+LL+2Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200116175802.GA147875@google.com>
References: <20200116175802.GA147875@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200116175802.GA147875@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.5-rc7
X-PR-Tracked-Commit-Id: dfb9a8857f4decbba8c2206e8877e1d741ee1b47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c99ee44b8921b872089a7374c733310d995fd92
Message-Id: <157919940438.19397.11912146279100722478.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jan 2020 18:30:04 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jan 2020 09:58:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c99ee44b8921b872089a7374c733310d995fd92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
