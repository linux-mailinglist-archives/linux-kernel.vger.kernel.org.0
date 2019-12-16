Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA49311F26D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 16:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLNP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 10:28:41 -0500
Received: from node.akkea.ca ([192.155.83.177]:55490 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLNP2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 10:28:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5497F4E2010;
        Sat, 14 Dec 2019 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576337320; bh=CQuzbnLyQX4H9C6yC05Ru5Dq0cwzzP9jEVfkCkLEAGs=;
        h=From:To:Cc:Subject:Date;
        b=HoCPY7y+KGhPP6pWIjSo2hyP4H9TrEhcBuwcX5MBIlX35gAic4s3eLqoOBbV5CAdS
         4mzpJVRTdmFe9TPPHA18AXwTUBytafVoIHV3a5PzGON/R2wpHcHlH8fj9Jm8VmfhfX
         NkyfPfsXQ6p7CJGwoNKUx+SoHMiX5z5NGpfZa4tg=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qhppl_TQ_Ec5; Sat, 14 Dec 2019 15:28:40 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id A71664E2003;
        Sat, 14 Dec 2019 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576337320; bh=CQuzbnLyQX4H9C6yC05Ru5Dq0cwzzP9jEVfkCkLEAGs=;
        h=From:To:Cc:Subject:Date;
        b=HoCPY7y+KGhPP6pWIjSo2hyP4H9TrEhcBuwcX5MBIlX35gAic4s3eLqoOBbV5CAdS
         4mzpJVRTdmFe9TPPHA18AXwTUBytafVoIHV3a5PzGON/R2wpHcHlH8fj9Jm8VmfhfX
         NkyfPfsXQ6p7CJGwoNKUx+SoHMiX5z5NGpfZa4tg=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     krzk@kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 0/2] Add MAX17055 fuel guage
Date:   Sat, 14 Dec 2019 07:27:53 -0800
Message-Id: <20191214152755.25138-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the max17042_battery driver to include the MAX17055.

Changes since v1:

Change blacklist driver checks to whitelists.

Angus Ainslie (Purism) (2):
  power: supply: max17042: add MAX17055 support
  device-tree: bindings: max17042_battery: add all of the compatible
    strings

 .../power/supply/max17042_battery.txt         |  6 ++-
 drivers/power/supply/max17042_battery.c       | 17 +++++--
 include/linux/power/max17042_battery.h        | 48 ++++++++++++++++++-
 3 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.17.1

