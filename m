Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7661505C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgBCMCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 07:02:03 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:51352 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBCMCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:02:02 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580731317;
        bh=SqxYLCmdR4Abw8l8bjcJ27sDp3wH9PE1sOB/bNJIyHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpOWY9pbayjtU3P//dUddgW7R+q2LWsyNeGUcJHQGdyYqANEe9202+TD2SxkZ97A8
         55twlHQtoyWNaSF3tGegOC1ks20nZjU9T11cl4WTzalArIEFK7CZngBj3VBv992pxm
         cKrpoBGrjqRMxAoP/gr3rwFlYMHloJXBgNfQugYc=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/2] platform/x86: thinkpad_acpi: use standard charge control attribute names
Date:   Mon,  3 Feb 2020 13:01:30 +0100
Message-Id: <20200203120132.102576-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131143650.4149-1-linux@weissschuh.net>
References: <20200131143650.4149-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series switches the battery control sysfs attributes to their
standard names as documented in Documentation/ABI/testing/sysfs-class-power.

If backwards compatability is not required please drop patch 3 of this series.
The old names were not documented explicitly and new generic software should
automatically use the new attributes, which may allow to drop the old names.

Changes since v2:
* Preserved API backwards compat after each patch by merging the patches that
  switch over to the new API and reintroduce the compat aliases.

Thomas Weißschuh (2):
  platform/x86: thinkpad_acpi: remove unused defines
  platform/x86: thinkpad_acpi: use standard charge control attribute
    names

 drivers/platform/x86/thinkpad_acpi.c | 29 +++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.0

