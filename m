Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7ECC9A5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfJELgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 07:36:40 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54736 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfJELgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 07:36:40 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 8D270200712;
        Sat,  5 Oct 2019 11:36:38 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id BA6152090F; Sat,  5 Oct 2019 13:36:32 +0200 (CEST)
Date:   Sat, 5 Oct 2019 13:36:32 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] random: inform about bootloader-provided randomness
Message-ID: <20191005113632.GA74715@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inform how many bits of randomness were provided by the bootloader,
and whether we trust that input.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Will Deacon <will@kernel.org>

diff --git a/drivers/char/random.c b/drivers/char/random.c
index de434feb873a..673375e05c0d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2515,6 +2515,10 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
  */
 void add_bootloader_randomness(const void *buf, unsigned int size)
 {
+	pr_notice("random: adding %u bits of %sbootloader-provided randomness",
+		size * 8,
+		IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER) ? "trusted " : "");
+
 	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
 		add_hwgenerator_randomness(buf, size, size * 8);
 	else
