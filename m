Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4FB135C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbgAIPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 10:23:35 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:33381 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgAIPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:23:35 -0500
Received: by mail-qv1-f74.google.com with SMTP id g6so4333292qvp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HNy7hZEHqrPvuhZduQmJRe1uIw5w6ITq0q+7c4RSDGM=;
        b=d4yYCqe1woC1/Q1x8Lq+T+wMNybDW/BHjiK48ZLP0Z+jVVQBAuloCQrVhizbSHNM0I
         DiweaYDqwk+2ysFXwvOGLlX5Mk34WOe9OiBRW0yhhWw0M7pgalZYcEMPPstvwE9sW2eK
         0wXJkWRihAbS/V2DU2FjLRZiKIEHA2UTVNKa/LJnR1TTEz2NHLcXtX5OKj+/uppxpYGG
         jjplDUYwgWZzmU0ZEl9E77iQIQYjiY206fH8usdrpOBZWape+r29oh5kTAJ9cLPAM28v
         n/z7H221vsQamN4hOZab4Hh54GGtGq4BbASATSAifxh0r+lbZGBALNlMwG39loyaDrfM
         eX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HNy7hZEHqrPvuhZduQmJRe1uIw5w6ITq0q+7c4RSDGM=;
        b=fNIfXXkojcpsNtTjnOvJr1y/s5MbyNeLJK5xG7ME81HOao+81tAQQEg3Kt5h+wJIA1
         +01qFXS1fIoYS2xNk3qBOrIqJCyH4wt3qZO+evOnzU/eH9vsMW819Dxz98Toh3MGYT+Y
         9vvNwcVJ1pxFhC2ABZSg+naMrMnNaf6tMmpe982Mwysca1VzZIp8Dw2LrCpfCZHCaPbb
         afSN8AVDUcvq6433IotrXdKbKKdGnpEPjX0OtuhEyrArC7xK8L8mOfDX+Fd1IbLbl2vT
         F5ZsZkSYd0/MJVd/eQSG6SRer3MBefg/uyDRMHqBgLBITUTWcCecOJ2G8XZOdxz9ltW8
         knwg==
X-Gm-Message-State: APjAAAWRBfH5yINwHo4fPW2gHU+reJXj4LmG+KIQB3DzsIB+ahK6yG1+
        QQV9j2nVWAEUvZf0q6i0mroeMxceBg==
X-Google-Smtp-Source: APXvYqy4BQK9B7cBdpi6Tgo82EdDpRfmUeCMyiCw2sY+ff/yomldP04DIjK7Ykb5cXInObIuxGScOe3dUQ==
X-Received: by 2002:a05:6214:15cf:: with SMTP id p15mr9367520qvz.140.1578583414433;
 Thu, 09 Jan 2020 07:23:34 -0800 (PST)
Date:   Thu,  9 Jan 2020 16:23:20 +0100
Message-Id: <20200109152322.104466-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH -rcu 0/2] kcsan: Improvements to reporting
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improvements to KCSAN data race reporting:
1. Show if access is marked (*_ONCE, atomic, etc.).
2. Rate limit reporting to avoid spamming console.

Marco Elver (2):
  kcsan: Show full access type in report
  kcsan: Rate-limit reporting per data races

 kernel/kcsan/core.c   |  15 +++--
 kernel/kcsan/kcsan.h  |   2 +-
 kernel/kcsan/report.c | 153 +++++++++++++++++++++++++++++++++++-------
 lib/Kconfig.kcsan     |  10 +++
 4 files changed, 148 insertions(+), 32 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

