Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAB10DDED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 15:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK3O63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 09:58:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45519 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfK3O63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:58:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so12606735wrj.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clpGjkWQjLwNVa9dG7ghNAn26+3WI/efWDFoEsdhUXk=;
        b=T+B5MWx1NUXbV9Bve4Cj2BaBZFPdpWBp8JvKYzy2fgm8gNV68Yur4CdWocG7nFEqs7
         QKTxDu7k5uOJDRn39E2x5FnXAZ13tZzV1iydluFTjUumiMwAqiJ4mKTidxQvZskfzeqm
         TqvjIVTROHaLGz2zMHuJlX2bVCxXbh/x1dafdLACR3WRq7NpUioDlVows2SZwEcMFxyG
         JeiY2613NZzisJmhXVZIkUlVqX/SX1ikNEr/jNOvEl3VREvoWG13xMbeKISMGQe5MMyK
         yxTIC+rt0lsxCAmbujUVPwSQFwyI6CAQMqD8GbyaTEixD7h49O97+Z7uq5vUh/NxRYjW
         1rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clpGjkWQjLwNVa9dG7ghNAn26+3WI/efWDFoEsdhUXk=;
        b=Y5r/5UxVEg7AyV6/665LOociAGemLZQBE64f1T/JJ992CKIDgfyZRDeuhLEQvg4yZu
         OvOEDFa00xPJVXIsy7wYMnUiFgOBvPQrWfW4N6kQbRgZaFOFZswYEWWRwvvGN/nocH+8
         IsKHltEOkWW9te2Yk2C8vDS60UcmvdmNwo4o9YTItoBCgmdIzmlLwoEhllq9CubCaZZ1
         10oxqRG6pVhfYaKEqLkkNYEZooSqSAlDROyVyUOqdo0YGdSf/YbsGDrsRpMmzrNs90cT
         Gt8fUmnIUUYu3dbRITFyW5yuTiEt5C1lnmWgxK5ReGb8YoQtxW0rSwwDlENnngKvWHfZ
         nSuA==
X-Gm-Message-State: APjAAAU3w/UcDYVvT7phAXI78Wg0JaSy6yBOeqBTgOBQ2pm2YzEG+nRC
        dljt4dM+s1sUac7b1viTZAw=
X-Google-Smtp-Source: APXvYqxeq/6g/DE7fjLghbw4h3yd67AuhejpMU5WGS7hxkX9senxEe2MERpW1XPAo3YwA0fHLrozxQ==
X-Received: by 2002:adf:bc4f:: with SMTP id a15mr6836305wrh.160.1575125907164;
        Sat, 30 Nov 2019 06:58:27 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm3510202wmc.47.2019.11.30.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 06:58:26 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RESEND v1 0/2] amlogic: meson-ee-pwrc: two small fixes
Date:   Sat, 30 Nov 2019 15:58:19 +0100
Message-Id: <20191130145821.1490349-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on power domain support for the 32-bit SoCs I had some
crashes when trying to actually use the power domains. Turns out I had
a bug in my patches which add support for the older SoCs to
meson-ee-pwrc. However, I didn't notice these because the driver probed
just fine.

This is my attempt to spot "problems" (bugs in my code) earlier.

RESEND: sorry for the noise, I forgot to add the linux-amlogic mailing
list. This is important so patchwork can pick up these patches.


Martin Blumenstingl (2):
  soc: amlogic: meson-ee-pwrc: propagate PD provider registration errors
  soc: amlogic: meson-ee-pwrc: propagate errors from pm_genpd_init()

 drivers/soc/amlogic/meson-ee-pwrc.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.24.0

