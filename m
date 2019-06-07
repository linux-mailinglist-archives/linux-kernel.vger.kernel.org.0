Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECD38A82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfFGMmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 08:42:50 -0400
Received: from olimex.com ([184.105.72.32]:44742 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfFGMmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:42:49 -0400
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 7 Jun 2019 05:42:48 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v3 0/2] mfd: rk808: Fix pointers and poweroff
Date:   Fri,  7 Jun 2019 15:42:24 +0300
Message-Id: <20190607124226.17694-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is actually follow-up to:
  [PATCH 1/1] mfd: rk808: Prepare rk8085 for poweroff

The patchset fixes poweroff function for boards with RK8085 PMU.
During the preparation of v2 possible wrong pointer access was
spot (pm_power_off), so one more patch was introduced in the series.

Stefan Mavrodiev (2):
  mfd: rk808: Check pm_power_off pointer
  mfd: rk808: Prepare rk805 for poweroff

 drivers/mfd/rk808.c       | 67 +++++++++++++++++++++++++++------------
 include/linux/mfd/rk808.h |  2 ++
 2 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.17.1
