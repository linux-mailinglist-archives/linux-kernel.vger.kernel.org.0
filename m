Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02082150992
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBCPPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 10:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgBCPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:15:18 -0500
Subject: Re: [GIT PULL] Backlight for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580742917;
        bh=M/csQvaRzv/0AyBNZIPvwrKqTeppl5rSVSi6KKRdHG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MSeF79LpeEkAuqmMcnxd7esGkHZ49i02feXdiEio1FQPTYrsxTtgND80z0W4VSyTm
         2UoyDkrOQhW5sCIAS4eV4wnilYhmj88N8AdvSadNG2gi/EO1dhyhrSBQNj7aRG9e/n
         J6aKYo6D6h5kUuKJEAKla+499T/+Bgj2r2IrHV6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203130849.GC15069@dell>
References: <20200203130849.GC15069@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203130849.GC15069@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-5.6
X-PR-Tracked-Commit-Id: 7af43a76695db71a57203793fb9dd3c81a5783b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2367da5b51cd2819d630432e6a8876f973b1bbc3
Message-Id: <158074291782.25778.1291131402755279526.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 15:15:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 13:08:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2367da5b51cd2819d630432e6a8876f973b1bbc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
