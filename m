Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F42312B0BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfE0IwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 04:52:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47951 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfE0IwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:52:19 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CE559802CB; Mon, 27 May 2019 10:52:07 +0200 (CEST)
Date:   Mon, 27 May 2019 10:51:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tglx@linuxtronix.de,
        bp@suse.de, hpa@zytor.com, mingo@redhat.com, x86@kernel.org
Subject: Thinkpad X60 fails to boot while "hot"
Message-ID: <20190527085155.GA11421@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So if you compile a kernel, then reboot, boot will hang after "Freeing SMP
alternatives memory" (and then wastes power, making thermal situation even worse).

Unfortunately, threshold for non-booting system is quite low, fan does _not_
go full speed after reboot. Annoying for kernel development :-(. Force power off,
wait for a while, power on, and it works again.

The bug is there for a long long time... probably 4.0 is affected, probably even
older.

Any ideas? Has someone seen something similar?


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
