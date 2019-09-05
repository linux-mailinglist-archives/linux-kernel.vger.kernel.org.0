Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4368FA99D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfIEEzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 00:55:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:9365 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfIEEzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:55:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 21:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,469,1559545200"; 
   d="scan'208";a="199194458"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Sep 2019 21:55:34 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 05 Sep 2019 07:55:33 +0300
Date:   Thu, 5 Sep 2019 07:55:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Message-ID: <20190905045533.GS18521@lahna.fi.intel.com>
References: <d62dec18-fed4-7ac5-35c8-25f1be2201a9@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62dec18-fed4-7ac5-35c8-25f1be2201a9@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:15:24AM +0000, Jethro Beekman wrote:
> Now that SPI flash controllers without a software sequencer are
> supported, it's trivial to add support for CNL and its PCI ID.
> 
> Values from https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf
> 
> Signed-off-by: Jethro Beekman <jethro@fortanix.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
