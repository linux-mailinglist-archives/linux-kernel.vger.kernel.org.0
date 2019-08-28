Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64D59F7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 03:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfH1BSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 21:18:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39512 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfH1BSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:18:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so1159796qtu.6;
        Tue, 27 Aug 2019 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVO0EmP8bgETNAWmu/dZljk7xUxfCY4Vvl+2mYBKa/Q=;
        b=h9DqAskH5PSRlu4JXgpJGdG2jAGpqDLKVO9rMXjX8l2+4hYhkCgPwJBk4WoDHEUJDu
         FH7wlSFr+xqAJaVmXNi4FuZs1uO+oIHCvPpWznB0gi2VM/AaxZvRG695R2jd6/MUuKRQ
         rodesmsKf4IEo/9ehHy/c1BhoI+CbNkXw6TqLzoE8eZF8MSFFFzoUfuX8kyf0HiVFLp+
         P/JV7RWhdC9d7YUtI08Ukv4kwNjfQcNkAiE7km+WNk7sdZvwWspJU4A8cx/MBCMx47Ko
         rvd4bHw5wIuObXiM/p6jktVGTDKOuy1N0NDbkK/cCoInInm9RJA97vb9bljRtO9bip6q
         oV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pVO0EmP8bgETNAWmu/dZljk7xUxfCY4Vvl+2mYBKa/Q=;
        b=QLIsq4iHhVOhEpda4qc3eDKCmoHwKoOd4gY0o9iJUGsXu23EmQ8EbzC0CYQ4NuPgh9
         m+6NM9tN49U2vPQDlBG+0gUsX0v5eclu+06Nx+YlG9tZuzkN172nsSCapidfclAmk+zZ
         uZiWlHmWd6fp/gvDawRuO4vAo+TINRyiV3+IWNxnsHePxBuaax1ViP+iXtqZfkWSY9Xs
         sLoRaozkuzbkJ3fP9YBF6ntqBSmmFDJjmOmtCcXUHoblhJgheSM7K4N0SUNZf2SX8UU9
         3HKQCvr2ZO5r5HnQ1cMqdmOEixbtbsPFN9g2ip+D7eh4cwYtIgsd4gL6Svevi3h5pXqg
         EnhQ==
X-Gm-Message-State: APjAAAUaVUpbQTfmsPVViLxF2B/UoMawkRS1+yQK/Y9K0IwnOCetPf9w
        U0w3Dgz9igzFx9wluPNuOTSAKsnIYrM=
X-Google-Smtp-Source: APXvYqwmEYVu0hF+4f82A4tRmuCo7uKVyjRzo1QN0ztgRGurgAwL/9t3nUuyQmBSvW3R1mw3jw5Gng==
X-Received: by 2002:a0c:abca:: with SMTP id k10mr1185339qvb.177.1566955128607;
        Tue, 27 Aug 2019 18:18:48 -0700 (PDT)
Received: from localhost.localdomain ([186.212.48.84])
        by smtp.gmail.com with ESMTPSA id c201sm499231qke.128.2019.08.27.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 18:18:47 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [RESEND PATCH 0/4] Remove elevator kernel parameter
Date:   Tue, 27 Aug 2019 22:19:26 -0300
Message-Id: <20190828011930.29791-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a resend, now with reviews by Hannes and Bob in place. These
patches were based in linux-block/for-next branch.

Original cover letter:
After the first patch sent[1], together with some background from Jens[2], this
patchset aims to remove completely elevator kernel parameter, since it is not
being used since blk-mq was set by default.

Along with elevator code, some documentation was also updated to remove elevator
references.

[1]: https://lkml.org/lkml/2019/7/12/1008
[2]: https://lkml.org/lkml/2019/7/13/232

Marcos Paulo de Souza (4):
  block: elevator.c: Remove now unused elevator= argument
  kernel-parameters.txt: Remove elevator argument
  Documenation: switching-sched: Remove notes about elevator argument
  Documentation:kernel-per-CPU-kthreads.txt: Remove reference to
    elevator=

 Documentation/admin-guide/kernel-parameters.txt |  6 ------
 Documentation/block/switching-sched.txt         |  4 ----
 Documentation/kernel-per-CPU-kthreads.txt       |  8 +++-----
 block/elevator.c                                | 14 --------------
 4 files changed, 3 insertions(+), 29 deletions(-)

-- 
2.22.0

