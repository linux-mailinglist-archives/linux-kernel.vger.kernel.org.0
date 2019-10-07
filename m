Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0FCEDA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 22:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfJGUiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 16:38:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:12758 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:38:13 -0400
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXt87vtBtcfg=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id L0811cv97KZ645Q
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Oct 2019 22:35:06 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>,
        Simon Shields <simon@lineageos.org>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] Add support for Melfas MMS345L touchscreen
Date:   Mon,  7 Oct 2019 22:33:40 +0200
Message-Id: <20191007203343.101466-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Melfas MMS345L touchscreen
to the mms114 driver.

MMS345L is used in the Samsung Galaxy A5 (2015) that has recently
gained mainline support [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1329c1ab0730b521e6cd3051c56a2ff3d55f21e6

Stephan Gerhold (3):
  Input: mms114 - use device_get_match_data
  dt-bindings: mms114: document melfas,mms345l binding
  Input: mms114 - add support for mms345l

 .../bindings/input/touchscreen/mms114.txt     |  3 +-
 drivers/input/touchscreen/mms114.c            | 44 +++++++++++++------
 2 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.23.0

