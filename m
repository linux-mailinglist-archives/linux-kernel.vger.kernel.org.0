Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06397E540
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389389AbfHAWPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 18:15:51 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:42764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbfHAWPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:15:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4AA32181D3368;
        Thu,  1 Aug 2019 22:15:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:800:960:973:981:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3870:4250:4321:4605:5007:6119:10004:10400:10848:11026:11473:11657:11658:11914:12043:12296:12297:12438:12555:12760:12986:13439:13972:14096:14097:14181:14659:14721:21080:21451:21627:30003:30054:30069:30083,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:77,LUA_SUMMARY:none
X-HE-Tag: team64_6ceb6c0367758
X-Filterd-Recvd-Size: 3347
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 22:15:48 +0000 (UTC)
Message-ID: <6b34cae3ce39e82e1c3b241a2e4ee1e4d7fe3ab0.camel@perches.com>
Subject: [trivial PATCH] treewide: spelling funcitons -> functions
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 15:15:47 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the functions misspellings.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kernel/prom_init_check.sh              | 2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h | 2 +-
 drivers/net/usb/lg-vl600.c                          | 2 +-
 tools/perf/util/dwarf-aux.h                         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 160bef0d553d..b49d68c918c6 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -66,7 +66,7 @@ do
 		fi
 	done
 
-	# ignore register save/restore funcitons
+	# ignore register save/restore functions
 	case $UNDEF in
 	_restgpr_*|_restgpr0_*|_rest32gpr_*)
 		OK=1
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
index 73fe2f64491d..a5b8ac6a0a0b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -533,7 +533,7 @@ enum qlc_83xx_ext_regs {
 #define QLC_83XX_MULTI_TENANCY_INFO	BIT_29
 #define QLC_INIT_FW_RESOURCES		BIT_31
 
-/* 83xx funcitons */
+/* 83xx functions */
 int qlcnic_83xx_get_fw_version(struct qlcnic_adapter *);
 int qlcnic_83xx_issue_cmd(struct qlcnic_adapter *, struct qlcnic_cmd_args *);
 int qlcnic_83xx_setup_intr(struct qlcnic_adapter *);
diff --git a/drivers/net/usb/lg-vl600.c b/drivers/net/usb/lg-vl600.c
index 6c2b3e368efe..a058ec311147 100644
--- a/drivers/net/usb/lg-vl600.c
+++ b/drivers/net/usb/lg-vl600.c
@@ -31,7 +31,7 @@
  * Windows/Mac drivers do send a couple of such frames to the device
  * during initialisation, with protocol set to 0x0906 or 0x0b06 and (what
  * seems to be) a flag in the .dummy_flags.  This doesn't seem necessary
- * for modem operation but can possibly be used for GPS or other funcitons.
+ * for modem operation but can possibly be used for GPS or other functions.
  */
 
 struct vl600_frame_hdr {
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 0489b0cf8e2c..ddd9769ddb87 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -20,7 +20,7 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
 		     const char **fname, int *lineno);
 
-/* Walk on funcitons at given address */
+/* Walk on functions at given address */
 int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
 			 int (*callback)(Dwarf_Die *, void *), void *data);
 

