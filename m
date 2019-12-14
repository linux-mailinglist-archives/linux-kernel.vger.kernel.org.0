Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3688011F51D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 00:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLNX4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 18:56:10 -0500
Received: from node.akkea.ca ([192.155.83.177]:38580 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLNX4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 18:56:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 16D874E2010;
        Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576367770; bh=OE2q7G5w+gUU1C7/rX6Xuismn9WjG5TfxVmkrDQuwXU=;
        h=From:To:Cc:Subject:Date;
        b=ul6+azKbYZ8Wbd5gr7pxrO0VWZV19FsVik25I7v8wU8F4u5hPpx5Nr27IQvHlfHOE
         Azl+0lN542/PtBaSq7T3xDlS8NLj7T65RFwwf7JloZeQMSis2OVUwQCE5ZqlpNmnOe
         tmPtihpMhadRGJauTlvZKxkHzQpD7SVXtANzjTWA=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GDDI7EDyHAcL; Sat, 14 Dec 2019 23:56:09 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 8FAF54E2003;
        Sat, 14 Dec 2019 23:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576367769; bh=OE2q7G5w+gUU1C7/rX6Xuismn9WjG5TfxVmkrDQuwXU=;
        h=From:To:Cc:Subject:Date;
        b=Xl17KUZs7x1M6c5rJr8TMopeaiUP3PdC4Rz/rX4Ih8pmCtdQXSgVW+53S1DTEQPE1
         yTGU2eoMAEJvgqBT1/0PSwyeTp0Vo6ky8FNhj2Fm6doIJyC3+LfkpJ3nQTIIJBbKPz
         u+0GJSjMHnuYOV9h/Al12/T4WUZlCgbs6OScuC/M=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 0/2] Add the broadmobi BM818
Date:   Sat, 14 Dec 2019 15:55:48 -0800
Message-Id: <20191214235550.31257-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

he broadmobi uses slightly different parameters from the option modems
so add the paramters and document them.

Changes since v1:

Cut back the CC list.
Use data from compatible match instead of explicit compatible match.

Angus Ainslie (Purism) (2):
  sound: codecs: gtm601: add Broadmobi bm818 sound profile
  dt-bindings: sound: gtm601: add the broadmobi interface

 .../devicetree/bindings/sound/gtm601.txt      | 10 +++-
 sound/soc/codecs/gtm601.c                     | 46 +++++++++++++++----
 2 files changed, 46 insertions(+), 10 deletions(-)

-- 
2.17.1

