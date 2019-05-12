Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6757F1ADF0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 21:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfELTjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 15:39:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55277 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfELTjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:39:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so5993999wml.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 12:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWbggL32nqaK0NhKqHWoQpLdIs4e+dGRoCZHYZPIbWw=;
        b=CheLRUTYkUJD4uIKFEVuBkQjHtO3lBcS1AaeqBXHUqPuP88Gt1W9V1I4fJ4UP8n7gL
         dhIhygTfgfOBGRKiXKmLNjuhj7IO3mtvdbdzVXlOcLDuY2tYROT+vf34MXRmr0x8RefA
         Vct4viSmUF32eqzZ9PIGSxVwktWjG0lbkiPvneict9qKjvZi80XhZomXetpTw6ien/gz
         8qurMauy0UBKJJwsPJozT9X2JbXzFSj1K9Eyieuvrcz7l1QYJznEwlQPRUhZgCnKgZOl
         5JkIzkbgrd06Xsq5VYLlo1vmpciJvKxE7oZYesxBeY4PZ3rSsuQrXdXC4uuoqmP5vJL9
         xRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWbggL32nqaK0NhKqHWoQpLdIs4e+dGRoCZHYZPIbWw=;
        b=gHWxWFG6Lme7bYuu5nCY/neBrn2hkSb6U+2wt/s0wufS217eBDipUondMLEsjh03Dt
         i+inPLOs2h27x7KfzUJTSrgJ+1BLuA30VUkxuA16GabsQLCYp+/kPorWz5h7T2N+E8SL
         fTbXerNL9qFTEdLCg67pGTEohgI1g1i+7pmEO6BHQNcIej0deM1ROUbJXjUcK66jXqCN
         7Z6fmvraNQEQxCs9HVXakHmRzA85dbF3IfI7zPfS7eE+uss3sL7JYNpWjn4zzS/HFLF5
         VO9QxAO2zHfRf4alIYP9mjiDiR6vEnJ4RTz3Sgx657+A4945dTFAvpyWu24JsNrdYeHT
         vRiQ==
X-Gm-Message-State: APjAAAXOMlCSMe9Rpn8T1C5bk88VLqtWw1xQoLeec5w1uCrsc5NrSJoO
        FRLmd9GE1TDY3qsNiIEZFTw=
X-Google-Smtp-Source: APXvYqz1LfFTR+NI4oCDqTgGEFI0sGQW7NFKgq6Z4FgeSFXoVrKlwUANkBWfszsTPJM7zqaFz9yRag==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr14085532wmh.32.1557689981825;
        Sun, 12 May 2019 12:39:41 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00ECBE9107EA8EB108.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:ecbe:9107:ea8e:b108])
        by smtp.googlemail.com with ESMTPSA id c9sm8127719wrv.62.2019.05.12.12.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:39:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] ARM: dts: meson8b: another GPU fix
Date:   Sun, 12 May 2019 21:39:35 +0200
Message-Id: <20190512193936.26557-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently I am working on the PWM driver to complete .get_state()
support. This allowed me to read the VDDEE voltage set by u-boot
on my Meson8b boards (EC-100 and Odroid-C1). VDDEE supplies the
Mali GPU.

It turns out that the bootloader configures a VDDEE voltage of 1.10V
instead of 1.15V. 1.15V is actually out-of-range for that regulator
design.

This is meant to be applied on top of my other GPU fixes from [0]
also targetting v5.2 if possible.


[0] https://patchwork.kernel.org/cover/10910101/


Martin Blumenstingl (1):
  ARM: dts: meson8b: fix the operating voltage of the Mali GPU

 arch/arm/boot/dts/meson8b.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.21.0

