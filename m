Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0413D41C23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 08:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfFLGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 02:22:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:39846 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730975AbfFLGWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:22:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 23:22:32 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 11 Jun 2019 23:22:26 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Jun 2019 09:22:25 +0300
Date:   Wed, 12 Jun 2019 09:22:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] iommu: Bounce page for untrusted devices
Message-ID: <20190612062225.GM2640@lahna.fi.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190610154241.GS28796@char.us.oracle.com>
 <cd66dab1-9a18-13c1-e668-417036e2dbc1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd66dab1-9a18-13c1-e668-417036e2dbc1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:00:06AM +0800, Lu Baolu wrote:
> > What kind of devices did you test it with?
> 
> Most test work was done by Xu Pengfei (cc'ed). He has run the code
> on real platforms with various thunderbolt peripherals (usb, disk,
> network, etc.).

In addtition to that we are also in works to build a real thunderclap
platform to verify it can only access the bounce buffer if the DMA
transfer was to a memory not filling the whole page.
