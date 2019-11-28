Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBE10C580
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfK1Iyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 03:54:53 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:42038 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfK1Iyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:54:53 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D18BE200A96;
        Thu, 28 Nov 2019 08:54:51 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DF81A80237; Thu, 28 Nov 2019 09:54:47 +0100 (CET)
Date:   Thu, 28 Nov 2019 09:54:47 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: unchecked MSR access error in throttle_active_work()
Message-ID: <20191128085447.GA3682@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most recent mainline kernels (such as 5.5-rc0 up to a6ed68d6468b), I see
the following output in dmesg during startup:

[   78.016676] unchecked MSR access error: WRMSR to 0x19c (tried to write 0x00000000880f3a80) at rIP: 0xffffffff84ab5742 (throttle_active_work+0xf2/0x230)
[   78.016686] Call Trace:
[   78.016694]  process_one_work+0x247/0x590
[   78.016703]  worker_thread+0x50/0x3b0
[   78.016710]  kthread+0x10a/0x140
[   78.016715]  ? process_one_work+0x590/0x590
[   78.016735]  ? kthread_park+0x90/0x90
[   78.016740]  ret_from_fork+0x3a/0x50

Any clues?

Thanks,
	Dominik
