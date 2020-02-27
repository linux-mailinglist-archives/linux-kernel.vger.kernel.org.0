Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9753D170CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgB0AAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 19:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgB0AAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:00:08 -0500
Subject: Re: [GIT PULL] chrome-platform fixes for v5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582761608;
        bh=4IavsyPvvlZi02gyjbawDfwhlnjZKYDcA0rLg+8BIPw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dBa/7PUPyjYptv2+eSu5rXqqeiA+znYlhGemcUpz12fsb5k93x0mHdMSQttSSD470
         Bq1qWMOwZB0fieT8simRCIAB4c/Vefaj6G4tpgFVyEA30C0vY0ES45OaIcSCyPS8g/
         KEx1LnyxhYuOSDgBGQ8VUnogQ035LdQwzdIxluE0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200226214438.GA207119@google.com>
References: <20200226214438.GA207119@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200226214438.GA207119@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.6-rc4
X-PR-Tracked-Commit-Id: 0cbb4f9c69827decf56519c2f63918f16904ede5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfdc6d91a25f4545bcd1b12e3219af4838142ef1
Message-Id: <158276160822.20855.4626201409863493672.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Feb 2020 00:00:08 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Feb 2020 13:44:38 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfdc6d91a25f4545bcd1b12e3219af4838142ef1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
