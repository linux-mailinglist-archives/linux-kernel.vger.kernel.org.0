Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16B624CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfEUKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 06:36:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37120 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:36:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so28653904edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=uAylt3ofKrXJiUmVt/aJiMVs6WCW7IL4o+lOVbQ9k+k=;
        b=sfKCnXxnFTv4bvJWhLb37R6cjFqHwITjaBTbvnqnyPpJNL9pfzp8X6UGIy1LSxmcjT
         CNYxG3ZcUJJt3YwLCJ6ysnooEZz6moAD+oVv0/s8w1Gi2U4unQAjeuGm+CK+/W8nTK92
         H588oxGlVHSoB1nFdALJOpgZ261WP1GX4dvRHxSeAmrjo3kL6SvpsiH3E1kS84OKBPMX
         91+RDknoTPk+b3KZlRa8nG9DiyrTRss+8xuqMqH2VFW+42+jA08IyHeGmD8rJwRcImoA
         o1HFuvT+AEK40eaa2ZY/fR2vVtV3uH6Sa1LK1jARwRXyUIbRThTFMPKtUlUhv0ZXEiH5
         EE3w==
X-Gm-Message-State: APjAAAW4Rd1hx1NJoQ4SI3rY3S7HVTqrRCDKTurW6IdRq3USUVxamHgv
        CiwpXrubNRlmjw5FuiklNO+MHYN7VXLr5kr6T0RduxzYjzXigHGsXHaEsxAUX0QP1mobP+Xgx4Z
        iZrL7jrdMVihnr0k6
X-Google-Smtp-Source: APXvYqxwKTRDeQeHnXoeo2S5PjdpTBXMJbW529IdtNa7k6B9JmqbZcfYZOYpZVGnzIrOSfgpYYl4WA==
X-Received: by 2002:a17:906:5593:: with SMTP id y19mr35149813ejp.264.1558434989114;
        Tue, 21 May 2019 03:36:29 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id a40sm6205178edd.1.2019.05.21.03.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:28 -0700 (PDT)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 0/6] VAG power control improvement for sgtl5000 codec
Date:   Tue, 21 May 2019 13:36:13 +0300
Message-Id: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


VAG power control is improved to fit the manual. This fixes as
minimum one bug: if customer muxes Headphone to Line-In right after boot
w/o playing any sound, the VAG power remains off that leads to poor
sound quality from line-in.

I.e. after boot:
- Connect sound source to Line-In jack;
- Connect headphone to HP jack;
- Run following commands:
$ amixer set 'Headphone' 80%
$ amixer set 'Headphone Mux' LINE_IN

Also this series includes fixes of non-important bugs in sgtl5000 codec
driver.


Oleksandr Suvorov (6):
  ASoC: sgtl5000: Fix definition of VAG Ramp Control
  ASoC: sgtl5000: add ADC mute control
  ASoC: sgtl5000: Fix of unmute outputs on probe
  ASoC: sgtl5000: Fix charge pump source assignment
  ASoC: Define a set of DAPM pre/post-up events
  ASoC: sgtl5000: Improve VAG power and mute control

 include/sound/soc-dapm.h    |   2 +
 sound/soc/codecs/sgtl5000.c | 250 ++++++++++++++++++++++++++++++------
 sound/soc/codecs/sgtl5000.h |   2 +-
 3 files changed, 212 insertions(+), 42 deletions(-)

-- 
2.20.1


-- 

Ciklum refers to one or more of Ciklum Group Holdings LTD. and its 
subsidiaries and affiliates each of which is a legally separate entity. 
Ciklum LLC is a limited liability company registered in Ukraine under 
EDRPOU code 31902643, with its registered address at 12 Amosova St., 03680, 
Kyiv, Ukraine.



The contents of this e-mail (including any attachments) 
are confidential and may be legally privileged. If you are not the intended 
recipient of this e-mail, please notify the sender immediately and then 
delete it (including any attachments) from all your systems. Any 
unauthorised use, reproduction, distribution, disclosure and/or 
modification of this message and/or its contents are strictly prohibited. 
We cannot guarantee that this e-mail is secure or error-free. Ciklum cannot 
be held liable for any loss or damage caused by software viruses or 
resulting from any use of or reliance on this email by anyone, other than 
the intended addressee to the extent agreed in a contract for the matter to 
which this email relates (if any). Messages sent to and from Ciklum may be 
monitored; by replying to this e-mail you give your consent to such 
monitoring.  Notice: we do not accept service by e-mail of court 
proceedings, other processes or formal notices of any kind without specific 
prior written agreement. This email does not constitute a binding offer or 
acceptance for Ciklum unless so set forth in a separate document.


