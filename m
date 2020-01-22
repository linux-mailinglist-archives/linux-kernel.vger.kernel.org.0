Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED9D145FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 01:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgAWAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 19:05:13 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:35612 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 19:05:13 -0500
X-Greylist: delayed 686 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2020 19:05:12 EST
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4832L11f2RzQlK8;
        Thu, 23 Jan 2020 00:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :date:date:message-id:subject:subject:from:from:received; s=
        mail20150812; t=1579737221; bh=RlTYagtE0Y2jBQvGzX/oU7Zv90M8RS8sR
        0yP0FWGJ8U=; b=gp/etqk6joLXcIVQ4dHrf8y90JzjW15FSk5kfldR3b1sOHwoa
        uSFs8xNsRmQcKwKWr68keKuk8V6BbNFZgPAfcC6uq4MO3CuwbfnqE0EHSjydKHZF
        2IK+cmYqx9nxgpRrpbGhopw6BxYtyjb+hragNhuzyDBd0scrCdqEBj996FDjWZ/V
        zwy0Q+umFMfUepcbze0lx2bBWmuiyAYt9mAkQfaKTdL0WWXWAhAI5p2SoZwBEEuH
        rDurdh5L21EDgWAsD01fx8eQrGWqlN9YLJ+nUF+0weTbX/2694GC4cA/+cJdiMuk
        Eu6UNlqpFWaLKUL4WVkEh0cigjYR63kxuURGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1579737223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/lKQAmiL6ZEPbkqRekvrQ5+BuU6tZpGnuiYI0qtUD9g=;
        b=wp4UXB+4qdIEjrAaWAdfwCLr5qi6dzOKQOzKO8F3Ujr/hQcDwpdUop5EtYVCp//PUwUGDS
        QISzcUZaDoIrlfU1g+A/Pf2+h80039m/cCDmQnOtsmctfQc1dHdHgVruiGyRn4uCHKcHVl
        iBUJIv8g5Bx+K55bc+KEZHYEUU4vh2h9EOZhyShMtiPSNFRZgB77OOHEzJeMVvXXlNMb2Z
        Lh5oRllZ0Pl4ep5d0xdMcRwxYOMfshKkQZCmaMokwoeIZWSEM+st7phf58e63i2iUX/AiT
        2zi2Z6kvMrLPgnn6O6Ls0us9B9cnxY+b9Tng5N9VDRo5/6n5NiVQU0yXKZ6E3g==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id ahvb0Uuq_YQF; Thu, 23 Jan 2020 00:53:41 +0100 (CET)
From:   =?UTF-8?Q?Bernhard_=c3=9cbelacker?= <bernhardu@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: linux-perf-5.2: perf report: segmentation fault accessing
 browser->he_selection
Message-ID: <48b757ca-8861-b84d-6d8c-314be93ccdc7@mailbox.org>
Date:   Thu, 23 Jan 2020 00:53:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
in Debian bug [943398] another user reported a crash of the
perf application. I tried triaging the issue.

I could reproduce the issue using linux-perf-5.2
and it is also visible in linux-perf-5.4 5.4.8-1

With following commands:

   perf record ls
   perf report perf.data
   # Press enter

The crash happens because in line 3172
function hist_browser__selected_entry returns
browser->he_selection, which is at this time a
null pointer.
This null pointer gets dereferenced to
access the res_samples member.

Other occourences of browser->he_selection being null
seem to get fixed in [1], but this is
already contained in 5.4 while a crash still happens.

It got reported to be visible also in 5.5~rc5.

Kind regards,
Bernhard



Program received signal SIGSEGV, Segmentation fault.
(rr) bt
#0  perf_evsel__hists_browse (evsel=0x55e794ebcb40, nr_events=nr_events@entry=1, helpline=helpline@entry=0x55e794f7c040 "Tip: System-wide collection from all CPUs: perf record -a", left_exits=left_exits@entry=false, hbt=hbt@entry=0x0, min_pcnt=<optimized out>, env=env@entry=0x55e794eb54f0, warn_lost_event=true, annotation_opts=0x7ffcc3063dc8) at ui/browsers/hists.c:3170
#1  0x000055e79385cce9 in perf_evlist__tui_browse_hists (evlist=evlist@entry=0x55e794ebc0c0, help=help@entry=0x55e794f7c040 "Tip: System-wide collection from all CPUs: perf record -a", hbt=hbt@entry=0x0, min_pcnt=<optimized out>, env=env@entry=0x55e794eb54f0, warn_lost_event=warn_lost_event@entry=true, annotation_opts=annotation_opts@entry=0x7ffcc3063dc8) at ui/browsers/hists.c:3422
#2  0x000055e7936f1ece in report__browse_hists (rep=0x7ffcc3063c30) at builtin-report.c:585
#3  __cmd_report (rep=0x7ffcc3063c30) at builtin-report.c:930
#4  cmd_report (argc=<optimized out>, argv=<optimized out>) at builtin-report.c:1475
#5  0x000055e79375b823 in run_builtin (p=0x55e793a9ef90 <commands+240>, argc=2, argv=0x7ffcc30661f0) at perf.c:312
#6  0x000055e7936d6a2c in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:364
#7  run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:408
#8  main (argc=2, argv=0x7ffcc30661f0) at perf.c:538


https://sources.debian.org/src/linux/5.4.8-1/tools/perf/ui/browsers/hists.c/#L2217
    2217 static struct hist_entry *hist_browser__selected_entry(struct hist_browser *browser)
    2218 {
    2219 	return browser->he_selection;
    2220 }

https://sources.debian.org/src/linux/5.4.8-1/tools/perf/ui/browsers/hists.c/#L3170
    3170 		nr_options += add_res_sample_opt(browser, &actions[nr_options],
    3171 						 &options[nr_options],
    3172 				 hist_browser__selected_entry(browser)->res_samples,
    3173 				 evsel, A_NORMAL);



[943398] https://bugs.debian.org/943398
[1]      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/ui/browsers/hists.c?id=ceb75476db1617a88cc29b09839acacb69aa076e
