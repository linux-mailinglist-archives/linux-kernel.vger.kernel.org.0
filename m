Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563975FF99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfGECzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 22:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfGECzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:55:05 -0400
Subject: Re: [GIT PULL] dax fix for v5.2-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562295305;
        bh=g1fh37E3g0Ecbtf1QI1mp3LBnuqqRLs7j77IMJR3zJE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1v7oDAA161pWOrObNe2BSha2K2jtt1dt7wbwQJ9he5t68nfWl/Z8FXZd4xnlvM/Yt
         mB21vby6qB6+M5Vme0rsh0ijYhKKXaft0j+4Xt8LfrKdvvkCFKUd5moaslFpr0f2bP
         YZ5q7KbUuBZDwiJY/tWVDmRVDZNrlo1FIQoMmd3U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
References: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hs6bncxc3_vOKYYc-XdL+-dv_dJkmV8EduRrshv3rBgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fix-5.2-rc8
X-PR-Tracked-Commit-Id: 1571c029a2ff289683ddb0a32253850363bcb8a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cde357c392e93aa7fcfc019403e0d1792081d634
Message-Id: <156229530511.12956.15338596813183151186.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jul 2019 02:55:05 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jul 2019 17:11:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fix-5.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cde357c392e93aa7fcfc019403e0d1792081d634

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
