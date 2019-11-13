Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328A7FB0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 13:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKMM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 07:56:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:45031 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfKMM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:56:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 04:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="355461118"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2019 04:56:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iUsBk-0006TK-9U; Wed, 13 Nov 2019 20:56:00 +0800
Date:   Wed, 13 Nov 2019 20:55:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jon Flatley <jflat@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        bleung@chromium.org, groeck@chromium.org, sre@kernel.org,
        jflat@chromium.org
Subject: Re: [PATCH 3/3] platform: chrome: Added cros-ec-typec driver
Message-ID: <201911132033.3UoCbltt%lkp@intel.com>
References: <20191113031044.136232-4-jflat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113031044.136232-4-jflat@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ljones-mfd/for-mfd-next]
[cannot apply to v5.4-rc7 next-20191113]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Jon-Flatley/ChromeOS-EC-USB-C-Connector-Class/20191113-193504
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/platform/chrome/cros_ec_typec.c:223:9-16: ERROR: PTR_ERR applied after initialization to constant on line 222

vim +223 drivers/platform/chrome/cros_ec_typec.c

   206	
   207	static int cros_typec_add_partner(struct typec_data *typec, int port_num,
   208			bool pd_enabled)
   209	{
   210		struct port_data *port;
   211		struct typec_partner_desc p_desc;
   212		int ret;
   213	
   214		port = typec->ports[port_num];
   215		p_desc.usb_pd = pd_enabled;
   216		p_desc.identity = &port->p_identity;
   217	
   218		port->partner = typec_register_partner(port->port, &p_desc);
   219		if (IS_ERR_OR_NULL(port->partner)) {
   220			dev_err(typec->dev, "Port %d partner register failed\n",
   221					port_num);
 > 222			port->partner = NULL;
 > 223			return PTR_ERR(port->partner);
   224		}
   225	
   226		ret = cros_typec_query_pd_info(typec, port_num);
   227		if (ret < 0) {
   228			dev_err(typec->dev, "Port %d PD query failed\n", port_num);
   229			typec_unregister_partner(port->partner);
   230			port->partner = NULL;
   231			return ret;
   232		}
   233	
   234		ret = typec_partner_set_identity(port->partner);
   235		return ret;
   236	}
   237	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
