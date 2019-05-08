Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78E17FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfEHSaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfEHSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:30:14 -0400
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.1+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557340213;
        bh=ArU7WW62CINzg8xZQvtrCBnxq4yjzqir/mFHPpnHq/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bZrGIxQDMTz5vUUR4c/1TQhILPYNMUBj+Ym0hYROba6B6tY1zMtsItEHVm1o6esxz
         gYHuNJVarQ5nJ5MOuZi2MPuvUpt7Wbam3PoruHi4wnaSFk6WHe94qKnR9yPmp/wJmS
         SG6h1iCtf9qRYJVHvvzKWY0GD1dQvqvlrp1JPFIA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1557291792.9245.31.camel@HansenPartnership.com>
References: <1557291792.9245.31.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1557291792.9245.31.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: d4023db71108375e4194e92730ba0d32d7f07813
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1cd7c85f9e29740fddec6f25d8bf061937bf58d
Message-Id: <155734021345.8790.11973657663525037842.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 18:30:13 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 07 May 2019 22:03:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1cd7c85f9e29740fddec6f25d8bf061937bf58d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
