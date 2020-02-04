Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0511516B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 09:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBDIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 03:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbgBDIFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 03:05:16 -0500
Subject: Re: [GIT PULL] chrome-platform changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580803515;
        bh=t01zNu4kysxC7yoX7DvkmGW7AQ3ygY9ND9bAg1nrMBQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XSUnXuaqggBdwf0AVyJXL6r1kWx9QA03fGopMtiOgt1Q0RML+GpyKp/f2zITaYtEX
         H9DhoWlrOg+OQTw2Rev8tbA2KtF8XhMjYonrpSi0y/KKvYrVSSkhLEk+DnxqX6c3jR
         IvqRhbRVEWFYZ8/Qh8F9Js8PnscLEvSxiQVMcghw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203231430.GA205960@google.com>
References: <20200203231430.GA205960@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203231430.GA205960@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.6
X-PR-Tracked-Commit-Id: 034dbec179e5d2820480f477c43acbc50245e56d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79703e014ba02ad86af4bcdf0c16e4b208cca406
Message-Id: <158080351555.18289.15822647615850549689.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 08:05:15 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 15:14:30 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79703e014ba02ad86af4bcdf0c16e4b208cca406

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
