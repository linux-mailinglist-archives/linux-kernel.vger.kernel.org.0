Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7CB10F2C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 23:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLBWUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 17:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBWUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:20:16 -0500
Subject: Re: [git pull] FireWire (IEEE 1394) update post v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575325216;
        bh=PVAzibMEyic86B3ClR6DenJ+ORcVAz1URHvOrQ+co1w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=taLtQqk1+9P5TzAc2vApd7tFg2h2+totYlWcC0TwKjLuScl1FvZ3+vfhL/hxchyRL
         KVmKgW7O8iAeL164G4XUaJspsPnBnWtWY5b+AID7DJA0pzPJ8j3uqQdH79w3zRk5yu
         GPmV6bzA3Rasb5LX37xFGtjIUka+dpHxDrCOqL9E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191201195308.363d0b83@kant>
References: <20191201195308.363d0b83@kant>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191201195308.363d0b83@kant>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
 firewire-update
X-PR-Tracked-Commit-Id: 7807759e4ad8d46347a5d52a0910269320b81e65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b326948c23908692d7dfe56ed149840d3829eaa
Message-Id: <157532521634.12303.9114949553263526469.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 22:20:16 +0000
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Dec 2019 19:53:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git firewire-update

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b326948c23908692d7dfe56ed149840d3829eaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
