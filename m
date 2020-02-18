Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572F0162CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 18:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBRR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 12:27:29 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55942 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgBRR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:27:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01IHQPBe095293;
        Tue, 18 Feb 2020 11:26:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582046785;
        bh=lvwXkYs8d80yE7BNnJ2oI2ay727RRz52IoOVRAsarhw=;
        h=From:To:CC:Subject:Date;
        b=ghLMVHiVkMzpMdZkJWxB53JeSi9Fc+l1fm0o7lZvV5SR/P8H5raaglOKnXChVJ4w4
         0julWR7da7m/RXgKrfTuNokFmjOtg05SJz9gjWklDNehR1uo8U0pG8+kfjH0gPbq3L
         ac+doOHhpFIXjdty+i5hDqPXm/kiIOq06tFkS+aI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IHQPPk065185;
        Tue, 18 Feb 2020 11:26:25 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 11:26:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 11:26:25 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01IHQO72068505;
        Tue, 18 Feb 2020 11:26:25 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 0/2] INtroduce the TLV320ADCx140 codec family
Date:   Tue, 18 Feb 2020 11:21:38 -0600
Message-ID: <20200218172140.23740-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Introducing the Texas Instruments TLV320ADCx140 quad channel audio ADC.
This device supports 4 analog inputs, 8 digital inputs or a combination of
analog and digital microphones.

TLV320ADC3140 - http://www.ti.com/lit/gpn/tlv320adc3140
TLV320ADC5140 - http://www.ti.com/lit/gpn/tlv320adc5140
TLV320ADC6140 - http://www.ti.com/lit/gpn/tlv320adc6140

Dan Murphy (2):
  dt-bindings: sound: Add TLV320ADCx140 dt bindings
  ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family

 .../bindings/sound/tlv320adcx140.yaml         |  83 ++
 sound/soc/codecs/Kconfig                      |   9 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/tlv320adcx140.c              | 851 ++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h              | 130 +++
 5 files changed, 1075 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
 create mode 100644 sound/soc/codecs/tlv320adcx140.c
 create mode 100644 sound/soc/codecs/tlv320adcx140.h

-- 
2.25.0

