Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A193AB61C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfIRKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 06:47:36 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:20877 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfIRKrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:47:36 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 10:47:35 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x8IAlY62003349
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Sep 2019 06:47:34 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x8IAlYH1003348;
        Wed, 18 Sep 2019 06:47:34 -0400
Date:   Wed, 18 Sep 2019 06:47:34 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Message-ID: <20190918104734.GA3320@people.danlj.org>
References: <cover.1568184581.git.benchuanggli@gmail.com>
 <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see that the first four patches made it into Linus's kernel
yesterday. Is there any chance of this final patch that actually
enables the hardware making it into another pull request still
intended for 5.4?  Waiting on additional acked-by on Ben's work
addressing all the review comments?

Thanks.

On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add support for the GL9750 and GL9755 chipsets.
> 
> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> tuning flow for GL9750.
