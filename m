Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2959D570
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfHZSHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 14:07:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46112 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbfHZSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:07:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id n19so12970563lfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZhbVTTAhELTpK9khEQbzX5xO6vbVG1SPvOTB99Q+OI=;
        b=jcuZpF/kXVwnEwcdZZ+XnmGDbebmISf1OOdd8xcPrfviFFqjWIK1rsoOScOKksNso9
         bCXRagueJdLy0jSCwO0nqUk8F7/peUhgAaYhfvpOSYer0aXKD6poVhN5EaCWQXLVZNAB
         0L9XZsl31CtoRjoRvw257ge9D2O1b6Tslqp52qCLFSMXLKVK1a4BUyJiMRkZMh6HG/3X
         rinB0UOC6BJtIFqfZgUwgmR0nYGmFA6dbIn2f91U4DIde+H3vl/FP84JxWJbhY6lHJAx
         PA6y6uEXfM0XVjT3CUxLuTNQSxEul3GCMMItjBvyw15MpABL2keyRdErEmj9TsLtqvn5
         Xa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZhbVTTAhELTpK9khEQbzX5xO6vbVG1SPvOTB99Q+OI=;
        b=ZdHcdFNE4sCmDxfhyfX8JHMg/L9rydYvI7SApYOXU5bTs2Yr+7k5LK7vtzA4WDMp6y
         frTp550LBRTD97ZirxPrxH4IBp9qNGZ59IyI2K611taEeWQmj972jrA/aWw6ZM0RAxDL
         ASe/9RzFokOD0C5NdY9h3erf0rQRBpxFgcSPBRtPWCoEmduxWBCpkHXaKCy8+noe3Li+
         yJBK4oZ7YWe9p8ehgIZxcyAG76ajrddkh6EptcEmsHSRSdddKjY+FsbET3h6rLqq4WNE
         Yj+lzBFaGkgqLF0do2KqZmFNhcc4sRT9vj5M6wn37l1NggffvY6wZPjTYrC71/86RSOl
         mtpQ==
X-Gm-Message-State: APjAAAWrqhLA0Io8utYCe60LAt4XaQFjgMG9vmUK8XJQHFxLyHYAQbQK
        j9s2tsCoIB/37tLgdzK0R+A=
X-Google-Smtp-Source: APXvYqwlKQ3vF5aBWkClkQ0SKJJhrLTfbv5xkLecYvruosChOjV23gpdsyMuOCHHHcpFh/3pKBCfEw==
X-Received: by 2002:a19:f007:: with SMTP id p7mr11474484lfc.24.1566842857231;
        Mon, 26 Aug 2019 11:07:37 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id u3sm2215564lfm.16.2019.08.26.11.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 11:07:36 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 0/3] ASoC: sun4i-i2s: Updates to the driver
Date:   Mon, 26 Aug 2019 20:07:31 +0200
Message-Id: <20190826180734.15801-1-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
which is enough to get HDMI audio working on the A83T, A64, H3 and
H5 platforms.

I've dropped a lot of the functionality that was presented earlier in favour
of getting initial HDMI audio delivered. H6 and multi-channel HDMI will
follow shortly.

My test branch for this can be found at
https://github.com/codekipper/linux-sunxi/commits/upstream-i2s , I've been
using a Pine64 to test with; validating the new SoC block with HDMI audio
and ensuring that I've not broken the old block by making sure that the audio
codec still works.

BR,
CK

---
v6 changes compared to v5 are:
- removed patches for multi-channel and H6 HDMI audio.
- removed patch for 20, 24 and 32 bit (will push support for just 20 and 24bit)
- ditched tdm patches as support has already been added.
- added fix for A83T reg map.

v5 changes compared to v4 are:
- removed delivered patches.
- Added more details to commit messages.
- replaced some reg fields with function calls.
- Added DSP_A and DSP_B support for H3 and later SoCs.
- Added support for the Allwinner H6.

v4 changes compared to v3 are:
- Moved patches around so that the more controversial of patches are
  at the top of the stack.
- Added more details to commit messages.
- Fixed 20bit audio PCM format to use 4 bytes.
- Reduced number of flags used to indicate a new SoC.

v3 changes compared to v2 are:
 - added back slave mode changes
 - added back the use of tdm properties
 - changes to regmap and caching
 - removed loopback functionality
 - fixes to the channel offset mask

v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---

Marcus Cooper (3):
  ASoC: sun4i-i2s: incorrect regmap for A83T
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoC: sun4i-i2s: Adjust LRCLK width

 sound/soc/sunxi/sun4i-i2s.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

-- 
2.23.0

