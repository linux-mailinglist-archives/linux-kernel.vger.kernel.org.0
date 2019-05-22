Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07DAB27142
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfEVU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 16:59:10 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:46526 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfEVU7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:09 -0400
Received: by mail-lf1-f52.google.com with SMTP id l26so2717742lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMtXEQ7J2EmiYI54BB3lm8CW7jtuHp2F5Gc+YkDY41M=;
        b=TfeYMnlfKI4zs58kUWYG9LrZ7tQtYxVNbmUbDUyPfmaXluFwe8CwcwR8gOFdgsyCCA
         AC3xePGqQ9brYSfmpsPLDznUYHlFD1VOe0vnzravjthD+wMcmdqdGZeSRS2rci280A2O
         IykWTDC1sA2P9DB5wr78gmImPD9dexAGWD+ttr9hBZe+Y8uolJXkfiCET3v2CldTiK+g
         /0TEGBpi1FPoATDSgYCsc2WBscb+6/hEfMjsjvEYw9EGIToSu/aB7gY60srypNsw6s0P
         /oIswPTfSct3V30ihrWfK3QtWrMkGl2n0S9sTSEfF3QEmUV+BVQgwquODOu5xhy2UUgU
         nAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMtXEQ7J2EmiYI54BB3lm8CW7jtuHp2F5Gc+YkDY41M=;
        b=TBggRF/yp0uKQBvbldIiuLO7hmZQUwgXpqBlKeDlHl5hOeRpBS7xyE9yX1hRAjjYJh
         lG2dFbHMJFlEBqhWdxuhUgdSaCu2dZL8/xyQ8K+0vnPlCVAUG/WkmgWW9iWikQhVOJqq
         fiHwtsWged92ChxSXlUyzwUTB5Awad+sLA9RCFT2DSHlOOSLW55i2iMtZhQcQvrozxG6
         qM4yCvuQZv2GZAz5YdH4pT+D/fxDk+5SOCEbybWPV6V1hhf8Cmvn8T3wMRG95jHBoNgg
         sEBmYb/67F6KB1/EtGnEQxL2koJuEbjtsj+5UEEW1aVaJwsDtOY1J0A9v86zAF9YbH1H
         rxNA==
X-Gm-Message-State: APjAAAWyC2CDaDpuKx4wvNGQbWaFB5Ooz9mmx0k6qBmYO9v9FjKb8ufO
        dRCUID59AeLItW746HlQ41YTGg==
X-Google-Smtp-Source: APXvYqyQavIfvwAF8g0ZurPWxlCW4ymt+BaH9e+cHm5oL5V0VUiqti4EtoUjPKoAE9Dd3cXYJg79PA==
X-Received: by 2002:a19:a8c8:: with SMTP id r191mr44713147lfe.85.1558558747844;
        Wed, 22 May 2019 13:59:07 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:07 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 0/6] Fix coding style issues in drivers/staging/kpc2000
Date:   Wed, 22 May 2019 22:58:43 +0200
Message-Id: <20190522205849.17444-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fixes a bunch of minor coding style issues in
kpc2000/cell_probe.c.

- Simon

Simon Sandström (6):
  staging: kpc2000: fix indent in cell_probe.c
  staging: kpc2000: add space between ) and { in cell_probe.c
  staging: kpc2000: fix invalid linebreaks in cell_probe.c
  staging: kpc2000: add spaces around operators in cell_probe.c
  staging: kpc2000: add space after comma in cell_probe.c
  staging: kpc2000: remove invalid spaces in cell_probe.c

 drivers/staging/kpc2000/kpc2000/cell_probe.c | 585 ++++++++++---------
 1 file changed, 296 insertions(+), 289 deletions(-)

-- 
2.20.1

