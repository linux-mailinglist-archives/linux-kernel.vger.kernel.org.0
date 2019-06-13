Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4AE43B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfFMP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:26:58 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39308 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfFMLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:42:41 -0400
Received: by mail-wr1-f50.google.com with SMTP id x4so17758629wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0ZsHoiBuMTfOtADEzvR2C+3smzJtpOELu9NU33cfes=;
        b=JX7JAnlpC/5ro2x6Z+UAAbgxEG6zPqcxepO1yDEMKgXmun2iUYPZZfOtSXWXCup0J2
         zQ5Xe7sW3kEQ+83pe2ATBIcTRs1j6rTohOJedQT7LPzqQVJqqWw4cqOIqPrUC+oAYMRk
         lRLwy91wlqN1FX84m0R+znr/UC86Lr5yuqkcyi3aApJz65ybTrTPXb09MIBe+bXscuAB
         +i1cKAAKpK0cdVBUcEeMUL7sAZ0AusGK2aTVK03bSsf1eKp3xeWyvOtSra0UCKR+22Uf
         Cg/Trn/YM21oupZfSfYVEdr7taJjnDZ1a1IJQ+bQ0wAaKtLMgSdqPzI8AVk+MWDmcIsV
         t6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0ZsHoiBuMTfOtADEzvR2C+3smzJtpOELu9NU33cfes=;
        b=AZwRhBx4+WTKtVo8W0n9TL/xYTOwwxjeFiimziAjNkdUcaSsm+CZwJMA8iIpX9gUDK
         CagtVWtlva3dg4++q/OmvHMfgSnvWdyMFr174IWq0K4wau/Qe8uCMxmeGoyR7Untjoki
         MU8xJePlKI6EDH2jNyNUpWXmcTDC+pHwxARLoKAkN9fDAqXcCCDdhIhYQKDsdNwdVarA
         7K9v3EE7B1799A4W3UpVXnMw+RO+MaYzcu20kzu/M+ouhRy7raDs6QsoWNR+KEGf/OXr
         LFW5sZdTekl7Xm5RyPloi3IWsNbToRqOuPy5jYcNBZLxvVAwb4DlvNDxxwFO10hCjXlS
         aqMA==
X-Gm-Message-State: APjAAAWQFM0QiudJymrngM208wKjBwg81t3s+F7k2OGLeGJSR1+3NE9X
        eh9rQMz605XyFsX0fEWp0ohIkA==
X-Google-Smtp-Source: APXvYqxsB0lJVQCFeg50GG0zAhStyAzrsN1OVM00ronb52Gz/5ZCc1kOTBrm5qHA0vi5//v9WpyGEg==
X-Received: by 2002:a5d:624c:: with SMTP id m12mr41557303wrv.354.1560426159084;
        Thu, 13 Jun 2019 04:42:39 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b5sm2598490wru.69.2019.06.13.04.42.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:42:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/4] ASoC: meson: axg-tdm: i2s format fixups
Date:   Thu, 13 Jun 2019 13:42:29 +0200
Message-Id: <20190613114233.21130-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset fixes a few mistakes regarding the format on the i2s bus
on the Amlogic axg tdm drivers.

Jerome Brunet (4):
  ASoC: meson: axg-tdmin: right_j is not supported
  ASoC: meson: axg-tdmout: right_j is not supported
  ASoC: meson: axg-tdm: fix sample clock inversion
  ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines

 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 sound/soc/meson/axg-tdm.h           | 2 +-
 sound/soc/meson/axg-tdmin.c         | 1 -
 sound/soc/meson/axg-tdmout.c        | 1 -
 4 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.20.1

