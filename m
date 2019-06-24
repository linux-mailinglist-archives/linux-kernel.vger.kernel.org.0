Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0E51B86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfFXTlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:41:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40336 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFXTlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so15157182wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6McyXpHhvJ62Wx5SvCqGaB8/OSzRVB/5VC6vTy2TqQ=;
        b=M48+BroHFQYMi06n4mupqxhg0lJK+JUAVqf5zHxFG54TrAZYIrIWtQUPbfLJhowVfY
         nha7AD8YdXoLitLaAIuvmXGtIlr0gJfEkS8Ir4FSHGlf6R191KkvGz+ie7RevmS0hbyH
         tOIz9XGsYXVfkUZxFaUZQaMcXIKXc3VdKe/8I09ftsegvoJ6IONcP55/knMzWpu5v9+V
         Wi3TELxFuVq+OGYDSZ1Az+t/uyW1KrJZvtZlrVf8zaporbdn9tEexXV4RvLls+RjZWls
         lh6ZfGKNdpHun6Ky9xnYfIbip8UwcW4DPTnmTk7Txy+AeSEwTYHjDkawFzMMt8SqFQKV
         P/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6McyXpHhvJ62Wx5SvCqGaB8/OSzRVB/5VC6vTy2TqQ=;
        b=Pn9UJOINdIKEpZ2e3QhV7WyPHrXjhaurI7ehlxz3VFlU0rpuXQ8PqlO3ZlpBGS25Se
         Uub9hg+Bam7+gtD40J+X9g6EKsWSmMOEktTqv2PlDUuH3f1dv2m/wflz52JTbuOrW6/8
         62WKlT3cq7TozcjLxMFxKpNHn1CuZH35PJnGshG/bZwLNnLGT+yjXWBxbYQ+MyM07yVM
         7wn9vRPyyqm04lwJLT891OI888MxBMGqb4R5SKpA7WwpvBQHv5oh/A47jCOHUFcvEybw
         OJTeLz/R2UeKZt2Osjj5herxLRDDtCTxh0i/G+ks/bR8cAqZBkRBDeWA16J15W3MYu9U
         Narw==
X-Gm-Message-State: APjAAAW8y/eb/+SMfWO6ixap1wMvwrrkarslOzCY3LnPzgjgWjH72fVF
        fKXhTGLxV9FLNXgmoyCGhTWhng==
X-Google-Smtp-Source: APXvYqyD1eXJ9voOpGfL9zu8E91jQPk0kmAnjvPBM0hwFXNjfqm/29dKOBYYxImoXX6UVfSxyoJczA==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr37375067wrn.54.1561405265273;
        Mon, 24 Jun 2019 12:41:05 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:04 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 0/7] boost throughput with synced I/O, reduce latency and fix a bandwidth bug
Date:   Mon, 24 Jun 2019 21:40:35 +0200
Message-Id: <20190624194042.38747-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
this series, based against for-5.3/block, contains:
1) The improvements to recover the throughput loss reported by
   Srivatsa [1] (first five patches)
2) A preemption improvement to reduce I/O latency
3) A fix of a subtle bug causing loss of control over I/O bandwidths

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/5/17/755

Paolo Valente (7):
  block, bfq: reset inject limit when think-time state changes
  block, bfq: fix rq_in_driver check in bfq_update_inject_limit
  block, bfq: update base request service times when possible
  block, bfq: bring forward seek&think time update
  block, bfq: detect wakers and unconditionally inject their I/O
  block, bfq: preempt lower-weight or lower-priority queues
  block, bfq: re-schedule empty queues if they deserve I/O plugging

 block/bfq-iosched.c | 952 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h |  25 +-
 2 files changed, 686 insertions(+), 291 deletions(-)

--
2.20.1
