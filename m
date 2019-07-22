Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC26FB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfGVIwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 04:52:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfGVIwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:52:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8q6V73748923
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:52:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8q6V73748923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563785526;
        bh=GNjQxzTPFOrev1+HUrSm86YVIVKBA1iCM6sgkS8a170=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QNaHBbC69lfOrUm/ibr446TXxo3bQXRFhJzuIvhONc4iAMJ118VPDW6S3rSvJeBbJ
         I8YpOeD9bAd2LxLbq/LvwxMWZXA2f6SuUnraP6UbS0okWXl5CsTr9eFIJrl9rb5Kpz
         t4dvERWA7N5bAI+kfNVZ2Q7x/68397VRPjOLS4+oDgRa2N+9ohKO2Sj5X++Svkfvqr
         SQ1ApmfLA4geZE18Y6Mxe0GcN3PcE2tzth5gHf+ne7UfDe8VUprIgQkOwL684S/vVo
         u1zuvSQ8oJLz/2hmDiUgGgoiT7nNAXubHiShEW1FWRKr8f4qAGGE5UJa6pWUj2Xp+t
         lbNe3/rYkWt6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8q51Y3748920;
        Mon, 22 Jul 2019 01:52:05 -0700
Date:   Mon, 22 Jul 2019 01:52:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hans de Goede <tipbot@zytor.com>
Message-ID: <tip-d02f1aa39189e0619c3525d5cd03254e61bf606a@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hdegoede@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190721152418.11644-1-hdegoede@redhat.com>
References: <20190721152418.11644-1-hdegoede@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/sysfb_efi: Add quirks for some devices with
 swapped width and height
Git-Commit-ID: d02f1aa39189e0619c3525d5cd03254e61bf606a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d02f1aa39189e0619c3525d5cd03254e61bf606a
Gitweb:     https://git.kernel.org/tip/d02f1aa39189e0619c3525d5cd03254e61bf606a
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Sun, 21 Jul 2019 17:24:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:47:11 +0200

x86/sysfb_efi: Add quirks for some devices with swapped width and height

Some Lenovo 2-in-1s with a detachable keyboard have a portrait screen but
advertise a landscape resolution and pitch, resulting in a messed up
display if the kernel tries to show anything on the efifb (because of the
wrong pitch).

Fix this by adding a new DMI match table for devices which need to have
their width and height swapped.

At first it was tried to use the existing table for overriding some of the
efifb parameters, but some of the affected devices have variants with
different LCD resolutions which will not work with hardcoded override
values.

Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1730783
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190721152418.11644-1-hdegoede@redhat.com

---
 arch/x86/kernel/sysfb_efi.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/kernel/sysfb_efi.c b/arch/x86/kernel/sysfb_efi.c
index 8eb67a670b10..653b7f617b61 100644
--- a/arch/x86/kernel/sysfb_efi.c
+++ b/arch/x86/kernel/sysfb_efi.c
@@ -230,9 +230,55 @@ static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
 	{},
 };
 
+/*
+ * Some devices have a portrait LCD but advertise a landscape resolution (and
+ * pitch). We simply swap width and height for these devices so that we can
+ * correctly deal with some of them coming with multiple resolutions.
+ */
+static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
+	{
+		/*
+		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
+		 * 800x1280 portrait screen. Luckily the portrait version has
+		 * its own BIOS version, so we match on that.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
+		},
+	},
+	{
+		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"Lenovo MIIX 320-10ICR"),
+		},
+	},
+	{
+		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
+					"Lenovo ideapad D330-10IGM"),
+		},
+	},
+	{},
+};
+
 __init void sysfb_apply_efi_quirks(void)
 {
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
 	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
 		dmi_check_system(efifb_dmi_system_table);
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	    dmi_check_system(efifb_dmi_swap_width_height)) {
+		u16 temp = screen_info.lfb_width;
+
+		screen_info.lfb_width = screen_info.lfb_height;
+		screen_info.lfb_height = temp;
+		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
+	}
 }
