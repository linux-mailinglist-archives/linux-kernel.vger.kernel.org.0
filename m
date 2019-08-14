Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3C8D73C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 17:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHNPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 11:33:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36500 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:33:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so17780105wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 08:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wezvNzsbPOdhs76UIe/x9RS+uf1SoYjspj4YsVpNZmg=;
        b=AirFkJQL9TN5jDGBDQouT4zwR7HAbWVT5xV7x+lji8a4syzp0o8HEmuNr8IaGOMQFz
         bexjRDiTWTae5dI/FZUZ6D2BoEw0x1GnkMsEvECHhmM0bmH+5QRaGcy3ydRoJZsEVesQ
         l64N1XsWWDjZviiH6i+uHc4gSJlp65RZ91q9V7CzZ4/UUUa+WUK/b4TEtcA9EKEg6uG4
         1uViS4ftmxgeUW9rphkF0FO4x9c3ngBuz0asiGPIvrC4tTLV90XUmHpFrgL3ct5JJFaM
         txgOaUUiX/0N4a373q//VNVVv8AvH6r89ZufI0u4uW29Pv70cjrys7cyxyQ0kNGN5vLA
         qSnw==
X-Gm-Message-State: APjAAAXXLhvXmMFt/W6oFHnNg2RPD61J0rMAw/xTo/xIJ03PqBCAX0Io
        HNzXKJoQU+l4Dc9MGzHVrZawMQ==
X-Google-Smtp-Source: APXvYqyOqEDB5t53jRfZrYv/H24aoTGfHsRiquBPqEEx+NkHh83e/p0MfWTCyYkV/5EtCai7VdbETA==
X-Received: by 2002:adf:a48f:: with SMTP id g15mr335053wrb.172.1565796778631;
        Wed, 14 Aug 2019 08:32:58 -0700 (PDT)
Received: from localhost.localdomain ([151.36.169.182])
        by smtp.gmail.com with ESMTPSA id q18sm212768wrw.36.2019.08.14.08.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 08:32:57 -0700 (PDT)
Date:   Wed, 14 Aug 2019 17:32:54 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [RT] LTP perf_event_open02 fails on v4.19.59-rt24
Message-ID: <20190814153254.GE5834@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not sure if this has been reported before, but we noticed that LTP test
perf_event_open02 [1] fails on 4.19.59-rt24 (and of course passes on the
corresponding stable kernel):

--- 4.19.59 ---
# /mnt/tests/ltp-full-20190517/testcases/kernel/syscalls/perf_event_open/perf_event_open02 -v
at iteration:0 value:300248705 time_enabled:59735349 time_running:59735349
at iteration:1 value:300257285 time_enabled:61370669 time_running:61370669
at iteration:2 value:300270267 time_enabled:65415976 time_running:65415976
at iteration:3 value:300275002 time_enabled:65775683 time_running:65775683
at iteration:4 value:300279509 time_enabled:67043153 time_running:67043153
at iteration:5 value:300271722 time_enabled:64872370 time_running:64872370
at iteration:6 value:300272600 time_enabled:65373637 time_running:65373637
at iteration:7 value:300269069 time_enabled:63948439 time_running:63948439
at iteration:8 value:300286123 time_enabled:67285143 time_running:67285143
at iteration:9 value:265004128 time_enabled:50212657 time_running:44998204
max hwctrs=9
perf_event_open02    0  TINFO  :  overall task clock: 44753322
perf_event_open02    0  TINFO  :  hw sum: 2702062269, task clock sum: 402442898
hw counters: 194164023 191715624 195214062 201992170 208770596 215560607 218849512 218851570 218851437 217860513 213522050 206742793 199967312
task clock counters: 28725966 28724910 29224060 30220734 31216660 32211515 32706172 32700336 32693327 32503365 31504015 30505413 29506425
perf_event_open02    0  TINFO  :  ratio: 8.992470
perf_event_open02    1  TPASS  :  test passed
---

--- 4.19.59-rt24 ---
# /mnt/tests/ltp-full-20190517/testcases/kernel/syscalls/perf_event_open/perf_event_open02 -v
at iteration:0 value:308782766 time_enabled:69987925 time_running:69987925
at iteration:1 value:307230646 time_enabled:66629165 time_running:66629165
at iteration:2 value:307127853 time_enabled:64519500 time_running:64519500
at iteration:3 value:306408195 time_enabled:57616719 time_running:57616719
at iteration:4 value:306473441 time_enabled:57184704 time_running:57184704
at iteration:5 value:306324296 time_enabled:56319529 time_running:56319529
at iteration:6 value:307060120 time_enabled:62417456 time_running:62417456
at iteration:7 value:307666551 time_enabled:58920211 time_running:58920211
at iteration:8 value:306415586 time_enabled:56617543 time_running:56617543
at iteration:9 value:308025740 time_enabled:62503263 time_running:59956753
max hwctrs=9
perf_event_open02    0  TINFO  :  overall task clock: 49178216
perf_event_open02    0  TINFO  :  hw sum: 2773035141, task clock sum: 451529028
hw counters: 66671274 199200415 204422748 236485504 307467135 307472701 307478266 307483830 307489394 242524983 110001408 104784638 71552845
task clock counters: 11982838 33102129 33990719 38442306 49748594 49734632 49716493 49695178 49670953 39049846 17924067 17029183 11442090
perf_event_open02    0  TINFO  :  ratio: 9.181485
perf_event_open02    1  TFAIL  :  perf_event_open02.c:370: test failed (ratio was greater than )
---

--- Box info ---
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              36
On-line CPU(s) list: 0-35
Thread(s) per core:  1
Core(s) per socket:  18
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               63
Model name:          Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz
Stepping:            2
CPU MHz:             1237.805
BogoMIPS:            4594.31
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            46080K
NUMA node0 CPU(s):   0-8,18-26
NUMA node1 CPU(s):   9-17,27-35
---

I just started looking into this issue, but thought to report early as
to have more eyes on it.

Best,

Juri

1 - https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c#L21
