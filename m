Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7227113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfEVUvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 16:51:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:49340 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfEVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:58 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 47B461321;
        Wed, 22 May 2019 20:50:58 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 5/8] docs: fix multiple doc build warnings in enumeration.rst
Date:   Wed, 22 May 2019 14:50:31 -0600
Message-Id: <20190522205034.25724-6-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion of acpi/enumeration.txt to RST included one markup error,
leading to many warnings like:

  .../firmware-guide/acpi/enumeration.rst:430: WARNING: Unexpected indentation.

Add the missing colon and create some peace.

Fixes: c24bc66e8157 ("Documentation: ACPI: move enumeration.txt to firmware-guide/acpi and convert to reST")
Cc: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 6b32b7be8c85..850be9696931 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -423,7 +423,7 @@ will be enumerated to depends on the device ID returned by _HID.
 
 For example, the following ACPI sample might be used to enumerate an lm75-type
 I2C temperature sensor and match it to the driver using the Device Tree
-namespace link:
+namespace link::
 
 	Device (TMP0)
 	{
-- 
2.21.0

