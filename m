Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6957C145753
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAVOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 09:00:19 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35971 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgAVOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:00:19 -0500
Received: by mail-wm1-f47.google.com with SMTP id p17so7322294wma.1;
        Wed, 22 Jan 2020 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iBKN5xxgug5/repGQ+9bClwhlzV1AiyNQfOYQd+MEZo=;
        b=teeba+JlTst30oUCLQ1KE6aYz73mr2kkSnjMWszt2Zr7jZHQ+h4WJntcjpVzf4b6D5
         LPVwNiT3Oi6O7vbQZrPnHvplZ2d+0yhuXwpEvXKlS4+IoZTR4Y+SxZNqsf68e00ft0Im
         5jg0IBKu5BqFqrIeqPgIF7Z3sh01eoMfoa7LedxjeVsVk8DsDtLQI0VfpVMX5fU1TI/g
         qoPlhfc8HVqdbg2sJuejb3VCZQKbE6meRtoglSOYYpKqSiIL3xY3+pS23h/Vhz0KzXGh
         aFAyu0nw7vnGjWNR+XVqAQ+fnTdCC2N++NalqK1HRuaqJ+L1pjh3HK0IFZ9sSqbnGZ76
         a8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iBKN5xxgug5/repGQ+9bClwhlzV1AiyNQfOYQd+MEZo=;
        b=SoF7HdaYHjTrDVEIf8bniJRi9in9iNQ8UrNaXxl2bv17eO1e2eva08DgkbAfrvMiUL
         MR9ELAv/fmQY3tYxXt4XlXAGAK/S3N+gRD04j64uVwDeO3js/3WCStizYs3gerYTOBt9
         /dMoGVT8s+27rrEXw7+sXNYkx44yDdPuwLb2Pujm/FpqIcE1IL4sQdoKD+7zXlT9d3TI
         cVZsLTLKlSqLZyaDldNe0PqeqjtAqltf98vJ3EALcrVbB3kWb31xlglOG1H3YMGpqd+J
         nll+x4TUONf63fYJ60zqltlzYN93Gt7xsGSUdHLsiPaKy+f6j67El0Bpd9n3k4W5DzNM
         DnjQ==
X-Gm-Message-State: APjAAAX0htdwBcLaoW0vC+nvo0U/RpgbZkbfHpw8WvwE+dsydGlD19wR
        6/pmTWL804i48wJtntuxAaE=
X-Google-Smtp-Source: APXvYqweMYvytj5KrqqsLp46MJFTRCcH5Z4sGFJ3KPYCx6P8covo2ndpb3Zri8xYzj31ZWXM22QiCg==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3330320wmj.25.1579701617120;
        Wed, 22 Jan 2020 06:00:17 -0800 (PST)
Received: from localhost.localdomain (p5DCFF1C1.dip0.t-ipconnect.de. [93.207.241.193])
        by smtp.gmail.com with ESMTPSA id g2sm57388270wrw.76.2020.01.22.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:00:15 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add regulator support for mpq5416
Date:   Wed, 22 Jan 2020 14:59:55 +0100
Message-Id: <20200122135958.13663-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for PMIC regulator driver for Monolithic
Power System's MP5416 chipset. MP5416 provides support for 4-BUCK converter,
4-LDO regualtor, accessed over I2C.

Thanks,
Saravanan

Saravanan Sekar (3):
  dt-bindings: regulator: add document bindings for mp5416
  regulator: mp5416: add mp5416 regulator driver
  MAINTAINERS: Add entry for mp5416 PMIC driver

 .../bindings/regulator/mps,mp5416.yaml        |  64 +++++
 MAINTAINERS                                   |   2 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mp5416.c                    | 245 ++++++++++++++++++
 5 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
 create mode 100644 drivers/regulator/mp5416.c

-- 
2.17.1

