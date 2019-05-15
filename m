Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A131EA95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfEOJD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 05:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEOJD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A1067BEE3;
        Wed, 15 May 2019 09:03:56 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EC105D9DC;
        Wed, 15 May 2019 09:03:56 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0B78F18089C9;
        Wed, 15 May 2019 09:03:56 +0000 (UTC)
Date:   Wed, 15 May 2019 05:03:55 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     ltp@lists.linux.it, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, dengke du <dengke.du@windriver.com>,
        petr vorel <petr.vorel@gmail.com>
Message-ID: <543317293.22835729.1557911035979.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+G9fYu254sYc77jOVifOmxrd_jNmr4wNHTrqnW54a8F=EQZ6Q@mail.gmail.com>
References: <CA+G9fYu254sYc77jOVifOmxrd_jNmr4wNHTrqnW54a8F=EQZ6Q@mail.gmail.com>
Subject: Re: LTP: mm: overcommit_memory01, 03...06 failed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.10]
Thread-Topic: overcommit_memory01, 03...06 failed
Thread-Index: nXsr2eOmSs8GKetOjInAzndms9fFPA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 15 May 2019 09:03:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> ltp-mm-tests failed on Linux mainline kernel  5.1.0,
>   * overcommit_memory01 overcommit_memory
>   * overcommit_memory03 overcommit_memory -R 30
>   * overcommit_memory04 overcommit_memory -R 80
>   * overcommit_memory05 overcommit_memory -R 100
>   * overcommit_memory06 overcommit_memory -R 200
> 
> mem.c:814: INFO: set overcommit_memory to 0
> overcommit_memory.c:185: INFO: malloc 8094844 kB successfully
> overcommit_memory.c:204: PASS: alloc passed as expected
> overcommit_memory.c:189: INFO: malloc 32379376 kB failed
> overcommit_memory.c:210: PASS: alloc failed as expected
> overcommit_memory.c:185: INFO: malloc 16360216 kB successfully
> overcommit_memory.c:212: FAIL: alloc passed, expected to fail
> 
> Failed test log,
> https://lkft.validation.linaro.org/scheduler/job/726417#L22852
> 
> LTP version 20190115
> 
> Test case link,
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c#L212
> 
> First bad commit:
> git branch master
> git commit e0654264c4806dc436b291294a0fbf9be7571ab6
> git describe v5.1-10706-ge0654264c480
> git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Last good commit:
> git branch master
> git commit 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
> git describe v5.1-10326-g7e9890a3500d
> git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Heuristic changed a bit in:
  commit 8c7829b04c523cdc732cb77f59f03320e09f3386
  Author: Johannes Weiner <hannes@cmpxchg.org>
  Date:   Mon May 13 17:21:50 2019 -0700
    mm: fix false-positive OVERCOMMIT_GUESS failures

LTP tries to allocate "mem_total + swap_total":
  alloc_and_check(sum_total, EXPECT_FAIL);
which now presumably falls short to trigger failure.

> 
> Best regards
> Naresh Kamboju
> 
