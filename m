Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECA512A6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 09:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLYIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 03:45:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:43783 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLYIpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 03:45:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 00:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="268590979"
Received: from yuxiyang-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.215.126])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Dec 2019 00:45:19 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1ik2IA-0000eL-CG; Wed, 25 Dec 2019 16:45:18 +0800
Date:   Wed, 25 Dec 2019 16:45:18 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Hui Zhu <teawater@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH for vm-scalability] usemem: Fix the build warning
Message-ID: <20191225084518.GA2140@wfg-t540p.sh.intel.com>
References: <1577262865-10253-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1577262865-10253-1-git-send-email-teawater@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks teawater!

>-	write(1, buf, len);
>+	if (write(1, buf, len) != len)
>+		printf("Output buf \"%s\" fail\n", buf);

Changed it to

                fprintf(stderr, "WARNING: statistics output may be incomplete.\n");

Thanks,
Fengguang
