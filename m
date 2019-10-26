Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5531E5F95
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 22:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfJZUpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 16:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfJZUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:45:08 -0400
Subject: Re: [GIT PULL] TTY/Serial fix for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572122707;
        bh=DoiqC5n4O5p1SIvWDN9Zgky/N1zlFWTAwnTl3K+Rlmg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s8SP9CaoYcmphAUMSYNk/RgsKxGWHPIoz7Wmv1ALQeEUMGiOgkWIixtMFC5eSF4r1
         K6ujHRMGRIq14MgAWJbJPMlaMld8MY6LGSnF9frruEvFl7ib9k8H4bqKo3GPYXnW7d
         EXU4VrBJxQIABl7R9oxeQcFqxTZPH6I4V/DEenXQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191026181903.GA649190@kroah.com>
References: <20191026181903.GA649190@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191026181903.GA649190@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc5
X-PR-Tracked-Commit-Id: f50b6805dbb993152025ec04dea094c40cc93a0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 297689545916c40b65a86d4871e5610a024c8993
Message-Id: <157212270769.6077.12928537949082949893.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Oct 2019 20:45:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Oct 2019 20:19:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/297689545916c40b65a86d4871e5610a024c8993

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
