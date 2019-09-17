Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC59B5360
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfIQQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 12:52:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbfIQQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:52:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so3965301wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evGS757tUJRmyH52cxf9DkgpsYSHsrNAYfq4amowEcw=;
        b=SzvpovQ546505iDrUP05F8IpyFdT1dpX3Y/0NcmUEIc0FreHeRRL31AHZUNYbgyPmU
         oC+YkPCDQz0FAXCkH7NGK1kJ7afkoEZMAXl4FCPEm5VmQfRkExTaPCvtYx/0mjpp7J+I
         T9SexfGNqMRUy7TsivzQIk3QYp3JuOrTVsInW+L/jqLujZ8BP+KbMzHgeEcV4GPmdv4r
         opVw2WZBeKC5M3PZUGrDRuECiMA5gr3eekLGkXE7NUkBzRdNmArqYjllfzUk2Xmdon+7
         a+nBopIS4wLmoETEBmcew/feLr37/N9H97NGyKsnhSwhywZFWt4ccP4ZjiWPyY3Bkg4N
         vF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evGS757tUJRmyH52cxf9DkgpsYSHsrNAYfq4amowEcw=;
        b=ERliOWzqhDEDLe1MTGFHesgW6abC2MIC8npPEnOos8/8QGOn777hsG6V8H/eI05qw3
         iNRBkaJUBVwwPnBKNiiOWL6/DBsmWdbgIwn6I6DzwDkP4Zeo/g6IBphrgDY5FsALQOFg
         MZdEsVbDDv54Jl7oY8gBSwnMN5bWPM/T2F7CPKCQmcWmAA9IcyHmWX9MxbI6f4rgwkhV
         Ivdqq2RDwxSGUPZbpHJ6cJK+oW0/Ooc6QjJp4Bt1NDCPfV4nt1J9Pv0pM2kka1hJfs8F
         8tUasVGVnQbGx9o8YwECVvWSjHyNYe18nKjcpEyJTNYllQjQdjyxbuRRacrYEhIVajdH
         t6cw==
X-Gm-Message-State: APjAAAX+YQAQrGnoucoZcwc5iHKZH4el/hlXgtf+RZwxxfi1JhQB8GKE
        E0HqbJQCn4rEy0T5fUWXLnRK5DHBbbk=
X-Google-Smtp-Source: APXvYqwF4qKDqJDaznPd8mF/OQbDHcZh290VNcmFnJQXI03OrOsRsfQYFuIXzoCCXXDwTmqPkiNfaA==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr3540087wrm.238.1568739128540;
        Tue, 17 Sep 2019 09:52:08 -0700 (PDT)
Received: from localhost.localdomain (146-241-53-114.dyn.eolo.it. [146.241.53.114])
        by smtp.gmail.com with ESMTPSA id g73sm4012378wme.10.2019.09.17.09.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:52:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/2 block/for-next] block, blkcg, bfq: make bfq disable iocost and delete bfq prefix from cgroup filenames
Date:   Tue, 17 Sep 2019 18:51:46 +0200
Message-Id: <20190917165148.19146-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
here is the pair of patches from [1] and [2].

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/9/16/469
[2] https://lore.kernel.org/linux-block/20190917151334.GI3084169@devbig004.ftw2.facebook.com/

Angelo Ruocco (1):
  block, bfq: delete "bfq" prefix from cgroup filenames

Tejun Heo (1):
  blkcg: Make bfq disable iocost when enabled

 Documentation/admin-guide/cgroup-v2.rst |  8 +++--
 block/bfq-cgroup.c                      | 48 +++++++++++++------------
 block/bfq-iosched.c                     | 32 +++++++++++++++++
 block/blk-iocost.c                      |  5 ++-
 include/linux/blk-cgroup.h              |  5 +++
 kernel/cgroup/cgroup.c                  |  2 ++
 6 files changed, 71 insertions(+), 29 deletions(-)

--
2.20.1
