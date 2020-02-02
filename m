Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1063514FF14
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Feb 2020 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBBUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Feb 2020 15:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgBBUUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 15:20:15 -0500
Subject: Re: [GIT PULL] pcmcia updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580674815;
        bh=JjJnukGKmCJgNi31hZaqgDcAmvLYG3EqoogjA/UTZ2Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hfYAys2Lq+sQT5rFbWcFS2LuFCw4Lh4sA2mF9sc9c2iBaQtckGOVZsyqG58hPHWVC
         /7kralFR2tp4Xzz6lW5Anok4oNYnjT516KvAJaXEbe9++kGA37voLUAaQ8spoZDQVo
         zGZPby8kx3qYxgo8ui9OovUIF++wcOAGalg5QyUs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200202143445.GA263996@light.dominikbrodowski.net>
References: <20200202143445.GA263996@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200202143445.GA263996@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: 71705c611263cad99edf85a5ea021e098cac032b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15f8e73355df9ec48902d128a0ef01a6b8bff453
Message-Id: <158067481507.26837.18292086821906767697.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Feb 2020 20:20:15 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Feb 2020 15:34:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15f8e73355df9ec48902d128a0ef01a6b8bff453

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
