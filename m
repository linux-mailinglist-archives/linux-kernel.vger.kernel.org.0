Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A048318ED5B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCVXsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 19:48:45 -0400
Received: from n7.nabble.com ([162.253.133.57]:53852 "EHLO n7.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgCVXsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 19:48:45 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2020 19:48:45 EDT
Received: from n7.nabble.com (localhost [127.0.0.1])
        by n7.nabble.com (Postfix) with ESMTP id 66E4214AF6C82
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 16:42:58 -0700 (MST)
Date:   Sun, 22 Mar 2020 16:42:58 -0700 (MST)
From:   itpenguin <info@itpenguin.de>
To:     linux-kernel@vger.kernel.org
Message-ID: <1584920578289-0.post@n7.nabble.com>
In-Reply-To: <0c5a4ca9d877c3d5b5ed57b96bfc0532@teksavvy.com>
References: <505f039bc185286b1295600807741499@teksavvy.com> <1444850729.6312.7.camel@falcon.homelinux.org> <410706506d73adeefedf5b6b21dcc6af@teksavvy.com> <1A7043D5F58CCB44A599DFD55ED4C9484693770E@fmsmsx115.amr.corp.intel.com> <e33a9301c7e02385c95ef36cd2dbd226@teksavvy.com> <1A7043D5F58CCB44A599DFD55ED4C9484693803A@fmsmsx115.amr.corp.intel.com> <8a2fbe014542329c06e09d7747faf50d@teksavvy.com> <1A7043D5F58CCB44A599DFD55ED4C9484693815B@fmsmsx115.amr.corp.intel.com> <0c5a4ca9d877c3d5b5ed57b96bfc0532@teksavvy.com>
Subject: Re: Re[6]: 3.4-rc smpboot: do_boot_cpu failed(-1) to wakeup CPU#1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a little bit confused about this thread, because I'm facing a similiar
problem on my system:

I have a CentOS 7.7 AltArch i386 installation:
Linux erbusze 3.10.0-1062.18.1.el7.centos.plus.i686 #1 SMP Wed Mar 18
12:57:13 UTC 2020 i686 i686 i386 GNU/Linux

on this CPU:
smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (fam: 06, model: 5e,
stepping: 03)

with these boot errors:
[    0.160538] Kernel panic - not syncing: Fatal exception
[   10.166450] smpboot: do_boot_cpu failed(-1) to wakeup CPU#1

I tried several different values of cpu_init_udelay in the kernel command
boot line, but with no changes to the described behaviour.



--
Sent from: http://linux-kernel.2935.n7.nabble.com/
