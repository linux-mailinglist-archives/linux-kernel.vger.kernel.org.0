Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4F7A7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfG3MKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 08:10:08 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44311 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfG3MKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:10:08 -0400
Received: from [167.98.27.226] (helo=ct-lt-1124.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hsQwp-0003E4-GQ; Tue, 30 Jul 2019 13:09:43 +0100
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Thomas Preston <thomas.preston@codethink.co.uk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ASoC: Codecs: Add TDA7802 codec
Date:   Tue, 30 Jul 2019 13:09:34 +0100
Message-Id: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch series adds a driver for the ST TDA7802 amplifier.

Thank you Mark Brown, Charles Keepax, Cezary Rojewski and Kirill
Marinushkin for your time and useful feedback (on IRC too). Sorry for
taking so long in getting back to you, there were quite a lot of
changes!

Please let me know if there's anything else which needs changing.

Many thanks,
Thomas

Thomas Preston (3):
  dt-bindings: ASoC: Add TDA7802 amplifier
  ASoC: Add codec driver for ST TDA7802
  ASoC: TDA7802: Add turn-on diagnostic routine

 .../devicetree/bindings/sound/tda7802.txt     |  26 +
 sound/soc/codecs/Kconfig                      |   6 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/tda7802.c                    | 693 ++++++++++++++++++
 4 files changed, 727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
 create mode 100644 sound/soc/codecs/tda7802.c

-- 
2.21.0

