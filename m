Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2976865A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfGOJcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 05:32:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38847 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbfGOJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:32:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so14441233wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eM8zTsGyf584RmX/FkfC6pSZbSa4qt71o0cGq7/Ass=;
        b=ttETt1Q5sinqI8hZDNkG/TMjeRA5i6HVLX4POPVD5jCR71MlEtJ2S6jSSTWUiHS/Np
         ILij4ADgSI7gyshL56Yb/bcxN/Obvy48UOq/4P7gmxvanXIHdtwg5UNgcZkqEXrPgFVE
         0SgfMl7/tibK8yB+Kept+iY1mm+vOQvERkCZOC6ciogzck711bFVH/5+8wCSl7JP35Gi
         S1OcmqQcyOANTBkmzbFXiUiRLLLwh+CeRhs4+/+dWJsRFsQkk58ePdVBQCWCpdEG6kmr
         b/9iltvzo/UHWnUSI7wUpOhfcuwFXjrNxwnFd+JSRpXYeH2dT2KVBJ5nIXCevInoju8K
         2N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eM8zTsGyf584RmX/FkfC6pSZbSa4qt71o0cGq7/Ass=;
        b=ZhWR4LzHuvqLLyxDy/2dBnmVOG+Gdroia/d/39PGF2cXVNQtuHSgnwMQKswJE1KvJl
         GvgWHl3z9XOrnAug6tHQe2DbgTB7R4YCnJNef2k0JyBSBJt0kK2MMlBDo8N74HaR9JXI
         OSG4pOBI28RDckNQhe6RVKTo3oC5dr9AUXWCZIxbGjCBHoHwqpuDTp0dgI9ekdz/cFcy
         4T3V6hm47oTfv8hDql9e2+KaSahQqC/f3yx+7uirBlGRle/uK0CVJnedYzVd158XXymy
         acu8DchhsTQmqaXl196WrXMTxGzrfEK5h3QQqG5qhqvkxwJc7ULQqyKNwYA5520vw9RP
         NCAw==
X-Gm-Message-State: APjAAAUISw4if15MwVCmU+JrMvx7ObQeI2xkTP+/3Ftoto7Ey3kE0W39
        lxuFGTJlgBFFHA+u8nt0ucR4vQ==
X-Google-Smtp-Source: APXvYqxjaXB7dBtLJSDCQ1FAMQDvr+AHekW2YTw088x8woO8LTCaZpggG1e+c1gd2u9LFH1R4Zbf2g==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr23020807wmf.119.1563183127246;
        Mon, 15 Jul 2019 02:32:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id g12sm22544993wrv.9.2019.07.15.02.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:32:06 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 0/1] block, bfq: eliminate latency regression with fast drives
Date:   Mon, 15 Jul 2019 11:31:52 +0200
Message-Id: <20190715093153.19821-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
I've spotted a regression on a fast SSD: a loss of I/O-latency control
with interactive tasks (such as the application start up I usually
test). Details in the commit.

I do hope that, after proper review, this commit makes it for 5.3.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: check also in-flight I/O in dispatch plugging

 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

--
2.20.1
