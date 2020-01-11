Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7F13819B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgAKOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgAKOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:08 -0500
Subject: Re: [GIT PULL] USB fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753908;
        bh=Sf2tMzghEukZWFHEfC65s2h+yOox/3Y5IMAgTlNHHhI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KA2QxLTAthH7ySX6KNa2GYSQcHXwtwKoIyExbMb4S6TmCPtVqHHv862adZepW7P2r
         a6ZCTAD5IG2AglAoKT0vqHa698EMoKXHln2A+mCEln/544GRwkzyer2dIrfmnV0vc5
         hyvSjC0n2dd7YLJxOiKy10x6J2vtQtPeN3m5Ve7I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200110211758.GA1872534@kroah.com>
References: <20200110211758.GA1872534@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200110211758.GA1872534@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc6
X-PR-Tracked-Commit-Id: 1530f6f5f5806b2abbf2a9276c0db313ae9a0e09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 213356fe986faff3580f2c12c14773f53da32768
Message-Id: <157875390837.30634.17442975484058192508.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jan 2020 22:17:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/213356fe986faff3580f2c12c14773f53da32768

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
