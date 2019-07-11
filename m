Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF665AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfGKPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 11:43:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfGKPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:43:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hlbDs-0001YQ-Jy; Thu, 11 Jul 2019 17:43:04 +0200
Date:   Thu, 11 Jul 2019 17:43:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.2-rt1
Message-ID: <20190711154304.gcadninxohyznc4k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.2-rt1 patch set. 

Changes since v5.0.21-rt16:

  - Rebase to v5.2

First release in the v5.2 series. I had in testing for the last few
days and did not notice anything unusual.

Known issues
     - rcutorture is currently broken on -RT. Reported by Juri Lelli.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.2-rt1

The RT patch against v5.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patches-5.2-rt1.tar.xz

Sebastian
