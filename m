Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D64BFCF9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfJHMgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:36:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55509 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:36:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so2950525wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kc2Ivzmz/SqwidGdqpK+CvkXVy5k2Sl1jkfVbY/LHJY=;
        b=q7SplP/Y/2yE40tNY379pmoTEnauF4kpPRy2t/ObYgeynDMhWlZfiMFRIGTUrMwKkL
         tIC/4SAgt7me05rlP6uVlS7/9YDTCaUBkDhxKEe6CZoQNmeCi+LcAn+KL5jV/N7x+EuH
         MZP/9SGzmjM+4JOu2k82PxV0Sfmt8J8Pdp8BO1rvNu9Ooq9rH1XECqnBBJUJzVhBaaHu
         NAcUga0gC577BnN320mwrncTSPpbLjbvCpWlGKHnFSIaWU2n+Bcy2DafGWeaGwI4mID+
         O768xU5EMNhRiWvnOSlS1RStSUPbBCYeRc+RU6wXL0MY3ZPrZ/wc3SNtgrkLxrGrwZeK
         0EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kc2Ivzmz/SqwidGdqpK+CvkXVy5k2Sl1jkfVbY/LHJY=;
        b=OBWZVyLDvc4bfgHpODEFnFQhpwbMnx3QMdCNFxOZ+wo/gY6uiL21KRLiOnFH2cwBZw
         WAVck6RaW7cZzcNs2ZvRb/DbVp9iiPXQCaNWBgNOnbK6kD9hI/jl387WUokOs8gr9auB
         SGCrHz7hAXwzrDiFZi3U+b2DtieRvbYJVFpbnblPZHShyAoZSoTolz8tV48eU55LwRXB
         aV18eSC1Cge/AhEZrUt2rwUljvKoIwSoGBO5suwSHWaKq0dDOlowJ/uNMXH5wwIekyBI
         ZR6CAPkeL5sV6WFku0DojMactFIqK1+ZH8dQiNr6rzNs9EY3wFnuSAry/B7rmMoYWjU2
         wvSQ==
X-Gm-Message-State: APjAAAU0fcMLJYmM9c9SsBouf/JDyLxFeW5eku/LUgiwRmjEZPLPEPkf
        2MeG5BxEgeL8ClCrCHzbE3g=
X-Google-Smtp-Source: APXvYqyTG1vPuj0rzqQjBmow3gco42j2U9YKMZ0Jhh7u5quThdvAtxCyg6tyK0Liil6REULqLNDf5A==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr3778582wme.164.1570538168133;
        Tue, 08 Oct 2019 05:36:08 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id d4sm23100575wrq.22.2019.10.08.05.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:36:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 0/2] perf: add support for logging debug messages to file
Date:   Tue,  8 Oct 2019 20:35:52 +0800
Message-Id: <20191008123554.6796-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in TUI mode, it is impossible to show all the debug messages to
console. This make it hard to debug perf issues using debug messages.
This patch adds support for logging debug messages to file to resolve
this problem.

v4:
  o fix another segfault.
v3:
  o fix a segfault issue.
v2:
  o specific all debug options one time.

Changbin Du (2):
  perf: support multiple debug options separated by ','
  perf: add support for logging debug messages to file

 tools/perf/Documentation/perf.txt |  15 ++--
 tools/perf/util/debug.c           | 124 ++++++++++++++++++++----------
 2 files changed, 91 insertions(+), 48 deletions(-)

-- 
2.20.1

