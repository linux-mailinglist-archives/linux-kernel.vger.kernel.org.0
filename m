Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3F9B060
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 15:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394936AbfHWNJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 09:09:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40531 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHWNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:09:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id c5so8869000wmb.5;
        Fri, 23 Aug 2019 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LWXkxTKcRZuK292VQyIRV7T1k9jBHkOyzAtwhFmEx4c=;
        b=OI/DuJjkgMGlZXQBPkxHh7TQ1GzMlu1cMrka1NBxb23WtIcK4HizOFzrxuBp5U3D6M
         nfqr4jWlguNXsb8Dx3J7bdrl4fHVXfg2BZl4UR15+FgjLMdyZ8Tm7LxPIHAUMdA/nE/u
         j2FsayR5GXtTklBPxc9aokyalNPzRP5H2nxtXRKrB7Zg3k++0RCcn9A5oYV0TUo/XXT6
         4W5bKkVVYW4CdK7WxFRhEuWsBom+5vDcbCQVmJ/iMp7Jm/0WkAUTcNOCEp6Fqh1vXOEX
         F1QSySyl7FYgsQYzygsu1x2Et5dJFWNhtbWVWJb2YNgz+aeCoZ93p/iMlhQCGqN6yjI3
         uajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LWXkxTKcRZuK292VQyIRV7T1k9jBHkOyzAtwhFmEx4c=;
        b=fUONuwfDUdqatxMaLjR7xe/mQdBFCY3JxAyIvzzqstUvwJO6l7KreXU59XpfVfJ80M
         4oKfhEm9j58jZzQ9Mrb7MGkzz2yiC1wwVHGDKAvCSBIdMWmtcp/kiHcmNQI3H03TsDlm
         YJX4HzLOiwJwkY2zlNB1/yuGsT57S7MYY/kY2zQqMSyxo8QgRxFSpTYqhn2QE7hNLvv2
         rVanB3HgL5EaRyGknf69kOz5XdzzAXQCrch/DDoBQngj4GaIMBBW5Xr85IaqzEb2564h
         e6+5lS9LpHsRp1dkzk5hMYQYAq630+7nQ1qYY1G464PrLAFl7EHrQQfiuYq6klowABy1
         n/cw==
X-Gm-Message-State: APjAAAVH7Cd+nL7bn/55gNSHcRqnhS+5lp4SuQL7EzhTjzcAU9EpRAyR
        B6EujZ9jjxXW/NHGv7T4Pvg=
X-Google-Smtp-Source: APXvYqwhKpHj0Q8fey8hFsDLLv62Ne9/S5zXf2J1J0WNDTeBqAJTNILW9Bi8PNbYj4YgXgkxnlrKDg==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr5151617wmb.41.1566565768392;
        Fri, 23 Aug 2019 06:09:28 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id m7sm4359854wmi.18.2019.08.23.06.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Aug 2019 06:09:27 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>,
        Oleg Ivanov <balbes-150@yandex.ru>
Subject: [PATCH 0/3] arm64: meson-g12b: Add support for the Ugoos AM6
Date:   Fri, 23 Aug 2019 17:08:34 +0400
Message-Id: <1566565717-5182-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Ugoos AM6, an Android STB based on
the Amlogic W400 reference design with the S922X chipset.

Christian Hewitt (1):
  dt-bindings: arm: amlogic: Add support for the Ugoos AM6

chewitt (2):
  dt-bindings: Add vendor prefix for Ugoos
  arm64: dts: meson-g12b-ugoos-am6: add initial device-tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      | 567 +++++++++++++++++++++
 4 files changed, 571 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts

-- 
2.7.4

