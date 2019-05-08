Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5975617B31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfEHOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 10:00:31 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33488 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHOAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:00:30 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x48E0RWO017261;
        Wed, 8 May 2019 16:00:27 +0200
Date:   Wed, 8 May 2019 16:00:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Pranith Kumar <bobby.prani@gmail.com>
Subject: [GIT PULL] nolibc header update for 5.2-rc1 (RISCV support)
Message-ID: <20190508140027.GA17190@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 80f232121b69cc69a31ccb2b38c1665d770b0710:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next (2019-05-07 22:03:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ tags/nolibc-5.2-rc1

for you to fetch changes up to 582e84f7b7791bf2a2572559c5e29f3d38a7a535:

  tool headers nolibc: add RISCV support (2019-05-08 15:48:43 +0200)

----------------------------------------------------------------
nolibc header update for 5.2-rc1 (RISCV support)

This single commit adds support for the RISCV architecture to the
nolibc header file. Currently the file is only used by rcutorture but
Pranith Kumar who contributed it would like to have this work merged.

I only did some trivial tests to verify that it does not break x86,
which I consider sufficient since all the code is cleanly enclosed
inside a single #if/endif block.

----------------------------------------------------------------
Pranith Kumar (1):
      tool headers nolibc: add RISCV support

 tools/include/nolibc/nolibc.h | 194 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
