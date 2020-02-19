Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2601644F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgBSNEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 08:04:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47684 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:04:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01JD4R81119667;
        Wed, 19 Feb 2020 07:04:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582117467;
        bh=QYfk/0tLN4Oql6dXwlH5d6evBQcLGicLwy72d29I5bM=;
        h=From:To:CC:Subject:Date;
        b=rpuXHCGNdzmZFyvV91ah83UrwHMlI2xoau9rC8bKyOTb0aZerrOwq7D3lF3wh55gq
         4qUFQszANHZ6kPUSg1hh9Pp+zR5pXpE6u3U3n3KBLKCuAgZM4wncKzFYkYvFJeTRrp
         Wbl29MmHiNKSTte1OoKoYFK/uLe477Ytox06pFzY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01JD4Q39130488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 07:04:27 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 07:04:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 07:04:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01JD4QHi062569;
        Wed, 19 Feb 2020 07:04:26 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 0/2] Introduce the TLV320ADCx140 codec family
Date:   Wed, 19 Feb 2020 06:59:40 -0600
Message-ID: <20200219125942.22013-1-dmurphy@ti.com>
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
 sound/soc/codecs/tlv320adcx140.c              | 849 ++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h              | 130 +++
 5 files changed, 1073 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
 create mode 100644 sound/soc/codecs/tlv320adcx140.c
 create mode 100644 sound/soc/codecs/tlv320adcx140.h

-- 
2.25.0

