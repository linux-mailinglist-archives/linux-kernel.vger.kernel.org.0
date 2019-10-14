Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D800BD6762
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfJNQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 12:32:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:36487 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfJNQcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:32:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 09:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="198342481"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2019 09:32:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iK3H8-000Ebk-VG; Tue, 15 Oct 2019 00:32:50 +0800
Date:   Tue, 15 Oct 2019 00:32:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kbuild-all@lists.01.org, catalin.marinas@arm.com,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, mripard@kernel.org,
        robh+dt@kernel.org, wens@csie.org, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [RFC PATCH] crypto: sun8i_ce_pm_ops can be static
Message-ID: <20191014163243.ijpkv4uyszse32lw@332d0cec05f4>
References: <20191012184852.28329-3-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012184852.28329-3-clabbe.montjoie@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: f113059e7b4f ("crypto: Add Allwinner sun8i-ce Crypto Engine")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 sun8i-ce-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 77e9cb0cc6eea..a08f0e7a29752 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -412,7 +412,7 @@ static int sun8i_ce_pm_resume(struct device *dev)
 	return err;
 }
 
-const struct dev_pm_ops sun8i_ce_pm_ops = {
+static const struct dev_pm_ops sun8i_ce_pm_ops = {
 	SET_RUNTIME_PM_OPS(sun8i_ce_pm_suspend, sun8i_ce_pm_resume, NULL)
 };
 
