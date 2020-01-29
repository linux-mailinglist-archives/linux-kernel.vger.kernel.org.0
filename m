Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7380914D3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 00:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA2XfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 18:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgA2XfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:35:09 -0500
Subject: Re: [GIT PULL] Documentation for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580340909;
        bh=Hln6DoQInLJxlgvVGflZohtga0A/GJxrBXWpGRBGQf0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v6YWEJUjpQfKNisRdqCyZJQu17sgGbnebamKGl9yqO2SN6nvh+Gxx6ZKDofHwNvZC
         p/xNtMA/xvNmFY9zXjCl0bwVL67akYwwrmedybnkW6KbLut6We2EKV4z25VhW7tP5U
         RIek3vMEAA9sfPTuuk67gK6/I1G4QyDrq+eFfE70=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129091628.0204a966@lwn.net>
References: <20200129091628.0204a966@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129091628.0204a966@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.6
X-PR-Tracked-Commit-Id: 77ce1a47ebca88bf1eb3018855fc1709c7a1ed86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05ef8b97ddf9aed40df977477daeab01760d7f9a
Message-Id: <158034090911.30341.2614133722889837551.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 23:35:09 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 09:16:28 -0700:

> git://git.lwn.net/linux.git tags/docs-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05ef8b97ddf9aed40df977477daeab01760d7f9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
