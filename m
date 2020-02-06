Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDC5153F90
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 09:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBFIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 03:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgBFIAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:16 -0500
Subject: Re: [GIT PULL] libata changes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580976015;
        bh=1TUCc/n7jK8aczgZHm/HnKVaNLnZAgdXj88EhcUg3jA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FgiVVjIokKhvwU9j5JgR/q8qhoabIGs21SQLCt5kd7Ts+RKTf3R80X64WUHfk3Cb+
         iVTUaim/GCxK1RnZm2vDgBly13wEc5c4TiiUm7P2hCBVTsEnN6IPOz8iFofCa2VR8P
         U5GA6E8+wXK/vIPR9vYaBCI1OPzqtjOv4FSfQRbQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dac0d422-4a49-b50c-7096-2a092ee845ad@kernel.dk>
References: <dac0d422-4a49-b50c-7096-2a092ee845ad@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <dac0d422-4a49-b50c-7096-2a092ee845ad@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/libata-5.6-2020-02-05
X-PR-Tracked-Commit-Id: 7991901082f0626592885a77a2cf8162536d1a51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0384066381ed5572cf1f57f8d01eaccd3f6d4785
Message-Id: <158097601541.20426.13606324661097244573.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 08:00:15 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 14:19:18 -0700:

> git://git.kernel.dk/linux-block.git tags/libata-5.6-2020-02-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0384066381ed5572cf1f57f8d01eaccd3f6d4785

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
