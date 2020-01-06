Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD6131A24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAFVRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 16:17:01 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:46734 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgAFVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:17:01 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ioZk6-0001Pq-NQ; Mon, 06 Jan 2020 22:16:54 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from roc-pc (pD9E89450.dip0.t-ipconnect.de [217.232.148.80])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 006LGrhM032119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Jan 2020 22:16:53 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] regulator: mp8859: add driver for DC/DC converter used on rk3399-roc-pc board
Date:   Mon,  6 Jan 2020 22:16:23 +0100
Message-Id: <20200106211633.2882-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1578345420;0ad3f49f;
X-HE-SMSGID: 1ioZk6-0001Pq-NQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On rk3399-roc-pc board a voltage regulator MP8859 from Monolithic Power Systems
is used to supply the 12V power line. This delivers 5V as a default value after
boot. The voltage is controllable via I2C.
Add a basic driver to set and get the voltage of the MP8859 and add a matching
node with fixed 12V in the DT of the board. 

Markus Reichl (5):
  regulator: mp8859: add driver
  regulator: mp8859: add config option and build entry
  dt-bindings: add vendor Monolithic Power Systems
  dt-bindings: regulator: add MPS mp8859 voltage regulator
  arm64: dts: rockchip: Enable mp8859 regulator on rk3399-roc-pc

 .../devicetree/bindings/regulator/mp8859.txt  |  22 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  32 ++--
 drivers/regulator/Kconfig                     |  11 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mp8859.c                    | 156 ++++++++++++++++++
 6 files changed, 210 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mp8859.txt
 create mode 100644 drivers/regulator/mp8859.c

-- 
2.24.1

