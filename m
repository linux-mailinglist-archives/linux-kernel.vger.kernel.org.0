Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00218B02D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 10:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCSJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 05:28:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46648 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgCSJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:28:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02J9S8AZ010903;
        Thu, 19 Mar 2020 04:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584610088;
        bh=UEwEnyl32F01p44oeA8YEloWkVx0Y9IDXcQfa9MD6go=;
        h=From:To:CC:Subject:Date;
        b=nr67BPBaGJ2/eZkEenADfUCnKG+CTOIRV4zwNLaF62EXzlyjfMrt1604bIERMdv2y
         8iJKR7e/NbWrLLQ6JQ8szGmOcxSy14cBVnNdEwJNl5l6jBCX1/K1cX44rsGhdv4lCW
         VPxgNdVv0OfygsGC5+9Vl/ijc3+kbq6JxEfbJ0TA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02J9S7EH051953
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 04:28:07 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 04:28:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 04:28:06 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02J9S4eo088372;
        Thu, 19 Mar 2020 04:28:05 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] ASoC: ti: Add support for audio on J721e EVM
Date:   Thu, 19 Mar 2020 11:28:12 +0200
Message-ID: <20200319092815.3776-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the analog audio setup on the j721e EVM.
The audio setup of the EVM is:
Common Processor Board (CPB): McASP10 <-> pcm3168a
Infotainment Expansion Board (IVI): McASP0 <-> 2x pcm3168a

Both CPB and IVI wired in parallel serializer setup.

The first patch adds the stream_name for McASP driver as it is needed in
multicodec (and would be needed in DPCM) setup for proper DAPM handling.

The second patch adds two DT schema, one for the cpb and one for the cpb+ivi
card.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: ti: davinci-mcasp: Specify stream_name for playback/capture
  bindings: sound: Add documentation for TI j721e EVM (CPB and IVI)
  ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)

 .../bindings/sound/ti,j721e-cpb-audio.yaml    |  93 ++
 .../sound/ti,j721e-cpb-ivi-audio.yaml         | 145 +++
 sound/soc/ti/Kconfig                          |   8 +
 sound/soc/ti/Makefile                         |   2 +
 sound/soc/ti/davinci-mcasp.c                  |   3 +
 sound/soc/ti/j721e-evm.c                      | 864 ++++++++++++++++++
 6 files changed, 1115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
 create mode 100644 sound/soc/ti/j721e-evm.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

