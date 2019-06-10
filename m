Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850493BD4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 22:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbfFJUFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 16:05:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46689 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbfFJUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:05:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so4846611ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SF78ZtQnVw4meJ8EJONYZwlPUHgQPUvTSa99AqdBgU=;
        b=rcWrdec/E9sDrmrCQDZ06tIyqcs5/k1EUESVSY+S1Cg6GQn6h9qy+BDmoYs1wsVg9I
         g42UkqXkrAlUMW6nP1Rz/XFK/wQj/GaU8nTQfeHt4ng8NonfnxijFoYq3PQ93p3CXGcT
         G32Heb8dJxd1L3dQzfANtPaMJmYEYuUiw29MRS/QWD8Os0kG/QpqN8bC62USIMOgwh0i
         AhIRRPuXpLl5MCITpL8Mjn/OT+EqwnS2zIAKR/9xz0bLbPAY7h1dqyubaOd5ORjJ8PqZ
         +TVZxzuabviG985UYi73kxFgNhhuBo81kUv4NC29vZLRUmtg5F6N/k7NuHKE5b2KpFRA
         1biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SF78ZtQnVw4meJ8EJONYZwlPUHgQPUvTSa99AqdBgU=;
        b=C7h6l4bClLXQDPuaOVDjYVEXCCRjJLcxjrtoefRHMDLGYvOMGHbLS8hwUctDe/zREx
         lF4gHYyHcYfCW7G7Sz55Yp3BJKsfn4v/oWXGxfSmGLAjCeetjt1nEPR5HXK9UCOw1dKU
         1gLBmY5U1GAFtkRRHk7tImOmhF7HPIf4IXkC5hhpH9o/UNoJT78d9VKzR3cQPg8hn1ki
         MvBW8YpdHrwtC1J22ultax0HZWjHviALflL8QV799yeDg8Cq52DCKDSwAMabG3qAS1sH
         5gD45ll+F5u8ioxqX+dJpQD+QDdrEYYA9rrmmD0aW+1sS2Fez/x9mlgq5bD/nhGClxjT
         5cIw==
X-Gm-Message-State: APjAAAVPKMitqQQVZzl8k+KCMST4hJrjmZ3kHHjWmqU5qaO9ZlaJAdJV
        sLPPIkdkBdyb5eyeKaLQzbp4ZA==
X-Google-Smtp-Source: APXvYqxJkhuh6OlUK5H+u52AQvvvP//n3NzjSE12meA4CT/a1rcVee2qlkuqgalMfr2jAg57HDvkBQ==
X-Received: by 2002:a2e:86c1:: with SMTP id n1mr14005941ljj.162.1560197150994;
        Mon, 10 Jun 2019 13:05:50 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id f4sm2157079ljm.13.2019.06.10.13.05.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 13:05:50 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 0/2] staging: kpc2000: minor fixes in kp2000_pcie_probe
Date:   Mon, 10 Jun 2019 22:05:33 +0200
Message-Id: <20190610200535.31820-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fixes issues pointed out by Dan in a previous
staging/kpc2000 patch thread: many comments in kp2000_pcie_probe just
repeats the code and the current label names doesn't add any information
and makes it hard to follow the code.

Rename all labels and remove the comments that just repeats the code.

Simon Sandström (2):
  staging: kpc2000: improve label names in kp2000_pcie_probe
  staging: kpc2000: remove unnecessary comments in kp2000_pcie_probe

 drivers/staging/kpc2000/kpc2000/core.c | 80 ++++++++------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

-- 
2.20.1

