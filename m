Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43353952A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfFGTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 15:02:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37456 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFGTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:02:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id m15so2399863lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7TSC6Lcwt0ziWmC1KdJukuudhzzptcOYMXG61hkW4JI=;
        b=FODScLNoVtC3Y/vqI6A6HAMUtssJMFzduhqVCTFGUMv1NX1ozThF2CJIwJ4xg1jjlm
         EHg5aC05/lgwzGRgG3M+hxFH1+mErHCFFwsRlICqw4JbsU0sBUb4O/JH4IdHYtMnWsfV
         /+jx7BCFGndgVxdUHPhrjY6Aa+5nQ46UZaDSwonbahxbn6ylinqZ6bFWc3dXCW2hm4NP
         le9oYV/PnbahgQSQT9Txc7AUW10pn4euHcydnfk5DYkPYwG/izRY2wPpWVE27dGUlT11
         oIpRme84lGKm1Mj05peta2xYk+dsKA2DoDBnerJBrj7a5Th4s8W+OjESvGv7XcNzRJWu
         w8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7TSC6Lcwt0ziWmC1KdJukuudhzzptcOYMXG61hkW4JI=;
        b=CuNp8oaxPj8SXNiqzfb2JokxbQV4F28uSg1b+6o1ENwW7G55AYTfYqbH/q+6GCn+mB
         IIgNwFFVTb7mApcX6cOYKyDGHxI2YeIsvuQi2j+H96+eL/12bDZE2JJYrpgzdeVFX5BK
         9+2sYUUWEdDTJVzjWw/TPIKjtjx+0u2R647xiZa84gBUuEjbrGnw+QuM1oCXZ6MHlYhS
         W8Lkg4JNAXe3JTbuNM24ibEn6/DNVtIn3bOOKvDs4tdcgX/Zggi6PlAHr0ROq+AmwpQh
         pa5KfPMdBzxj6LBLtZQvHDeloJYxeBMv3f9QCIcokk42lG6gWMpmqzPvhk1TwqHSBfdY
         iE9w==
X-Gm-Message-State: APjAAAXr+A1YlbeOe2/6WUqUx8NoZHGeo66Mkq0vjokGXPQwpePBg/Ul
        LgY6nPSG075JyPBMb+G8VNg=
X-Google-Smtp-Source: APXvYqxBjO0yyL9+zsTgH4glhJuLGhdeouDe6vBMtMHweRdY0hKv3KnTkMJMHNbbFk/2HMZOXy1SVg==
X-Received: by 2002:a19:4c05:: with SMTP id z5mr18847629lfa.5.1559934119797;
        Fri, 07 Jun 2019 12:01:59 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id m24sm528507lfl.41.2019.06.07.12.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 12:01:59 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/1] xtensa fix for v5.2-rc4
Date:   Fri,  7 Jun 2019 12:01:31 -0700
Message-Id: <20190607190131.4252-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fix for the Xtensa architecture.

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190607

for you to fetch changes up to adefd051a6707a6ca0ebad278d3c1c05c960fc3b:

  xtensa: Fix section mismatch between memblock_reserve and mem_reserve (2019-05-30 06:53:53 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.2-rc4

- fix section mismatch between memblock_reserve and mem_reserve. This
  fixes tinyconfig xtensa builds.

----------------------------------------------------------------
Guenter Roeck (1):
      xtensa: Fix section mismatch between memblock_reserve and mem_reserve

 arch/xtensa/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Thanks.
-- Max
