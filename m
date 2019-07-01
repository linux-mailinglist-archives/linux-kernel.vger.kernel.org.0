Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24A249A7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfEUICe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:02:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37743 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfEUICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:02:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so1814209wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MML/1gKslJUEZaoKS2ap50AUCyXZlpKalFW++bdPM4I=;
        b=Gfhn08Qv2HZPlVh2KlZiF/GU+ciYzqcV9crWVGIfJn9A+rgwvsDkGFjtfGC5O1xgYc
         AqtxWTomoDw19iV1lwme9ydg5L6AGcsP//VK56lcFI1rdtwKcwVH33tknzCAphPhK7hF
         qdDkL3VsL3cPSxpQ/QNXrv44mx6JHRY6rdzTKq64BZO4ryCulk+dACII/qFRoFPjTn1k
         p5hBwWGwN8e580LgOzFyjHXhLFocRTAztBD0WT44Toxa4PhFUpA3hbl/9jZOYSFppgQF
         pstp45RWU5uGDSt3LIzi17ujP4WiBS99s3ZUye4DpL4qt3VNHp8wfs0pAj2KsQD2PJ+H
         gk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MML/1gKslJUEZaoKS2ap50AUCyXZlpKalFW++bdPM4I=;
        b=c2sokKCVtlpwdzZ69V3FUn8DVf38HtPT0pKVRx/dLApfDd32UBI8fQPEATe0KI9Hk3
         LVHGHzqH0Flax0wUGgLtcuyvbRUWI9SMVJRF+xFmTSDAgxmSiA2rpG+3G1HyekfeJwzj
         J9xYt4p92c/N/cf6EWX2709F6nw+fh7CbcMqjQ1iMiBjlDePHModZq73YFgDT0Drq0I/
         Rri7MORZfy1ni3MITuXDGSltxiKeANOJtEBu4JyI4k0ogF7M+zEuKEa148zbAufwpKyf
         gnc69ayjpctVRv6+wk4qqjs9152SdafAtTBFPnMdyqRn/ftuw/2PdZ0Lq9aZ2je17/dI
         p8bQ==
X-Gm-Message-State: APjAAAUk4Wd8hLt+l0HjKgprH36Kj7U5tT4BnKR9nalMaCuzZaU2huLe
        DE8FrtiWNzQiOaggiVaRyA4Wbw==
X-Google-Smtp-Source: APXvYqxU9fZF+Dz+PVqxRsKzUw+RbowpnGftouoaUHRDJBw1l8rV1OF+DHNe3u7hzUEm5wkN4UVvMw==
X-Received: by 2002:a05:600c:21d7:: with SMTP id x23mr2413926wmj.87.1558425752088;
        Tue, 21 May 2019 01:02:32 -0700 (PDT)
Received: from localhost.localdomain ([88.147.35.136])
        by smtp.gmail.com with ESMTPSA id p8sm11322301wro.0.2019.05.21.01.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 01:02:31 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/2] block, bfq: add weight symlink to the bfq.weight cgroup parameter
Date:   Tue, 21 May 2019 10:01:53 +0200
Message-Id: <20190521080155.36178-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many userspace tools and services use the proportional-share policy of
the blkio/io cgroups controller. The CFQ I/O scheduler implemented
this policy for the legacy block layer. To modify the weight of a
group in case CFQ was in charge, the 'weight' parameter of the group
must be modified. On the other hand, the BFQ I/O scheduler implements
the same policy in blk-mq, but, with BFQ, the parameter to modify has
a different name: bfq.weight (forced choice until legacy block was
present, because two different policies cannot share a common parameter
in cgroups).

Due to CFQ legacy, most if not all userspace configurations still use
the parameter 'weight', and for the moment do not seem likely to be
changed. But, when CFQ went away with legacy block, such a parameter
ceased to exist.

So, a simple workaround has been proposed by Johannes [1] to make all
configurations work: add a symlink, named weight, to bfq.weight. This
pair of patches adds:
1) the possibility to create a symlink to a cgroup file;
2) the above 'weight' symlink.

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/4/8/555

Angelo Ruocco (2):
  cgroup: let a symlink too be created with a cftype file
  block, bfq: add weight symlink to the bfq.weight cgroup parameter

 block/bfq-cgroup.c          |  6 ++++--
 include/linux/cgroup-defs.h |  3 +++
 kernel/cgroup/cgroup.c      | 33 +++++++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 6 deletions(-)

--
2.20.1
