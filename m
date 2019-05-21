Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5687258AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfEUUMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 16:12:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35160 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfEUUMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:12:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so28746pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=UKYH7WLV2ulLB4lxqEK1p6vKzcO/oYH0HKk0Uf1ngLMKlUIdsEZBeUP2RkJFviqTla
         /+Kpld/0OVy8Fuu4qrbvy5/us03iBvFcqM+dVkzCFWvmn1i4828WYorclEAU+0cKoB52
         qGBBHkjShpmLqeb/cdWbB2QEVLwISsfCNYX2LIybY7DgaXWrQ0lAqmRkpz8nqcAd/xcQ
         OjuH+kA3zAJwDCA79zLs2+71YrQzyveKWqS74wE5wEE4E+MrnQY4xFcQpWoRP1bbJdyB
         m9wKLfHxAUaCWwuXGeFGpkWoWgfmGxwC1oPGoROkVjiJk1u2GLFaFOWidJ4WiwFzUsGl
         CaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nSMrBlQQCNOdHw6ym1MsOYq9Zt6fXAndfJkhXIkeTfY=;
        b=W70OxybZXsaBqdz+gIdGg+ES+qcBHHNyUP+6s70M8L1x4iD3p3z8ZWWx6+Ql7Zqc5Z
         a7ytg0bzhDIv/N0sJOoEzKFCJ8/ydJb1s/a8Jpsmk5KyBERcO51SDEEULqDPmQIkGFc8
         J8Xpk2OoGPMOgfdoX4vbCefNxSLzwbuTnaGz/LdnZtboCSbhTLqzoNAjDZK0jwKFCLBx
         5zY+NOzCBKW/YR5W+UdYSKsw/UNm5Luvi8KCiwrNNeXbMJcEWXydAxhFOC2KKv5F9cSR
         KqJn8jBsaqonKF1lv/oUTzxtO9tl5+G86YI/lRUbd051U4Lpy2aszwC0jaZAPJu2aCYm
         wOBw==
X-Gm-Message-State: APjAAAXz/SZuk8Wd+LDAR+KTozARhh+kBCyk8C/cs1zgA5hkdn0ubsxs
        UAwZHC9VbsYuDosCumt79xbnag==
X-Google-Smtp-Source: APXvYqxVEPOLzIUAcEnvDwqtTQaoCBe/SQRAw+I1ByMAhdJAZkI38UAVWTgq+qFcuMrL99a0Mwl45A==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr92113713pfb.2.1558469558426;
        Tue, 21 May 2019 13:12:38 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b1ca:3800:3284:d770])
        by smtp.googlemail.com with ESMTPSA id r138sm29927872pfr.2.2019.05.21.13.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:12:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] mmc: meson-gx-mmc: update with SPDX Licence identifier
In-Reply-To: <20190520143647.2503-2-narmstrong@baylibre.com>
References: <20190520143647.2503-1-narmstrong@baylibre.com> <20190520143647.2503-2-narmstrong@baylibre.com>
Date:   Tue, 21 May 2019 13:12:37 -0700
Message-ID: <7h5zq37eiy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
